---
layout: post
title: "urlencoded"
date: 2025-05-09 09:00:19 +0900
categories: []
tags: [express]
---

여기에 포스트 내용을 작성하세요.

좋아, 바로 설명할게.

```javascript
app.use(express.urlencoded({ extended: false }));
```

여기서 `express.urlencoded`는 **POST 요청** 같은 데서 \*\*폼 데이터(form data)\*\*를
`req.body` 안에 **읽을 수 있게 변환**해주는 미들웨어야.

---

### 그럼 `extended: false`가 뭐냐?

- `extended: false`
  👉 **`querystring` 모듈**을 써서
  👉 **단순한 객체**로만 `req.body`를 파싱함.

- `extended: true`
  👉 **`qs` 모듈**을 써서
  👉 **중첩된 객체**(object 안에 object)도 파싱할 수 있음.

---

### 쉽게 예시로 볼게

**폼 데이터가 이렇게 생겼을 때:**

```
name=kim&age=20
```

- `extended: false`든 `true`든 둘 다 이렇게 파싱돼:

  ```javascript
  { name: 'kim', age: '20' }
  ```

**그런데 복잡한 데이터:**

```
user[name]=kim&user[age]=20
```

- `extended: false` ➔ **이걸 못 제대로 해석함**
- `extended: true` ➔ **이걸 제대로 객체로 만들어줌**:

  ```javascript
  { user: { name: 'kim', age: '20' } }
  ```

---

### 정리

| 옵션              | 동작                    | 특징                                     |
| :---------------- | :---------------------- | :--------------------------------------- |
| `extended: false` | 단순한 key=value만 파싱 | 빠르고 가벼움 (내장 querystring 사용)    |
| `extended: true`  | 중첩 객체까지 파싱      | 복잡한 데이터도 해석 가능 (qs 모듈 사용) |

---

### 결론

- **간단한 폼 데이터만 쓸 거면** `false`로 충분해.
- **복잡한 객체를 폼에 담을 거면** `true`로 하는 게 좋아.

---

**추가로 궁금한 거 있어?**
예를 들면 `qs` 모듈이 뭔지, 아니면 직접 한 번 데이터 만들어서 테스트해볼 수도 있어! 🔥
해볼래? (폼 데이터 직접 만들어서 비교해보는 거 추천!)

좋아, 바로 실습 가자! 🏃

---

**1. 서버 세팅**

아주 간단한 Express 서버 하나 만들자.
`app.js` 파일에 이렇게:

```javascript
const express = require("express");
const app = express();
const port = 3000;

app.use(express.urlencoded({ extended: false })); // 여기 false로 먼저

app.post("/test", (req, res) => {
  console.log(req.body);
  res.send("받음");
});

app.listen(port, () => {
  console.log(`서버 열림: http://localhost:${port}`);
});
```

**➡️ 서버 켜! (`node app.js`)**

---

**2. 포스트맨 테스트**

**POST** 요청 보내기:
URL : `http://localhost:3000/test`

- **Body ➔ x-www-form-urlencoded** 선택하고
- 이렇게 데이터 넣기:

| KEY         | VALUE |
| :---------- | :---- |
| user\[name] | kim   |
| user\[age]  | 20    |

**요청 보내!**

---

**3. 결과 확인**

- `extended: false`이면 콘솔에 이렇게 찍힐 거야:

  ```javascript
  { 'user[name]': 'kim', 'user[age]': '20' }
  ```

👉 **user라는 객체로 합쳐지지 않음!** (그냥 문자 key로 들어감)

---

**4. 바꿔보자**

이제 서버 코드를 바꿔!

```javascript
app.use(express.urlencoded({ extended: true })); // true로 변경
```

서버 다시 껐다가 켜고, 다시 포스트맨 요청 보내.

**이번에는 콘솔에 이렇게 나올 거야:**

```javascript
{
  user: { name: 'kim', age: '20' }
}
```

✅ **`user`라는 객체 안에 name과 age가 정리되어 있음!!**

---

### 요약

| 설정              | 결과                                                   |
| :---------------- | :----------------------------------------------------- |
| `extended: false` | `user[name]` 같은 key로 들어옴 (객체로 안 묶임)        |
| `extended: true`  | user라는 객체 안에 {name: 'kim', age: '20'}처럼 파싱됨 |

---

필요하면 내가 포스트맨 스크린샷 예시도 그려줄게!
**한 번 직접 테스트 해봤어?** ✨
(아니면 바로 다음 심화 주제 `qs 모듈` 설명으로 넘어갈까?)

좋아, 정확하게 어디서 문제가 생긴 건지 바로 잡아줄게.
**지금 오류**는 **body에 JSON을 보낸 방법**이 잘못돼서 그래.

---

## 1. 문제 정리

너가 보낸 **body**를 보면:

```json
{
  "name": "aaa",
  "age": 20
}
```

이렇게 보냈지?

**문제점:**

- JSON은 **key랑 value** 모두 **쌍따옴표** `" "` 를 써야 해.
- `' '` (홑따옴표)는 **JSON 표준**에서 **허용 안 함**.

**즉, 올바른 JSON은** 이렇게 써야 한다:

```json
{
  "name": "aaa",
  "age": 20
}
```

---

## 2. 왜 400 에러가 나는가?

- `express.json()` 미들웨어는 요청 body를 JSON으로 **파싱**하려고 하는데
- 홑따옴표 `' '`를 만나니까 **JSON.parse()** 단계에서 실패하고 → `SyntaxError` 발생 → 400 응답.

---

## 3. 해결 방법 (Postman 설정)

**Postman에서 보낼 때** 이렇게 하면 됨:

1. **Body** → **raw** → **JSON** 선택
2. 보내는 데이터는 꼭 쌍따옴표로:

```json
{
  "name": "aaa",
  "age": 20
}
```

**또는**

- Axios나 fetch 쓸 때도 이렇게 보내야 해:

```js
axios.post("/test", {
  name: "aaa",
  age: 20,
});
```

(axios는 내부적으로 자동으로 `"Content-Type: application/json"` 맞춰줌)

---

## 4. 요약

| 문제                                    | 해결                                        |
| :-------------------------------------- | :------------------------------------------ |
| body에서 홑따옴표 사용                  | 쌍따옴표로 수정해야 함                      |
| Content-Type이 application/json 아니면? | 직접 설정하거나 raw JSON 형식으로 보내야 함 |

---

## 🔥 정리

- JSON은 무조건 `"` 쌍따옴표
- Postman은 **Body → raw → JSON** 선택
- 서버는 `express.json()` 미들웨어 등록되어 있어야 함

---

필요하면 내가 **Postman 설정 스크린샷**도 바로 보여줄 수 있어.
**👉 Postman 화면 설정도 보고 싶어? (네/아니오)** 🔥
(빠르게 같이 맞춰보자!)

---

## 1. JSON 표준 (RFC 8259)

- JSON은 공식적으로 **RFC 8259**라는 국제 표준 문서에 정의돼 있어.
- 여기서 **명시**돼 있어:

> JSON의 객체(Object)의 키(key)는 반드시 **쌍따옴표("")로 감싼 문자열**이어야 한다.

✅ 예시 (올바름):

```json
{
  "name": "aaa",
  "age": 20
}
```

❌ 예시 (틀림):

```json
{
  "name": "aaa",
  "age": 20
}
```

**이유:**

- JSON은 원래 **JavaScript 문법을 "제한"해서 만든 데이터 포맷**이야.
- JavaScript는 `var obj = { name: 'aaa' };` 이렇게 써도 되지만,
  JSON은 데이터를 **언어에 상관없이 교환**하려고 만든 거라,
  **모든 시스템이 일관성 있게 해석**할 수 있도록 **쌍따옴표**를 강제함.

즉, **Python, Java, C#, Go** 같은 언어에서도 JSON을 똑같이 읽을 수 있도록 강제한 규칙이야.

---

## 2. 쉽게 말하면

- `'` 홑따옴표는 **JavaScript에서는 허용**되지만
- **JSON 데이터 포맷** 자체는 **"\`" (쌍따옴표)만 공식 허용**됨.

그래야 **다른 언어, 다른 플랫폼**에서도 통신할 때 **문제 없이 파싱**할 수 있어.

---

## 3. 정리

| 구분            | 쌍따옴표 `"` | 홑따옴표 `'`  |
| :-------------- | :----------- | :------------ |
| JSON 표준       | O (필수)     | X (파싱 실패) |
| JavaScript 객체 | O            | O             |

---

## 4. 출처 (신뢰성)

- [RFC 8259 - The JavaScript Object Notation (JSON) Data Interchange Format](https://www.rfc-editor.org/rfc/rfc8259#section-7)

> A JSON parser MUST accept objects with keys enclosed in double quotes.

---

### ✏️ 요약 한줄

> JSON은 전 세계 모든 시스템이 똑같이 이해할 수 있게 하려고 무조건 쌍따옴표를 강제한다.

---

**추가로**

> "JavaScript에서는 둘 다 되는데 JSON은 왜 제한했냐?"
> 이거 궁금하면 더 심화해서 설명해줄게! (필요하면 알려줘)

**👉 계속 심화 설명 들을래? (네/아니오)** 🔥
(예시 코드도 같이 준비해줄게)

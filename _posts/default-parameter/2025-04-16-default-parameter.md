---
layout: post
title: "default parameter"
date: 2025-04-16 21:44:44 +0900
categories: [es6]
tags: []
---
 **"기본값 매개변수 (default parameters)"** 라고 부르는 문법이고, **ES6 (2015년)**부터 도입된 **표준 JavaScript 기능**이야.

---

##  기본값 매개변수란?

```js
function sayHello(name = '익명') {
  console.log(`안녕하세요, ${name}`);
}

sayHello(); // 👉 안녕하세요, 익명
sayHello('지민'); // 👉 안녕하세요, 지민
```

- 함수에 인자를 안 넘겼을 때 자동으로 `'익명'`이 사용돼.
- 타입스크립트처럼 **타입을 정해주는 게 아니라**, 그냥 **값이 없을 때 대체할 기본값을 넣는 것뿐이야.**

---

##  오해 방지: 이건 TypeScript 아님

| 코드 예시 | TypeScript인가? | 설명 |
|-----------|------------------|------|
| `(cookie = '')` | ❌ | JavaScript의 기본값 |
| `(cookie: string)` | ✅ | TypeScript (타입 명시) |
| `(cookie: string = '')` | ✅ | TypeScript에서 기본값 + 타입 지정 |

---

##  그래서 왜 이렇게 쓰냐?

`cookie` 값을 `req.headers.cookie`에서 가져오는데, 이 값은 **`undefined`일 수 있음**.  
그래서 에러 방지를 위해 기본값으로 `''` (빈 문자열)을 설정해주는 거야.

```js
const cookies = parseCookies(req.headers.cookie); 
// 만약 req.headers.cookie가 undefined면? -> parseCookies(undefined) -> cookie = ''
```

---

## 정리

- `cookie = ''`은 **타입 설정이 아니라, 값이 없을 때 쓸 기본값을 지정한 것**
- TypeScript와 헷갈릴 수 있지만, 이건 **순수 JavaScript 문법**
- 에러 방지를 위해 자주 쓰이는 안전한 패턴이야

---
아주 좋아요!  
**"계산된 프로퍼티(Computed Property)"**랑 **"디폴트 파라미터(Default Parameter)"**는 **완전히 다른 개념**이에요 — 이름이 비슷해서 헷갈릴 수 있지만, 목적과 위치가 달라요. 아래 표와 함께 비교해볼게요!

---

## ✅ 개념 비교 요약

| 구분 | 계산된 프로퍼티 (Computed Property) | 디폴트 파라미터 (Default Parameter) |
|------|-------------------------------------|--------------------------------------|
| 🔍 무엇인가요? | 객체의 키를 변수나 표현식으로 동적으로 지정 | 함수 파라미터에 기본값을 지정 |
| 📍 쓰는 위치 | 객체를 만들 때 속성 키 부분 | 함수 선언에서 파라미터 부분 |
| 🧠 주 용도 | 동적으로 객체 키 이름 만들기 | 인자가 안 들어왔을 때 기본값 주기 |

---

## 📌 예제 비교

### 🎯 계산된 프로퍼티

```js
const key = 'name';
const value = 'paul';

const obj = {
  [key]: value,
};

console.log(obj); // { name: 'paul' }
```

> `[key]` ← 이게 계산된 프로퍼티! `key`라는 변수가 `"name"` 값을 가지니까  
> `obj = { name: 'paul' }` 처럼 동작합니다.

---

### 🎯 디폴트 파라미터

```js
function greet(name = '익명') {
  console.log(`${name}님 안녕하세요`);
}

greet('수지');   // 수지님 안녕하세요
greet();        // 익명님 안녕하세요
```

> `name = '익명'` ← 이게 디폴트 파라미터!  
> 함수에 인자를 안 넘기면 자동으로 `'익명'`이 들어가요.

---

## 🎓 언제 쓰나요?

- 계산된 프로퍼티 → 객체 속성 키를 동적으로 만들고 싶을 때
  ```js
  const lang = 'ko';
  const greetings = {
    [lang]: '안녕하세요',  // 'ko': '안녕하세요'
  };
  ```

- 디폴트 파라미터 → 함수 호출 시, 값이 없을 때 기본값 주고 싶을 때
  ```js
  function makeSession(name = 'guest') {
    return { name };
  }
  ```

---

## ✨ 한 문장 요약

> **계산된 프로퍼티**는 객체 **키에 변수/표현식**을 쓸 수 있게 해주는 문법이고,  
> **디폴트 파라미터**는 함수 **매개변수가 비었을 때 기본값**을 지정해주는 문법입니다.

---

궁금하다면 둘을 섞어서 쓰는 실전 예제도 보여줄게요!  
예를 들어 세션 만들면서 동적으로 키 만들고, 이름 없으면 기본값 넣는 식으로요 😄  
필요하시면 말해주세요!

---

좋습니다! 지금까지 배운 걸 다 모아서  
**계산된 프로퍼티 + 디폴트 파라미터 + 쿠키 세션 로그인 서버** 예제를 만들어볼게요 😎  

---

## 🌐 목표 기능

- `http://localhost:8080/login?name=paul` 으로 접속하면
  - 랜덤 세션 ID 생성
  - `Set-Cookie: session=세션ID` 헤더로 전송
  - 세션 객체에 사용자 정보 저장 (`{ 세션ID: { name, expires } }`)
- 이후 메인 페이지에 접속하면
  - 세션 쿠키 확인해서 사용자 이름 보여줌
- 이름을 안 넣고 `/login`만 하면 기본값 `guest`로 처리

---

## ✅ 예제 코드 (`server.js`)

```js
const http = require('http');
const url = require('url');
const qs = require('querystring');

const parseCookies = (cookie = '') =>
  cookie
    .split(';')
    .map(v => v.split('='))
    .map(([key, ...val]) => [key.trim(), decodeURIComponent(val.join('='))])
    .reduce((acc, [k, v]) => {
      acc[k] = v;
      return acc;
    }, {});

const session = {};

http.createServer((req, res) => {
  const cookies = parseCookies(req.headers.cookie);
  const { pathname, query } = url.parse(req.url);
  
  if (pathname === '/login') {
    const { name = 'guest' } = qs.parse(query); // 💡 디폴트 파라미터처럼 query에서 기본값
    const sessionId = Date.now() + Math.random(); // 세션 ID
    const expires = new Date(Date.now() + 5 * 60 * 1000); // 5분 후 만료

    // 💡 계산된 프로퍼티: session[sessionId] = ...
    session[sessionId] = {
      name,
      expires,
    };

    res.writeHead(302, {
      Location: '/',
      'Set-Cookie': `session=${sessionId}; Expires=${expires.toUTCString()}; HttpOnly; Path=/`,
    });
    res.end();

  } else if (cookies.session && session[cookies.session] && session[cookies.session].expires > new Date()) {
    // 쿠키에 세션 ID가 있고, 세션이 유효하다면
    res.writeHead(200, { 'Content-Type': 'text/html; charset=utf-8' });
    res.end(`${session[cookies.session].name}님 안녕하세요`);
  } else {
    // 로그인 안 됐거나 세션 만료
    res.writeHead(200, { 'Content-Type': 'text/html; charset=utf-8' });
    res.end(`
      <form action="/login" method="GET">
        <input type="text" name="name" placeholder="이름 입력" />
        <button type="submit">로그인</button>
      </form>
    `);
  }
}).listen(8080, () => {
  console.log('http://localhost:8080 서버 시작됨');
});
```

---

## 🔍 테스트 시나리오

1. 브라우저에서 `http://localhost:8080` 접속
   → 로그인 폼 나옴
2. `http://localhost:8080/login?name=paul` 접속
   → 세션 생성, 쿠키 발급, `/`로 리다이렉트
3. `/` 다시 접속하면
   → `paul님 안녕하세요` 출력됨
4. `http://localhost:8080/login` 접속 (이름 생략)
   → `guest님 안녕하세요`

---

## 🧠 요약 문법 포인트

- **`session[sessionId] = ...`**: 계산된 프로퍼티
- **`const { name = 'guest' } = ...`**: 디폴트 파라미터 스타일 구조 분해
- **`Set-Cookie`** + `HttpOnly`로 세션 관리

---

이 서버로도 세션 관리 기초는 충분히 체험 가능해요!  
이걸 파일에 저장해서 돌려봐도 되고, 쿠키 만료되면 자동으로 다시 로그인 유도돼요.

원한다면 이 구조를 기반으로:
- 로그아웃 기능
- 세션 자동 정리
- HTML 템플릿 분리

도 확장 가능해요.

원하시면 다음 단계도 같이 가요 😄
---
layout: post
title: "localCompare"
date: 2024-11-06 18:51:19 +0900
categories: []
tags: [javascript]
---

JavaScript의 `localeCompare`는 문자열을 특정 로케일에 맞춰 비교할 때 유용하게 사용할 수 있는 메서드입니다. 이 메서드는 주로 문자열을 사전 순서로 정렬하거나 특정 언어의 문법 및 알파벳 순서를 반영하여 비교할 때 사용됩니다. 아래에서는 `localeCompare`의 기본 사용법부터 고급 옵션들까지 살펴보겠습니다.

---

### JavaScript `localeCompare`란?

`localeCompare` 메서드는 JavaScript 문자열 메서드 중 하나로, 두 문자열을 비교하여 **정렬에 사용할 수 있는 값**을 반환합니다. 이 메서드는 로케일(언어 및 지역 설정)을 기반으로 비교하므로, 다양한 언어 및 문화권에 맞는 문자열 비교를 수행할 수 있습니다.

### `localeCompare` 기본 문법

`localeCompare` 메서드의 기본 구문은 다음과 같습니다:

```javascript
string1.localeCompare(string2, [locales, [options]]);
```

#### 매개변수 설명

- **string2**: 비교 대상이 되는 문자열입니다.
- **locales** _(선택 사항)_: 문자열 비교에 사용할 로케일입니다. 예를 들어 `"en"`은 영어를, `"ko"`는 한국어를 의미합니다.
- **options** _(선택 사항)_: 비교 방법을 세부적으로 설정할 수 있는 옵션 객체입니다.

### `localeCompare`의 반환값

`localeCompare`는 비교 결과를 다음과 같이 세 가지 숫자 중 하나로 반환합니다:

- **-1**: 호출한 문자열이 `string2`보다 앞에 있음
- **0**: 두 문자열이 동일함
- **1**: 호출한 문자열이 `string2`보다 뒤에 있음

### 기본 사용 예시

```javascript
const str1 = "apple";
const str2 = "banana";

console.log(str1.localeCompare(str2)); // -1 (str1이 str2보다 사전적으로 앞에 있음)
```

위 코드에서 `"apple"`이 `"banana"`보다 앞에 있으므로 `-1`이 반환됩니다.

### 로케일 옵션 활용하기

로케일을 지정하면 언어 및 지역별로 맞춤형 비교가 가능합니다. 예를 들어, 독일어(`de`)와 스웨덴어(`sv`)에서 "ä" 문자의 위치는 다릅니다.

```javascript
console.log("ä".localeCompare("z", "de")); // -1 (독일어 기준)
console.log("ä".localeCompare("z", "sv")); // 1 (스웨덴어 기준)
```

독일어에서는 "ä"가 "z"보다 앞에 위치하지만, 스웨덴어에서는 그 반대입니다.

### 옵션을 활용한 고급 설정

`localeCompare` 메서드는 다양한 비교 설정이 가능한 옵션 객체를 지원합니다. 주요 옵션에는 **sensitivity**, **ignorePunctuation**, **numeric** 등이 있습니다.

1. **sensitivity**: 대소문자, 악센트 구별을 설정합니다.

   - `"base"`: 기본 문자만 비교 (`a`와 `A`가 같음).
   - `"accent"`: 악센트 차이만 구별함 (`a`와 `á`가 다름).
   - `"case"`: 대소문자만 구별함 (`a`와 `A`가 다름).
   - `"variant"`: 대소문자와 악센트 모두 구별함.

   ```javascript
   console.log("a".localeCompare("A", undefined, { sensitivity: "base" })); // 0
   console.log("a".localeCompare("A", undefined, { sensitivity: "case" })); // -1
   ```

2. **ignorePunctuation**: 문장 부호를 무시할지 설정합니다.

   ```javascript
   console.log(
     "apple!".localeCompare("apple", undefined, { ignorePunctuation: true })
   ); // 0
   ```

3. **numeric**: 숫자가 포함된 문자열을 숫자 크기에 맞게 정렬할지 설정합니다. 기본적으로 `"10"`은 `"2"`보다 앞에 오지만, 이 옵션을 `true`로 설정하면 **숫자 크기**로 비교합니다.

   ```javascript
   console.log("10".localeCompare("2")); // 1 (문자열 비교 기준)
   console.log("10".localeCompare("2", undefined, { numeric: true })); // -1 (숫자 비교 기준)
   ```

### `localeCompare`를 이용한 정렬 예시

`localeCompare`는 주로 배열의 문자열을 정렬할 때 유용하게 사용됩니다. 아래는 대소문자를 구분하지 않고 문자열을 알파벳 순서로 정렬하는 예제입니다.

```javascript
const fruits = ["Banana", "apple", "Cherry"];
fruits.sort((a, b) => a.localeCompare(b, undefined, { sensitivity: "base" }));

console.log(fruits); // ["apple", "Banana", "Cherry"]
```

### 정리

JavaScript의 `localeCompare`는 로케일에 맞는 문자열 비교를 지원하여 사전적인 정렬이나 언어별로 특수 문자가 포함된 문자열을 정확하게 비교할 때 유용합니다. 옵션을 잘 활용하면 대소문자 구별, 악센트 처리, 숫자 비교까지 제어할 수 있으니, 국제화(i18n)를 고려한 애플리케이션에서 유용하게 사용할 수 있습니다.

`localeCompare`는 단순한 문자열 비교 이상의 기능을 제공하므로, 다양한 로케일과 특수 문자가 포함된 데이터를 다룰 때 적극적으로 활용해 보세요!

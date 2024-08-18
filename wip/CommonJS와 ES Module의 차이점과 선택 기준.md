CommonJS와 ES Module의 차이점과 선택 기준

2024-05-23
AI가 제공하는 얕고 넓은 지식을 위한 짤막한 글입니다!

CommonJS와 ES Module의 차이점과 선택 기준
JavaScript 모듈 시스템은 크게 CommonJS와 ES Module(ESM)로 나뉩니다. CommonJS는 Node.js 환경에서 주로 사용되며, require()와 module.exports를 사용하여 모듈을 가져오고 내보냅니다. 반면, ES Module은 최신 JavaScript 표준으로, import와 export 키워드를 사용합니다.

CommonJS는 동기적으로 모듈을 로드하는 반면, ES Module은 비동기적으로 로드합니다. 이는 ES Module이 브라우저 환경에서도 사용될 수 있도록 설계되었기 때문입니다. 왜냐하면 브라우저 환경에서는 비동기 로드가 필수적이기 때문입니다.

CommonJS는 트리 셰이킹(Tree Shaking)이 어렵다는 단점이 있습니다. 트리 셰이킹은 사용되지 않는 코드를 제거하여 번들 크기를 줄이는 기술입니다. 반면, ES Module은 트리 셰이킹이 용이합니다. 왜냐하면 ES Module은 정적 분석이 가능하기 때문입니다.

따라서, 프로젝트의 요구사항과 환경에 따라 적절한 모듈 시스템을 선택하는 것이 중요합니다. 왜냐하면 각 모듈 시스템이 제공하는 기능과 성능이 다르기 때문입니다.

이 글에서는 CommonJS와 ES Module의 차이점과 선택 기준에 대해 자세히 알아보겠습니다.

CommonJS의 특징
CommonJS는 Node.js 환경에서 주로 사용되는 모듈 시스템입니다. require() 함수를 사용하여 모듈을 가져오고, module.exports를 사용하여 모듈을 내보냅니다. 이는 동기적으로 작동하며, 모듈이 로드될 때까지 코드 실행이 중단됩니다.

CommonJS는 동기적 로드 방식을 사용하기 때문에, 서버 사이드 렌더링과 같은 환경에서 유리합니다. 왜냐하면 서버 사이드에서는 모든 모듈이 로드된 후에야 코드가 실행되기 때문입니다.

하지만, CommonJS는 트리 셰이킹이 어렵다는 단점이 있습니다. 이는 사용되지 않는 코드를 제거하기 어렵게 만듭니다. 왜냐하면 CommonJS는 동적 로드를 지원하기 때문입니다.

또한, CommonJS는 브라우저 환경에서 사용하기 어렵습니다. 브라우저에서는 비동기 로드가 필수적이기 때문입니다. 따라서, 브라우저 환경에서는 ES Module을 사용하는 것이 더 적합합니다.

다음은 CommonJS의 예제 코드입니다:

const moduleA = require('./moduleA');

moduleA.sayHello();

module.exports = {
sayHello: function() {
console.log('Hello from CommonJS');
}
};

ES Module의 특징
ES Module(ESM)은 최신 JavaScript 표준으로, import와 export 키워드를 사용하여 모듈을 가져오고 내보냅니다. 이는 비동기적으로 작동하며, 브라우저 환경에서도 사용될 수 있도록 설계되었습니다.

ESM은 정적 분석이 가능하기 때문에, 트리 셰이킹이 용이합니다. 이는 사용되지 않는 코드를 제거하여 번들 크기를 줄이는 데 유리합니다. 왜냐하면 ESM은 모듈의 의존성을 정적으로 분석할 수 있기 때문입니다.

또한, ESM은 브라우저 환경에서 비동기 로드를 지원합니다. 이는 브라우저에서 모듈을 로드할 때 페이지 로딩 속도를 저하시키지 않기 때문에 중요합니다.

ESM은 import와 export 키워드를 사용하여 모듈을 가져오고 내보냅니다. 이는 코드의 가독성을 높이고, 모듈 간의 의존성을 명확하게 합니다.

다음은 ESM의 예제 코드입니다:

import { sayHello } from './moduleA';

sayHello();

export function sayHello() {
console.log('Hello from ES Module');
}

CommonJS와 ES Module의 선택 기준
프로젝트의 요구사항과 환경에 따라 적절한 모듈 시스템을 선택하는 것이 중요합니다. CommonJS는 서버 사이드 렌더링과 같은 환경에서 유리하며, 동기적 로드 방식을 사용합니다. 반면, ES Module은 브라우저 환경에서 유리하며, 비동기적 로드 방식을 사용합니다.

CommonJS는 트리 셰이킹이 어렵다는 단점이 있지만, ES Module은 트리 셰이킹이 용이합니다. 이는 사용되지 않는 코드를 제거하여 번들 크기를 줄이는 데 유리합니다. 왜냐하면 ESM은 정적 분석이 가능하기 때문입니다.

또한, CommonJS는 require()와 module.exports를 사용하여 모듈을 가져오고 내보내지만, ES Module은 import와 export 키워드를 사용합니다. 이는 코드의 가독성을 높이고, 모듈 간의 의존성을 명확하게 합니다.

따라서, 프로젝트의 요구사항과 환경에 따라 적절한 모듈 시스템을 선택하는 것이 중요합니다. 왜냐하면 각 모듈 시스템이 제공하는 기능과 성능이 다르기 때문입니다.

다음은 CommonJS와 ES Module의 선택 기준을 요약한 표입니다:

| 특징        | CommonJS         | ES Module      |
| ----------- | ---------------- | -------------- |
| 로드 방식   | 동기적           | 비동기적       |
| 트리 셰이킹 | 어려움           | 용이           |
| 사용 환경   | 서버 사이드      | 브라우저       |
| 키워드      | require, exports | import, export |

CommonJS와 ES Module의 통합
최근에는 CommonJS와 ES Module을 모두 지원하는 라이브러리가 많이 등장하고 있습니다. 이는 두 모듈 시스템의 장점을 모두 활용할 수 있도록 합니다. 왜냐하면 각 모듈 시스템이 제공하는 기능과 성능이 다르기 때문입니다.

Webpack과 같은 번들러를 사용하면, CommonJS와 ES Module을 모두 지원하는 번들을 생성할 수 있습니다. 이는 프로젝트의 호환성을 높이고, 다양한 환경에서 사용할 수 있도록 합니다.

다음은 Webpack을 사용하여 CommonJS와 ES Module을 모두 지원하는 번들을 생성하는 예제입니다:

module.exports = {
entry: './src/index.js',
output: {
filename: 'bundle.js',
libraryTarget: 'umd',
},
module: {
rules: [
{
test: /\.js$/,
exclude: /node_modules/,
use: {
loader: 'babel-loader',
},
},
],
},
};
위 예제에서는 Webpack을 사용하여 CommonJS와 ES Module을 모두 지원하는 번들을 생성합니다. libraryTarget을 'umd'로 설정하여, UMD(Universal Module Definition) 형식으로 번들을 생성합니다. 이는 CommonJS와 ES Module을 모두 지원합니다.

따라서, 프로젝트의 요구사항과 환경에 따라 적절한 모듈 시스템을 선택하고, 필요에 따라 두 모듈 시스템을 통합하여 사용할 수 있습니다. 왜냐하면 각 모듈 시스템이 제공하는 기능과 성능이 다르기 때문입니다.

이 글에서는 CommonJS와 ES Module의 통합 방법에 대해 알아보았습니다.

결론
JavaScript 모듈 시스템은 크게 CommonJS와 ES Module로 나뉩니다. CommonJS는 Node.js 환경에서 주로 사용되며, require()와 module.exports를 사용하여 모듈을 가져오고 내보냅니다. 반면, ES Module은 최신 JavaScript 표준으로, import와 export 키워드를 사용합니다.

CommonJS는 동기적으로 모듈을 로드하는 반면, ES Module은 비동기적으로 로드합니다. 이는 ES Module이 브라우저 환경에서도 사용될 수 있도록 설계되었기 때문입니다. 왜냐하면 브라우저 환경에서는 비동기 로드가 필수적이기 때문입니다.

CommonJS는 트리 셰이킹이 어렵다는 단점이 있습니다. 트리 셰이킹은 사용되지 않는 코드를 제거하여 번들 크기를 줄이는 기술입니다. 반면, ES Module은 트리 셰이킹이 용이합니다. 왜냐하면 ES Module은 정적 분석이 가능하기 때문입니다.

따라서, 프로젝트의 요구사항과 환경에 따라 적절한 모듈 시스템을 선택하는 것이 중요합니다. 왜냐하면 각 모듈 시스템이 제공하는 기능과 성능이 다르기 때문입니다.

이 글에서는 CommonJS와 ES Module의 차이점과 선택 기준, 그리고 통합 방법에 대해 알아보았습니다. 이를 통해, 프로젝트에 적합한 모듈 시스템을 선택하고, 효율적으로 사용할 수 있을 것입니다.

---

ES 모듈(ESM)과 CommonJS 모듈은 JavaScript에서 모듈화된 코드를 작성하고 가져오는 두 가지 주요 시스템입니다. 각 시스템은 다른 환경에서 발전했으며, 서로 다른 방식으로 모듈을 정의하고 가져옵니다.

### ES 모듈 (ECMAScript Modules, ESM)

1. **구문(Syntax)**

   - **내보내기(export)**:

     ```javascript
     // Named exports
     export const myVar = 42;
     export function myFunction() {
       console.log("Hello from myFunction!");
     }

     // Default export
     export default function () {
       console.log("Hello from default export!");
     }
     ```

   - **가져오기(import)**:

     ```javascript
     // Named imports
     import { myVar, myFunction } from "./module.js";

     // Default import
     import myDefaultFunction from "./module.js";

     // 모든 내용 가져오기
     import * as myModule from "./module.js";
     ```

2. **비동기 로딩**

   - 브라우저 환경에서 모듈을 비동기적으로 로드할 수 있으며, 이는 페이지 로드 성능을 향상시킬 수 있습니다.

3. **정적 구조**

   - `import`와 `export` 구문은 파일의 최상위 레벨에서만 사용 가능하며, 컴파일 타임에 종속성을 결정할 수 있습니다.

4. **엄격 모드**

   - 모든 ES 모듈은 기본적으로 엄격 모드로 실행됩니다.

5. **브라우저 및 Node.js 지원**
   - 최신 브라우저와 Node.js에서 기본적으로 지원됩니다.

### CommonJS 모듈

1. **구문(Syntax)**

   - **내보내기(module.exports, exports)**:

     ```javascript
     // Named exports
     const myVar = 42;
     const myFunction = () => {
       console.log("Hello from myFunction!");
     };
     module.exports = { myVar, myFunction };

     // Default export
     module.exports = function () {
       console.log("Hello from default export!");
     };
     ```

   - **가져오기(require)**:

     ```javascript
     // Named imports
     const { myVar, myFunction } = require("./module");

     // Default import
     const myDefaultFunction = require("./module");
     ```

2. **동기 로딩**

   - `require` 호출은 동기적으로 모듈을 로드합니다. 이는 파일을 즉시 읽고 실행하지만, 큰 모듈에서는 블로킹 이슈가 발생할 수 있습니다.

3. **동적 구조**

   - `require`는 함수 호출이므로, 조건문 내부나 함수 내부에서 동적으로 모듈을 로드할 수 있습니다.

4. **비엄격 모드**

   - CommonJS 모듈은 기본적으로 엄격 모드가 아닙니다. 하지만 필요 시 'use strict';를 사용하여 엄격 모드로 설정할 수 있습니다.

5. **Node.js 환경에서 주로 사용**
   - CommonJS는 Node.js에서 기본 모듈 시스템으로 사용되며, 브라우저 환경에서는 별도의 번들러(예: Browserify)를 사용해야 합니다.

### 차이점 요약

- **구문(Syntax)**: ESM은 `import`와 `export`를 사용하고, CommonJS는 `require`와 `module.exports`/`exports`를 사용합니다.
- **로딩 방식**: ESM은 비동기적으로 로드할 수 있으며, CommonJS는 동기적으로 로드합니다.
- **정적 vs 동적**: ESM은 정적 구조로 컴파일 타임에 종속성을 확인할 수 있고, CommonJS는 동적 구조로 런타임에 모듈을 로드할 수 있습니다.
- **엄격 모드**: ESM은 기본적으로 엄격 모드로 실행되고, CommonJS는 비엄격 모드로 실행됩니다.
- **지원 환경**: ESM은 최신 브라우저와 Node.js에서 기본적으로 지원되며, CommonJS는 Node.js에서 기본 모듈 시스템으로 사용됩니다.

### 예제 비교

#### ESM 예제

모듈 파일 (`module.js`):

```javascript
export const myVar = 42;
export function myFunction() {
  console.log("Hello from myFunction!");
}
export default function () {
  console.log("Hello from default export!");
}
```

가져오기 파일 (`main.js`):

```javascript
import { myVar, myFunction } from "./module.js";
import myDefaultFunction from "./module.js";

console.log(myVar); // 42
myFunction(); // Hello from myFunction!
myDefaultFunction(); // Hello from default export!
```

#### CommonJS 예제

모듈 파일 (`module.js`):

```javascript
const myVar = 42;
const myFunction = () => {
  console.log("Hello from myFunction!");
};
module.exports = { myVar, myFunction };

module.exports.default = function () {
  console.log("Hello from default export!");
};
```

가져오기 파일 (`main.js`):

```javascript
const { myVar, myFunction } = require("./module");
const myDefaultFunction = require("./module").default;

console.log(myVar); // 42
myFunction(); // Hello from myFunction!
myDefaultFunction(); // Hello from default export!
```

이처럼, ESM과 CommonJS는 각기 다른 방식으로 모듈을 정의하고 가져오는 방법을 제공하며, 사용 환경과 필요에 따라 적절한 모듈 시스템을 선택하면 됩니다.

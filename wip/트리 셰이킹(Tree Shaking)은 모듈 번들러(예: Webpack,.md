트리 셰이킹(Tree Shaking)은 모듈 번들러(예: Webpack, Rollup)에서 사용되지 않는 코드를 제거하여 최종 번들 크기를 줄이는 최적화 기법입니다. 트리 셰이킹은 주로 ES 모듈 시스템(ESM)에서 잘 작동합니다. 이는 ESM이 정적 구조를 가지고 있어, 어떤 모듈과 함수가 사용되었는지 컴파일 타임에 알 수 있기 때문입니다.

### 기본 개념

트리 셰이킹은 이름 그대로, 나무(Tree)를 흔들어 사용되지 않는 죽은 잎(dead code)을 떨어뜨리는 것과 같습니다. 코드를 분석하여 실제로 사용되지 않는 코드를 제거함으로써, 최종 번들 파일 크기를 줄이고, 로딩 시간을 단축하며, 성능을 향상시킵니다.

### 예제

#### 모듈 정의 (math.js)

```javascript
// 여러 함수를 정의하고 export합니다.
export function add(a, b) {
  return a + b;
}

export function subtract(a, b) {
  return a - b;
}

export function multiply(a, b) {
  return a * b;
}

export function divide(a, b) {
  return a / b;
}
```

#### 모듈 가져오기 (main.js)

```javascript
// 일부 함수만 import하여 사용합니다.
import { add, subtract } from "./math.js";

console.log(add(2, 3)); // 5
console.log(subtract(5, 2)); // 3
```

위의 예제에서 `main.js`는 `math.js`에서 `add`와 `subtract` 함수만 사용합니다. `multiply`와 `divide` 함수는 사용되지 않으므로, 트리 셰이킹을 통해 번들링 과정에서 이 두 함수는 최종 번들에서 제거됩니다.

### 트리 셰이킹의 전제 조건

- **ES 모듈 사용**: ES 모듈 시스템은 정적 구조를 가지고 있어, 트리 셰이킹에 적합합니다. CommonJS는 동적이기 때문에 트리 셰이킹이 어려울 수 있습니다.
- **모듈 번들러**: 트리 셰이킹을 지원하는 모듈 번들러를 사용해야 합니다. Webpack과 Rollup이 대표적입니다.

### Webpack에서의 트리 셰이킹 설정

Webpack을 사용하여 트리 셰이킹을 설정하는 방법은 다음과 같습니다.

#### package.json

```json
{
  "name": "tree-shaking-example",
  "version": "1.0.0",
  "description": "",
  "main": "index.js",
  "scripts": {
    "build": "webpack"
  },
  "type": "module",
  "sideEffects": false,
  "devDependencies": {
    "webpack": "^5.0.0",
    "webpack-cli": "^4.0.0"
  }
}
```

- `"type": "module"`: ES 모듈을 사용하도록 설정합니다.
- `"sideEffects": false`: 모듈의 사이드 이펙트가 없음을 명시합니다. 사이드 이펙트가 있는 모듈은 제거되지 않습니다.

#### webpack.config.js

```javascript
const path = require("path");

module.exports = {
  mode: "production",
  entry: "./src/main.js",
  output: {
    filename: "bundle.js",
    path: path.resolve(__dirname, "dist"),
  },
  optimization: {
    usedExports: true, // 사용된 exports만 포함
  },
};
```

- `mode: 'production'`: 프로덕션 모드에서는 기본적으로 트리 셰이킹이 활성화됩니다.
- `optimization.usedExports: true`: 사용된 exports만 번들에 포함하도록 설정합니다.

### 주의사항

- **사이드 이펙트(Side Effects)**: 모듈의 코드가 사이드 이펙트를 포함하고 있는지 주의해야 합니다. 사이드 이펙트가 있는 코드는 트리 셰이킹에 의해 제거되지 않습니다.
- **코드 구조**: 트리 셰이킹은 정적 분석을 기반으로 작동하므로, 동적 import나 복잡한 코드 구조는 트리 셰이킹의 효과를 저하시킬 수 있습니다.

트리 셰이킹을 통해 불필요한 코드를 제거함으로써, 더 작은 번들 파일을 만들고 웹 애플리케이션의 성능을 향상시킬 수 있습니다.

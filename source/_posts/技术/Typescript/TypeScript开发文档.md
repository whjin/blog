---
title: typescript开发文档
date: 2019-10-13 21:43:15
update: 2026-03-05 23:24:07
category: ['技术']
tags: ['前端', 'TypeScript']
comments:
---

# 特性

- 类型批注 和编译时类型检查
- 类型推断
- 类型擦除
- 接口
- 枚举 `enum`
- `mixin`
- 泛型编程
- 名字空间
- 元组 `tuple`

# 类型

- `boolean` 布尔值
- `number` 数值
- `string` 字符串
- `any`
- `array` 数组
- `tuple` 元组
- `enum` 枚举
- `undefined` `null`
- `void` 空类型 方法没有返回值
- `never` 任何类型的子类型 代表不会出现的值
- `object` 对象

- 基本类型 增加`void` `any` `enum` `never`
- 引用类型

# 高级类型

- 交叉类型
- 联合类型
- 类型别名
- 类型索引
- 类型约束
- 类型映射
- 条件类型

**交叉类型**

`&` 将多个类型合并为一个类型 并 `T & U` 表示 `T` 和 `U` 的交集

```typescript
function extend<T, U>(first: T, second: U): T & U {
  let result:<T & U> = {};

  for (let key in first) {
    result[key] = first[key];
  }

  for (let key in second) {
    if(!result.hasOwnProperty(key)){
      result[key] = second[key];
    }
  }

  return result;
}
```

**联合类型**

多个类型中的任意一个 或 `T | U` 表示 `T` 或 `U` 不能共存

```typescript
function formatCommandline(command: string | string[]) {
  let line = '';
  if (typeof command === 'string') {
    line = command.trim();
  } else {
    line = command.join(' ').trim();
    lll;
  }
}
```

**类型别名**

`type`

```typescript
type name = string | boolean;
const a: name = true;
const b: name = 'ok';
```

**类型索引**

`keyof` 类似 `Object.keys()`

```typescript
interface Button {
  type: string;
  text: string;
}

type ButtonKeys = keyof Button;
```

**类型约束**

`extends`

```typescript
type BaseType = string | number | boolean;
function copy<T extends BaseType>(arg: T): T {
  return arg;
}
```

类型约束经常和类型索引一起使用

```typescript
function getValue<T, K extends keyof T>(obj: T, key: K): T[K] {
  return obj[key];
}
```

**类型映射**

`in`

```typescript
type Readonly<T> = {
  readonly [P in keyof T]: T[P];
};

interface Obj {
  a: string;
  b: string;
}

type ReadonlyObj = Readonly<Obj>;
```

**条件类型**

`T extends U ? X : Y`

**TypeScript 接口 应用场景**

- 继承

**枚举类型**

被命名的常数集合

**TypeScript 中 const 和 readonly 的区别 枚举和常量枚举的区别**

- `const` 防止变量被修改
- `readonly` 防止变量属性被修改

枚举
常量枚举 编译阶段会被删除 被内敛

接口
类型别名 都可以用来描述对象或函数类型 可以用于其他类型 基本类型 联合类型 元组

- `any`：动态类型变量 失去了类型检查的作用
- `never`：永远不存在的值的类型
  - 抛出异常 根本没有返回值的函数表达式 或箭头函数表达式返回值类型
- `unknown`：任何类型的值都可以赋值给 `unknown`，`unknown` 类型只能赋值给 `any` 类型或者 `unknown` 自身
- `null & undefined`：默认是所有类型子类型 `--strictNullChecks` 标记 `null` 或 `undefined` 只能赋值给 `void` 或本身
- `void`：没有任何类型 函数没有返回值 可以定义为 `void`

**interface 给 Function Array Class定义类型**

```typescript
// Function
interface Say {
  (name: string): void;
}
let say: Say = (name: string): void => {};

// Array
interface NumberArray {
  [index: number]: number;
}
let list: NumberArray = [1, 2, 3];

// Class
interface Person {
  name: string;
  sayHi(name: string): string;
}
```

**TypeScript 中的 this 和 JavaScript 中的 this 有什么差异**

1. TS：`noImplicitThis: true` 必须声明 `this` 类型 才能在函数或对象中使用 `this`
2. TS 箭头函数和 JS 中保持一致

**设计 Class 的声明**

```typescript
class Greeter{
  greeting: string;
  constructor(message: string) {
    this.greeting = message;
  }
  greet() :string{
    return `hello, ${this.greeting}`;`
  }
}
```

**如何联合枚举类型 union 的 key**

```typescript
enum str {
  A,
  B,
  C,
}
type strUnion = keyof typeof str;
```

**type 和 interface 的区别**

相同点：

- 都可以描述对象或函数
- 都允许扩展

不同点：

- `type` 可以声明基本类型 联合类型 元组
- `type` 可以使用 `typeof` 获取实例类型进行赋值
- 多个相同的 `interface` 可以自动合并

**安装编译工具**

```javascript
"scripts": {
  "start": "tsc && concurrently \"npm run tsc:w\" \"npm run lite\"",
  "lite": "lite-server",
  "tsc": "tsc",
  "tsc:w": "tsc -w"
},
"devDependencies": {
  "concurrently": "^5.0.0",
  "lite-server": "^2.5.4"
}
```

```json
{
  "compilerOptions": {
    "target": "ESNext",
    "useDefineForClassFields": true,
    "module": "ESNext",
    "moduleResolution": "Node",
    "strict": true,
    "jsx": "preserve",
    "sourceMap": true,
    "resolveJsonModule": true,
    "isolatedModules": true,
    "esModuleInterop": true,
    "lib": ["ESNext", "DOM"],
    "skipLibCheck": true
  },
  "include": ["src/**/*.ts", "src/**/*.d.ts", "src/**/*.tsx", "src/**/*.vue"],
  "extendsions": [".js", ".vue", ".json", ".ts", ".tsx"]
}
```

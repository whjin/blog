---
title: JavaScript技术文档
date: 2018-11-13 07:57:49
updated: 2026-03-18 15:25:51
category: ["技术"]
tags: ["前端", "JavaScript"]
cover: https://s1.imagehub.cc/images/2025/04/09/b244ec49ec6e38102144b0a44e1c0b6b.md.jpg
---

# 对象方法

|           方法           | 说明                                                                                                                                                 |
| :----------------------: | ---------------------------------------------------------------------------------------------------------------------------------------------------- |
|   **Object.hasOwb()**    | <ul style="display: flex; align-items:center;"><li style="margin-right: 16px;">安全地检查属性</li><li>避免原型链带来的问题</li></ul>                 |
|   **Object.hasOwb()**    | <ul style="display: flex; align-items:center;"><li style="margin-right: 16px;">安全地检查属性</li><li>避免原型链带来的问题</li></ul>                 |
|   **Object.groupBy()**   | <ul style="display: flex; align-items:center;"><li style="margin-right: 16px;">将数组数据分组为对象</li><li>比 `reduce()` 更简洁的替代方案</li></ul> |
|   **Object.create()**    | <ul style="display: flex; align-items:center;"><li style="margin-right: 16px;">基于原型的继承</li><li>在不使用构造函数的情况下创建对象</li></ul>     |
|    **Object.keys()**     | <ul style="display: flex; align-items:center;"><li style="margin-right: 16px;">遍历对象属性</li><li>校验对象是否为空</li></ul>                       |
|   **Object.values()**    | <ul style="display: flex; align-items:center;"><li style="margin-right: 16px;">从API数据中提取值</li><li>对值进行求和和等操作</li></ul>              |
|   **Object.entries()**   | <ul style="display: flex; align-items:center;"><li style="margin-right: 16px;">将对象转换为Map</li><li>使用 `for...of` 进行遍历</li></ul>            |
| **Object.fromEntries()** | <ul style="display: flex; align-items:center;"><li style="margin-right: 16px;">将键值对重新转换为对象</li><li>清理或转换API对象</li></ul>            |
|   **Object.assign()**    | <ul style="display: flex; align-items:center;"><li style="margin-right: 16px;">合并对象</li><li>创建浅拷贝</li></ul>                                 |
|    **Object.seal()**     | <ul style="display: flex; align-items:center;"><li style="margin-right: 16px;">当对象结构必须保持不变时使用</li><li>防止意外删除属性</li></ul>       |
|   **Object.freeze()**    | <ul style="display: flex; align-items:center;"><li style="margin-right: 16px;">防止意外修改</li><li>常用于状态管理</li></ul>                         |

# 异步编程有哪些实现方式

- 回调函数：存在问题，回调地狱、代码耦合度高、不利于代码维护
- `Promise`:链式调用
- `generator`：同步顺序书写 函数控制权转移回来 自动执行机制 co函数
- `async/await`：`generator` `promise` 自动执行的语法糖 内部自带执行器 `await` 等待 `Promise` 变成 `resolve` 异步逻辑转化为同步顺序 自动执行

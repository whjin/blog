---
title: React实战文档
date: 2026-03-12 10:08:37
updated: 2026-03-18 10:32:41
category: ['技术']
tags: ['前端', 'React', '实战']
cover: https://s1.imagehub.cc/images/2026/03/12/aa2d27c9b2e55158adcf4d4d7909f94b.md.png
main_color: '#087EA4'
keywords:
description:
top_img:
comments:
aside: false
sticky:
published: false
---

# React Fiber

React Fiber是React 16引入的新协调引擎。它将渲染过程拆分成多个小的工作单元（`Fiber`），让React可以暂停、恢复、并根据优先级执行更新，从而实现流程的、非阻塞的UI。它也为**并发渲染**（Concurrent Rendering）和`Suspense`等特性打下基础。

每个Fiber节点都代表React树中的一个元素，并保存对父节点、子节点和兄弟节点的引用。React利用这种链式结构高效地进行Diff和UI更新。

# useCallback

`use callback` + `React.memo` 是React中解决“内联回调导致子组件重渲染”的 **标准性能优化组合**，既保证了功能不变，又能高效稳定地减少冗余渲染。

`useCallback`是React专门用于 **缓存函数引用**的Hook，它会在依赖列表不变时，返回同一个函数引用。
将内联回调用 `use callback` 包裹，并精准限制依赖列表（只包含回调真正需要的变量），就能保证回调引用稳定，让 `React.memo` 的浅比较生效，从而避免子组件无意义重渲染，同时完全不改变原有功能。

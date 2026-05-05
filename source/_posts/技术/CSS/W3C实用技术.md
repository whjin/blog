---
title: W3C实用技术
date: 2025-05-02 06:25:47
updated: 2025-5-2 06:27:52
category: ['技术']
tags: ['W3C','CSS','前端']
cover: https://s1.imagehub.cc/images/2025/05/02/0973f8ffd170ff00184aba4ea012e119.md.png
main_color: "#005A9C"
keywords:
description:
top_img:
comments:
aside:
---
# CSS间隙装饰模块

**`CSS`间隙装饰模块**在现有`column-rule-width`、`column-rule-style`和`column-rule-color`属性的基础上进行扩展：新值行方法（`row direction`）的等效属性，将其应用范围延伸至其他容器布局类型，并提供对间隙装饰绘制位置与方式的精确控制。

## 间隙装饰

CSS中多栏容器（`multicol`）、弹性容器（`flex`）、网格容器（`grid`）和瀑布流容器（`masonry`）等布局方式会将子元素（`box`）相邻排列，并在它们之间形成间隙（即`gap`，也称为`gutter`）。这些间隙可以包含“间隙装饰”（`gap decoration`），即绘制在相邻子元素之间的视觉分隔元素（例如线条）。

```css
.grid-width-spans {
  display: grid;
  grid-template: repeat(4, 100px) / repeat(4, 100px);
  gap: 20px;
  -webkit-row-rule: 6px solid red;
  column-rule: 6px solid blue;
}

.flex {
  display: flex;
  flex-wrap: wrap;
  gap: 20px;
  width: 500px;
  -webkit-row-rule: 6px solid red;
  column-rule: 6px solid blue;
}
```

间隙装饰不占用布局空间。也就是说，间隙装饰的存在或宽度不会影响其他元素的布局位置。如果间隙装饰的宽度超过了间隙本身，相邻的盒子将会重叠于装饰之上，某些情况下装饰可能会延伸到容器盒子外部。间隙装饰绘制在容器边框上方。对于可滚动容器需注意：虽然容器的边框和背景不随内容滚动，但间隙装饰需要随容器内的项目一同滚动。

间隙交叉点的定义位置包括以下两种情况：
- 间隙与容器内容边缘（`content edge`）相交处的中心点
- 不同方向间隙相交处的中心点

间隙装饰的绘制基于成对的间隙交叉点，其呈现位置位于对应间隙的中心区域，且始终与间隙边缘保持平行。


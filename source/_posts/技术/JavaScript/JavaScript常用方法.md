---
title: JavaScript常用方法
date: 2020-08-23 21:01:36
uopdated: 2026-03-02 18:16:14
category: ['技术']
tags: ['前端', 'JavaScript']
cover: https://s1.imagehub.cc/images/2025/04/09/b244ec49ec6e38102144b0a44e1c0b6b.md.jpg
main_color: '#FBA552'
---

# 两数之和

```javascript
function twoSum(nums, target) {
  for (let i = 0; i < nums.length; i++) {
    let num = nums[i];
    let targetIndex = nums.indexOf(target - num);
    if (targetIndex !== -1 && targetIndex !== i) {
      return [i, targetIndex];
    }
  }
}
```

# 日期格式化

```JavaScript
// 格式化日期类型,fmt格式可选择
function dateFormat(fmt, date) {
  let ret;
  let opt = {
    "Y+": date.getFullYear().toString(), // 年
    "M+": (date.getMonth() + 1).toString(), // 月
    "D+": date.getDate().toString(), // 日
    "h+": date.getHours().toString(), // 时
    "m+": date.getMinutes().toString(), // 分
    "s+": date.getSeconds().toString(), // 秒
    "ms+": date.getMilliseconds().toString() // 毫秒
  };
  for (let k in opt) {
    ret = new RegExp("(" + k + ")").exec(fmt);
    if (ret) {
      fmt = fmt.replace(ret[1], ret[1].length == 1 ? opt[k] : opt[k].padStart(ret[1].length, "0"));
    }
  }
  return fmt;
}
let date = new Date();
let fDate = dateFormat("YYYY-MM-DD hh:mm:ss.ms", new Date(date));
```

<!--more-->

# 时间转换（秒数转时分秒）

```JavaScript
function timeFormat (sec) {
    let minite = Math.floor((sec / 60 % 60)) < 10 ? '0' + Math.floor((sec / 60 % 60)) : Math.floor((sec / 60 % 60));
    let second = Math.floor((sec % 60)) < 10 ? '0' + Math.floor((sec % 60)) : Math.floor((sec % 60));
    if (sec < 3600) {
        return `${minite}:${second}`;
    } else {
        let hour = Math.floor(sec / 3600) < 10 ? '0' + Math.floor(sec / 3600) : Math.floor(sec / 3600);
        return `${hour}:${minite}:${second}`;
    }
}
```

# 计算时分秒差值

```JavaScript
// 计算时分秒差值
function timeDiffer(beginTime, endTime) {
  let ret = {};
  let date = new Date();
  let sTime = Date.parse(dateFormat("YYYY/MM/DD", date) + " " + beginTime);
  if (beginTime >= endTime) {
    date.setDate(date.getDate() + 1);
  }
  let eTime = Date.parse(dateFormat("YYYY/MM/DD", date) + " " + endTime);
  let differ = eTime - sTime;
  let hour = Math.floor(differ / 1000 / 60 / 60);
  let minute = Math.floor(differ / 1000 / 60 - hour * 60);
  let second = Math.floor(differ / 1000 - hour * 60 * 60);
  ret = {
    differHour: hour,
    differMinute: minute,
    differSecond: second
  };
  return ret;
}
let { differHour, differMinute, differSecond } = timeDiffer(beginTime, endTime);
```

# 深拷贝和浅拷贝

**浅拷贝**

- 只拷贝一层
- 引用类型拷贝内存地址

```javascript
Object.assign;
Array.prototype.slice();
Array.prototype.concat();
扩展运算符;
```

**深拷贝**

```javascript
_.cloneDeep() lodash 深拷贝函数
jQuery.extend() jquery 深拷贝函数
JSON.stringify() 存在弊端 忽略 undefined Symbol
手写循环递归

function deepCopy(obj) {
  if (typeof obj !== 'object') {
    return new Error('类型错误');
  }
  let result = Array.isArray(obj) ? [] : {};
  for (let key in obj) {
    if (obj.hasOwnProperty(key)) {
      if (typeof obj[key] === 'object' && obj[key] !== null) {
        resultp[key] = deepCopy(obj[key]);
      }
    } else {
      result[key] = obj[key];
    }
  }
  return result;
}

function deepCopy(obj) {
  let copyObj = null;
  if (typeof obj === 'object' && obj !== null) {
    copyObj = Array.isArray(obj) ? [] : {};
    for (let key in obj) {
      copyObj[key] = deepCopy(obj[key]);
    }
  } else {
    copyObj = obj;
  }
  return copyObj;
}
```

# 数组去重

```javascript
// ES6最简方法
let result = [];
if (Array.isArray(arr)) {
  result = new Set(arr);
}
function unique(arr) {
  return Array.from(new Set(arr));
}

// filter去重
function unique(arr) {
  return arr.filter((item, index, arr) => {
    // 当前元素在原数据中的第一个索引等于当前索引值，否则返回当前元素
    return arr.indexOf(item, 0) == index;
  });
}

// 数组去重
function unique(arr) {
  if (!Array.isArray(arr)) {
    return;
  }
  let result = [];
  for (let i = 0; i < arr.length; i++) {
    if (result.indexOf(arr[i]) === -1) {
      result.push(arr[i]);
    }
  }
  return result;
}
function unique(arr) {
  if (Array.isArray(arr)) {
    let result = [];
    for (let i = 0, len = arr.length; i < len; i++) {
      if (!result.includes(arr[i])) {
        result.push(arr[i]);
      }
    }
    return result;
  }
}
```

# 数组对象去重

```JavaScript
function uniqueArr(arr) {
  if (!Array.isArray(arr)) {
    return;
  }
  let map = new Map();
  for (let i = 0, len = arr.length; i < len; i++) {
    if (!map.has(arr[i].name)) {
      map.set(arr[i].name, arr[i]);
    }
  }
  return [...map.values()];
}
```

# 数组对象排序

```JavaScript
// 数组对象排序，比较两个字符串
list.sort((a, b) => {
  return a.id.localeCompare(b.id);
});
```

# 获取上/下个月日期

```JavaScript
// 下个月
let date = new Date(this.startDate);
let nextMonthDate = date.setMonth(date.getMonth() + 1);
this.endDate = dateFormat("YYYY-MM-DD", new Date(nextMonthDate));

// 上个月个月
let lastMonthDate = date.setMonth(date.getMonth() - 1);
```

# 获取前/后7天日期

```JavaScript
// 前7天
let date = new Date(this.startDate);
let afterDate = date.setDate(date.getDate() + 6);
this.endDate = dateFormat("YYYY-MM-DD", new Date(afterDate));

// 后7天
let afterDate = date.setDate(date.getDate() - 6);
```

# 一周日期

```javascript
let weeks = ['周一', '周二', '周三', '周四', '周五', '周六', '周日'];
for (let i = 0; i < 7; i++) {
  let date = new Date();
  let index = date.getDay() ? date.getDay() - 1 : 6;
  let nowDate = date.setDate(date.getDate() - index + i);
  let formatDate = dateFormat('MM-DD', new Date(nowDate));
  let week = weeks[i];
  let weekDate = `${formatDate}(${week})`;
  this.weekDateColumns.push(weekDate);
}
```

# 点击内容切换

```javascript
let len = this.assistList.length - 1;
if (this.index < len) {
  this.index++;
  this.assistInfo = this.assistList[this.index];
} else {
  this.index = 0;
  this.assistInfo = this.assistList[this.index];
}
```

# 时分秒

```javascript
时：`parseInt(count/60/60)`
分：`parseInt(count/60)%60`
秒：`parseInt(count%60)`
```

# 当月第一天和最后一天

```javascript
// 第一天
let date = new Date();
date.setDate(1);
console.log(dateFormat('YYYY-MM-DD', date));

// 最后一天
let date = new Date();
let lastDay = new Date(date.getFullYear(), date.getMonth() + 1, 0);
console.log(dateFormat('YYYY-MM-DD', lastDay));
```

# fetch接口请求

```javascript
let api = 'https://api.com';
let headerConfig = {
  headers: {
    Accept: 'application/json',
  },
};
async function request() {
  let res = await fetch(api, headerConfig);
  let data = await res.json();
}
```

# 按键处理方法

```javascript
window.addEventListener('keydown', (e) => {
  let container = document.querySelector('#container');
  let { key, keyCode, code } = e;
  let template = '';
  [
    {
      title: 'e.key',
      content: key == ' ' ? 'Space' : key,
    },
    {
      title: 'e.keyCode',
      content: keyCode,
    },
    {
      title: 'e.code',
      content: code,
    },
  ].forEach((item) => {
    template += `<div class="key"><small>${item.title}</small>${item.content}</div>`;
  });
  container.innerHTML = template;
});
```

# 返回顶部

```css
html,
body {
  scroll-behavior: smooth;
}
.back {
  position: sticky;
  float: right;
  top: -110px;
  margin-top: -50px;
  border-radius: 50%;
  background: url('') center no-repeat dodgerblue;
  background-size: 50%;
  width: 50px;
  height: 50px;
  transform: translateY(calc(100vh + 50px));
}
```

# 自适应内部元素

```css
figure {
  max-width: 300px;
  max-width: min-content;
  margin: auto;
}
figure > img {
  max-width: inherit;
}
```

# iview封装菜单menu

```vue
<template>
  <i-submenu :name="menuList.name">
    <!-- 父级菜单 -->
    <template slot="title">{{ menuList.title }}</template>
    <template v-for="(item, index) in menuList.children">
      <!-- 如果还要子集，继续调用 -->
      <left-menu-nav v-if="item.hasOwnProperty('children')" :menuList="item"></left-menu-nav>
      <!-- 无子菜单 -->
      <i-menu-item v-else :name="item.name">{{ item.title }}</i-menu-item>
    </template>
  </i-submenu>
</template>

<script>
export default {
  name: "leftMenuNav",
  props: {
    menuList: {
      type: Object,
      default: () => { }
    }
  }
};
</script>

<Layout>
    <Sider hide-trigger collapsible :width="192" :collapsed-width="64" v-model="collapsed" class="left-sider" :style="{ overflow: 'hidden' }">
        <i-menu class="menu-position" ref="menu" :active-name="selectItem" :open-names="menuOpenName" @on-select="changeSelectItem">
            <template v-for="(item, index) in menuList" :name="item.name">
                <!-- 有子菜单 -->
                <left-menu-nav v-if="item.hasOwnProperty('children')" :menuList="item"></left-menu-nav>
                <!-- 无子菜单 -->
                <i-menu-item v-else :name="item.name">{{ item.title }}</i-menu-item>
            </template>
        </i-menu>
    </Sider>
    <Content class="main-content-con">
        <Layout class="main-layout-con">
            <Content class="content-wrapper" style="position: relative">
                <router-view style="height: 100%" />
                <div v-show="lockEnable" class="lockBox"></div>
                <ABackTop :height="100" :bottom="80" :right="50" container=".content-wrapper"></ABackTop>
            </Content>
        </Layout>
    </Content>
</Layout>
```

# 图片懒加载

```javascript
const images = document.querySelectorAll('img');
const callback = (entries) => {
  entries.forEach((entry) => {
    if (entry.isIntersecting) {
      const image = entry.target;
      const data_src = image.getAttribute('data-src');
      image.setAttribute('src', data_src);
      ResizeObserver.unobserver(image);
    }
  });
};
const observer = new IntersectionObserver(callback);
images.forEach((image) => {
  observer.observe(image);
});
```

# CSS多行文本省略

```css
p {
  overflow: hidden;
  display: -webkit-box;
  -webkit-box-orient: vertical;
  -webkit-line-clamp: 4;
}
```

# Vue字符串换行

```vue
1. 添加`white-space:pre`
2. 使用`<pre>`标签替换
```

# 封装iView无限层级菜单

```vue
// 子组件
<template>
  <i-submenu :name="menuList.name">
    <!-- 父级菜单 -->
    <template slot="title">{{ menuList.title }}</template>
    <template v-for="(item, index) in menuList.children">
      <!-- 如果还要子集，继续调用 -->
      <left-menu-nav v-if="item.children && item.children.length" :menuList="item" :key="item.index"></left-menu-nav>
      <!-- 子菜单 -->
      <i-menu-item :key="item.id" :name="item.name">{{ item.title }}</i-menu-item>
    </template>
  </i-submenu>
</template>

<script>
export default {
  name: 'leftMenuNav',
  props: {
    menuList: {
      type: Object,
      default: () => {},
    },
  },
};
</script>
```

```
// 父组件
<i-menu :active-name="selectItem" :open-names="menuOpenName" @on-select="changeSelectItem">
<template v-for="(item, index) in menuList" :name="item.name">
  <!-- 有子菜单 -->
  <left-menu-nav v-if="item.children && item.children.length" :menuList="item" :key="item.name"></left-menu-nav>
  <!-- 无子菜单 -->
  <i-menu-item v-else :name="item.name" :key="item.name">{{
    item.title
  }}</i-menu-item>
</template>
</i-menu>
```

# 上传文件

```css
<div class="upload">
  <button id="btn" class="btn">上传文件</button>
  <input type="file" id="input" class="input" />
</div>
```

```
.upload {
  width: 100px;
  height: 100px;
  position: relative;
}
.btn {
  width: 100%;
  height: 100%;
  box-sizing: border-box;
  border: 1px dashed rgb(31, 154, 158);
  background: #fff;
  cursor: pointer;
}
.input {
  width: 100%;
  height: 100%;
  box-sizing: border-box;
  position: absolute;
  left: 0;
  top: 0;
  opacity: 0;
}
```

# CSS控制禁止点击

`pointer-events: none; //（禁止鼠标点击事件）`

# 单行居中，多行顶部对齐

```css
.table-item {
  height: 100%;
  box-sizing: border-box;
  display: flex;
  flex: 1;
  flex-wrap: wrap;
  align-items: center;
  justify-content: center;
  font-size: 16upx;
  text-align: justify;
  font-weight: 600;
  span {
    width: 125upx;
    height: 65upx;
    overflow: auto;
    display: flex;
    align-items: center;
    justify-content: center;
    display: -webkit-box;
    -webkit-box-orient: vertical;
  }
}
```

# 计算传入时间与当前时间相差的秒数

```javascript
function convertStrToTime(time) {
  let nowTime = new Date().getTime();
  let date = new Date();
  let arr = time.split(':');
  date.setHours(parseInt(arr[0]));
  date.setMinutes(parseInt(arr[1]));
  let endTime = new Date(date).getTime();
  let ret = Math.ceil((endTime - nowTime) / 1000);
  return ret;
}
```

# 提取URL的参数

```javascript
function queryURLParams(url) {
  let str = url.split('?')[1];
  const urlSearchParams = new URLSearchParams(str);
  const params = Object.fromEntries(urlSearchParams.entries());

  return params;
}
```

# 使用迭代的方式实现flatten函数

```javascript
const flatten = function (arr) {
  return [].concat(...arr.map((v) => (Array.isArray(v) ? flatten(v) : v)));
};
```

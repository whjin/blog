---
title: Vue常用指令
date: 2026-03-18 17:52:50
updated: 2026-03-18 17:53:25
category: ['技术']
tags: ['前端', 'Vue', '指令']
cover: https://s1.imagehub.cc/images/2026/03/03/8e4f1f01d22dbc77372423dbbb68f8e0.md.jpeg
main_color:
keywords:
description:
top_img:
comments:
aside:
sticky:
---

### 输入框防抖指令 `v-debounce`

```javascript
const debounce = {
  inserted: function (el, binding) {
    let timer;
    el.addEventListener('keyup', () => {
      if (timer) clearTimeout(timer);
      timer = setTimeout(() => {
        binding.value();
      }, 1000);
    });
  },
};
export default debounce;
```

### 复制粘贴指令 `v-copy`

```javascript
const copy = {
  bind(el, { value }) {
    el.$value = value;
    el.handler = () => {
      if (!el.$value) return;

      const textarea = document.createElement('textarea');
      textarea.readOnly = true;
      textarea.style.position = 'absolute';
      textarea.style.left = '-9999px';
      textarea.value = el.$value;
      document.body.appendChild(textarea);
      textarea.select();

      document.body.removeChild(textarea);
    };
    el.addEventListener('click', el.handler);
  },
  componentUpdated(el, { value }) {
    el.$value = value;
  },
  unbind(el) {
    el.removeEventListener('click', el.handler);
  },
};
export default copy;
```

### 长按指令 `v-longpress`

```javascript
const longpress = {
  bind: function (el, binding, vnode) {
    if (typeof binding.value !== 'boolean') {
      throw 'callback must be a function';
    }
    let pressTimer = null;
    let start = (e) => {
      if (e.type === 'click' && e.button !== 0) return;
      if (pressTimer === null) {
        pressTimer = setTimeout(() => {
          handler();
        }, 2000);
      }
    };
    let cancel = (e) => {
      if (pressTimer !== null) {
        clearTimeout(pressTimer);
        pressTimer = null;
      }
    };
    const handler = (e) => {
      binding.value(e);
    };

    el.addEventListener('mousedown', start);
    el.addEventListener('touchstart', start);
    el.addEventListener('click', cancel);
    el.addEventListener('mouseout', cancel);
    el.addEventListener('touchend', cancel);
    el.addEventListener('touchcancel', cancel);
  },
  componentUpdated(el, { value }) {
    el.$value = value;
  },
  unbind(el) {
    el.removeEventListener('click', el.handler);
  },
};
export default longpress;
```

### 图片懒加载 `v-lazyLoad`

```javascript
const lazyLoad = {
  install(Vue, options) {
    const defaultSrc = options.default;
    Vue.directive('lazy', {
      bind(el, binding) {
        lazyLoad.init(el, binding.value, defaultSrc);
      },
      inserted(el) {
        if (IntersectionObserver) {
          lazyLoad.observe(el);
        } else {
          lazyLoad.listenerScroll(el);
        }
      },
    });
  },
  init(el, val, def) {
    el.setAttribute('data-src', val);
    el.setAttribute('src', def);
  },
  observe(el) {
    const io = new IntersectionObserver((entries) => {
      const realSrc = el.dataset.src;
      if (entries[0].isIntersecting) {
        if (realSrc) {
          el.src = realSrc;
          el.removeAttribute('data-src');
        }
      }
    });
    io.observe(el);
  },
  listenerScroll(el) {
    const handler = lazyLoad.throttle(lazyLoad.load, 300);
    lazyLoad.load(el);
    window.addEventListener('scroll', () => handler(el));
  },
  load(el) {
    const windowHeight = document.documentElement.clientHeight;
    const elTop = el.getBoundingClientRect().top;
    const elBtm = el.getBoundingClientRect().bottom;
    if (elTop - windowHeight < 0 && elBtm >= 0) {
      if (realSrc) {
        el.src = realSrc;
        el.removeAttribute('data-src');
      }
    }
  },
  throttle(fn, delay) {
    let timer;
    let prevTime;
    return function (...args) {
      const currTime = Date.now();
      const context = this;
      if (!prevTime) prevTime = currTime;
      clearTimeout(timer);

      if (currTime - prevTime > delay) {
        prevTime = currTime;
        fn.apply(context, args);
        clearTimeout(timer);
        return;
      }

      timer = setTimeout(() => {
        prevTime = Date.now();
        clearTimeout(timer);
        timer = null;
        fn.apply(context, args);
      }, delay);
    };
  },
};
export default lazyLoad;
```

### 权限校验指令 `v-premission`

```javascript
function checkArray(key) {
  let arr = ['1', '2', '3', '4'];
  let index = arr.indexOf(key);
  if (index > -1) {
    return true;
  } else {
    return false;
  }
}

const premission = {
  inserted: function (el, binding) {
    let premission = binding.value;
    if (premission) {
      let hasPermission = checkArray(premission);
      if (!hasPermission) {
        el.parentNode && el.parentNode.removeChild(el);
      }
    }
  },
};
export default premission;
```

### 实现页面水印 `v-waterMarker`

```javascript
function addWaterMarker(str, parentNode, font, textColor) {
  let can = document.createElement('canvas');
  parentNode.appendChild(can);
  can.width = 200;
  can.height = 150;
  can.style.display = 'none';
  let cans = can.getContext('2d');
  cans.rotate((-20 * Math.PI) / 180);
  cans.font = font || '16px Microsoft JhengHei';
  cans.fillStyle = textColor || 'rgba(180, 180, 180, 0.3)';
  cans.textAlign = 'left';
  cans.textBaseline = 'Middle';
  cans.fillText(str, can.width / 10, can.height / 2);
  parentNode.style.backgroundImage = `url(${can.toDataURL('image/png')})`;
}

const waterMarker = {
  bind: function (el, binding) {
    addWaterMarker(
      binding.value,
      el,
      binding.value.font,
      binding.value.textColor,
    );
    l;
  },
};
export default waterMarker;
```

### 拖拽指令 `v-draggable`

```javascript
const draggable = {
  inserted: function (el) {
    el.style.cursor = 'move';
    el.onmousedown = function (e) {
      let disx = e.clientX - el.offsetLeft;
      let disy = e.clientY - el.offsetTop;
      document.onmousemove = function (e) {
        let x = e.clientX - disx;
        let y = e.clientY - disy;
        let maxX =
          document.body.clientWidth -
          parseInt(window.getComputedStyle(el).width);
        let maxY =
          document.body.clientHeight -
          parseInt(window.getComputedStyle(el).height);
        if (x < 0) {
          x = 0;
        } else if (x > maxX) {
          x = maxX;
        }
        if (y < 0) {
          y = 0;
        } else if (y > maxY) {
          y = maxY;
        }

        el.style.left = x + 'px';
        el.style.top = y + 'px';
      };
      document.onmouseup = function () {
        document.onmousemove = null;
        document.onmouseup = null;
      };
    };
  },
};
export default draggable;
```

---
title: 安卓UniApp集成wangEditor富文本编辑器
date: 2025-04-13 23:43:31
updated: 2025-4-13 23:44:54
category: ['技术']
tags: ['前端','Android','UniApp','富文本','wangEditor']
cover: https://s1.imagehub.cc/images/2025/04/14/355778dd2c7ae824ab980b5bf1dddce8.png
main_color: '#3C7BEE'
keywords:
description:
top_img:
comments:
aside:
---

# 兼容多种渲染场景

```html
// /pages/message/index.vue

<template>
<scroll-view scroll-y class="scroll">
  <view id="editor" class="editor" v-if="showWebview"></view>
  <rich-text class="editor" :nodes="selectInfo.details" :preview="true" v-else></rich-text>
</scroll-view>
</template>

<script setup name="notice">
import { ref, onMounted, onBeforeUnmount } from 'vue';
import { createWebview, closeWebview, sendMessage } from '@/common/webview';

let showWebview = ref(true);

let selectInfo = ref({});
const onNoticeInfo = info => {
  selectInfo.value = Object.assign({}, info);
  sendMessage(selectInfo.value.details);
};

const getElementPosition = cb => {
  const query = uni.createSelectorQuery().in(this);
  query
    .select('#editor')
    .boundingClientRect(rect => {
      if (rect) {
        console.log('元素四方位', rect);
        cb && cb(rect);
      } else {
        cb && cb(false);
      }
    })
    .exec();
};

onMounted(() => {
  getElementPosition(rect => {
    createWebview(rect, res => {
      if (res) {
        showWebview.value = true;
        sendMessage(selectInfo.value.details);
      } else {
        showWebview.value = false;
        closeWebview();
      }
    });
  });
});
onBeforeUnmount(() => {
  closeWebview();
});
</script>

<style lang="less" scoped>
.scroll {
  height: 540upx;
  .editor {
    height: 100%;
    box-sizing: border-box;
    color: var(--list-primary-text);
  }
}
</style>
```

# 封装webview加载组件

```js
// /common/webview/index.js

let webviewObj = null;
let currentWebview = null;
let webviewUrl = '/static/html/index.html';
let timer = null;

export const createWebview = (rect, cb) => {
  // #ifdef APP-PLUS
  closeWebview(() => {
    let { width, height, left, top } = rect;
    let style = { width, height, left, top };
    webviewObj = plus.webview.create('', 'webview', {
      plusrequire: 'none',
      ...style,
    });
    webviewObj.loadURL(webviewUrl);
    webviewObj.addEventListener(
      'loading',
      res => {
        console.log('webview loading', res);
      },
      false
    );
    webviewObj.addEventListener(
      'loaded',
      res => {
        webviewObj.show();
        console.log('webview loaded', res);
        cb && cb(true);
      },
      false
    );
    webviewObj.addEventListener(
      'error',
      err => {
        console.log('webview error', err);
        cb && cb(false);
      },
      false
    );
    webviewObj.addEventListener(
      'message',
      res => {
        console.log('接收Web端消息', res);
      },
      false
    );
    const pages = getCurrentPages();
    const currentPage = pages[pages.length - 1];
    currentWebview = currentPage.$getAppWebview();
    currentWebview.append(webviewObj);
    setTimeout(() => {
      webviewObj.setStyle(style);
      webviewObj.checkRenderedContent(
        {},
        res => {
          console.log('checkRenderedContent success', res);
        },
        err => {
          console.log('checkRenderedContent error', err);
          cb && cb(false);
        }
      );
    }, 200);
  });
  // #endif
};

export const sendMessage = details => {
  // #ifdef APP-PLUS
  clearTimeout(timer);
  timer = setTimeout(() => {
    let jsCode = `setContent(${JSON.stringify(details)})`;
    let webview = plus.webview.getWebviewById('webview');
    webview.evalJS(jsCode);
  }, 200);
  // #endif
};

export const toggleWebview = (status = 'hide') => {
  if (status == 'show') {
    webviewObj && webviewObj?.show();
  } else {
    clearTimeout(timer);
    webviewObj && webviewObj?.hide();
  }
};
export const closeWebview = cb => {
  clearTimeout(timer);
  webviewObj && webviewObj?.close();
  currentWebview = null;
  cb && cb();
};
```

# 引入Web端HTML页面

```html
// /static/html/index.html

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Editor View</title>
    <link rel="stylesheet" href="./dist/style.css" />
    <script src="./dist/index.js"></script>
    <style>
      body {
        margin: 0;
        padding: 0;
        width: 100%;
        height: 100%;
        box-sizing: border-box;
      }
      .editor {
        width: 100%;
        height: 100%;
        box-sizing: border-box;
      }
    </style>
  </head>
  <body>
    <div id="editor" class="editor"></div>
    <script>
      const editor = wangEditor.createEditor({
        selector: '#editor',
        config: {
          placeholder: '数据加载中...',
          readOnly: true,
          autoFocus: false,
        },
        mode: 'default',
      });
      function setContent(html) {
        console.log('接收APP端数据', html);
        editor.setHtml(html);
      }
    </script>
  </body>
</html>

```
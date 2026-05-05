---
title: Vite开发配置
date: 2024-06-10 11:21:32
updated: 2026-03-03 21:20:30
category: ['技术']
tags: ['前端', 'Vite']
cover: https://s1.imagehub.cc/images/2026/03/18/3146463db5cf001020bfefa7d0e1585d.md.jpg
main_color: '#FFC820'
keywords:
description:
top_img:
comments:
aside:
---

# 解决Vue部署 404 问题

```javascript
server {
  listent 80
  server_name www.example.com

  location / {
    index /dist/index.html
    try_files $uri /index.html
  }
}

const router = new VueRouter({
  routers:[
    { path: '*', component: NotFound }
  ]
})
```

## package.json

```json
{
  "name": "vue-webrtc",
  "version": "1.0.0",
  "private": true,
  "type": "module",
  "scripts": {
    "dev": "vite --host",
    "build": "vite build",
    "preview": "vite preview --host"
  },
  "dependencies": {
    "element-plus": "^2.7.0",
    "pinia": "^2.1.7",
    "vue": "^3.4.21",
    "vue-router": "^4.3.0"
  },
  "devDependencies": {
    "@vitejs/plugin-basic-ssl": "^1.1.0",
    "@vitejs/plugin-vue": "^5.0.4",
    "less": "^4.2.0",
    "unplugin-auto-import": "^0.17.5",
    "unplugin-vue-components": "^0.26.0",
    "vite": "^5.2.8"
  }
}
```

## vite.config.js

```javascript
import { fileURLToPath, URL } from 'node:url';

import { defineConfig } from 'vite';
import AutoImport from 'unplugin-auto-import/vite';
import Components from 'unplugin-vue-components/vite';
import { ElementPlusResolver } from 'unplugin-vue-components/resolvers';
import vue from '@vitejs/plugin-vue';
import basicSSL from '@vitejs/plugin-basic-ssl';

export default defineConfig({
  base: './',
  plugins: [
    vue(),
    AutoImport({
      resolvers: [ElementPlusResolver()],
    }),
    Components({
      resolvers: [ElementPlusResolver()],
    }),
    basicSSL(),
  ],
  resolve: {
    alias: {
      '@': fileURLToPath(new URL('./src', import.meta.url)),
    },
  },
  server: {
    host: '0.0.0.0',
    https: true,
  },
});
```

## nginx config

```nginx
server {
    listen 1443 ssl;

    ssl on;
    ssl_certificate  C:/SmartTerminal/nginx-1.17.4/ssl/server.crt;
    ssl_certificate_key C:/SmartTerminal/nginx-1.17.4/ssl/server.key;

    ssl_session_timeout 5m;
    ssl_session_cache shared:SSL:10m;
    ssl_protocols TLSv1 TLSv1.1 TLSv1.2 SSLv2 SSLv3;
    ssl_ciphers "ECDHE-RSA-AES256-GCM-SHA384:ECDHE-RSA-AES128-GCM-SHA256:DHE-RSA-AES256-GCM-SHA384:DHE-RSA-AES128-GCM-SHA256:ECDHE-RSA-AES256-SHA384:ECDHE-RSA-AES128-SHA256:ECDHE-RSA-AES256-SHA:ECDHE-RSA-AES128-SHA:DHE-RSA-AES256-SHA256:DHE-RSA-AES128-SHA256:DHE-RSA-AES256-SHA:DHE-RSA-AES128-SHA:ECDHE-RSA-DES-CBC3-SHA:EDH-RSA-DES-CBC3-SHA:AES256-GCM-SHA384:AES128-GCM-SHA256:AES256-SHA256:AES128-SHA256:AES256-SHA:AES128-SHA:DES-CBC3-SHA:HIGH:!aNULL:!eNULL:!EXPORT:!DES:!MD5:!PSK:!RC4";
    ssl_prefer_server_ciphers on;
    ssl_verify_client off;

    server_name example.com;

    #location / {
    #    root C:/SmartTerminal/terminal/webrtc-dev/dist;
    #    try_files $uri $uri/ /index.html;
    #}
    location / {
        proxy_pass https://192.168.66.199:5173;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
    }

    location /terminal {
        proxy_redirect off;
        proxy_pass http://localhost:8080;      # 转发
        proxy_set_header Host $host;
        proxy_set_header X-Real_IP $remote_addr;
        proxy_set_header X-Forwarded-For $remote_addr:$remote_port;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;   # 升级协议头 websocket
        proxy_set_header Connection upgrade;
    }
}
```

## public/config.js

```javascript
window.g = {
  websocketUrl: 'wss://192.168.66.199:1443/terminal?code=',
};
```

## src/assets/js/comlib.js

```javascript
window.g = {
  websocketUrl: 'wss://192.168.66.199:1443/terminal?code=',
};
```

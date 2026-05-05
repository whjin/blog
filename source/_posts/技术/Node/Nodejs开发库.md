---
title: Node.js开发库
date: 2024-04-06 12:18:10
category: ["技术"]
tags: ["Node.js","前端"]
updated: 2024-4-6 13:15:22
keywords:
description:
top_img:
comments:
cover: https://img1.baidu.com/it/u=1395738484,3377141821&fm=253&fmt=auto&app=120&f=JPEG?w=889&h=500
highlight_shrink:
aside:
main_color: "#84CC2A"
---
### Sequelize ###

`Sequelize`是一个基于`Promise`的`Node.js`对象关系映射器（`ORM`），支持`PostgreSQL`、`MySQL`、`SQLite`等。

`Sequelize`使用`JavaScript`对象对数据库表的结构进行建模，并连接到常用的关系数据库进行查询和更改数据，解析检索到的数据并将其作为`JavaScript`对象返回。

### CORS ###

使用`Connect/Express`作为中间件提供跨域资源共享。`CORS`包装了`Node.js`路由中间件，它接受多个参数来指定跨域选项，如`origin`、`header`等。

### Nodemailer ###

`Nodemailer`简化了从`Node.js`服务器发送的电子邮件。它使用一个传输对象，该对象基于简单邮件传输协议（`SMTP`）。创建消息时，此传输对象接受`from`、`to`、`subject`、`body`和其他参数作为输入。

### Passport ###

`Passport`是一个模块化的`Node.js`身份验证中间件。支持超过`500`种身份验证方案，普通用户名和密码登录、通过`OAuth`进行的社交网站委托身份验证，以及用于联合身份验证的`OpenID`都是可选。

### Async ###

`Async`是一个基于`Promise`的使用回调方法来处理异步事件的工具模块。

### WinsTon ###

`Winston`是`Node.js`的日志包，允许在许多传输上进行通用日志记录。

### Mongoose ###

`Mongoose`是一款基于`Node.js`的`MongoDB`对象建模工具，通常被称为对象数据建模`ODM`库。

### Socket.IO ###

通过`HTTP`长轮询使用数字握手在服务器和客户端之间建立低级连接，通过`TCP`实时进行通信。

### Lodash ###

### Axios ###

`Axios`是一个运行在`Node.js`和浏览器的基于`Promise`的`HTTP`客户端。

根据需要管理浏览器或`Node.js`请求和响应数据的转换。`Axios`是同构的，它可以使用相同的代码库在服务器和客户端上运行。

`Axios`在服务器端使用本机`HTTP`模块，在客户端使用`XMLHttpRequest`进行`HTTP`通信。

### Puppeteer ###

`Puppeteer`是一个`Node.js`框架，通过`DevTools`协议提供用于控制`Chrome/Chromium`的高级`API`来自动化`Chrome`。

### Multer ###

`Multer`是一个`Node.js`中间件库，基于`HTML`表单解析器`Busboy`构建，支持多部分和多形式数据。

### Dotenv ###

用于维护应用程序环境变量并保护关键配置数据。


# 全栈图书管理系统

> 项目地址：[book-management-system](https://github.com/whjin/node-galaxy/tree/master/book-management-system)

> 1. 完整项目的需求分析和架构设计（需求规划、目录结构设计、接口设计）
> 2. 后端接口开发和数据库设计（`Express` + `MongoDB` 开发接口，设计数据模型，认证授权）
> 3. 前后端联调方法和解决跨域问题（`Apifox` 测试接口，`cors`和代理解决跨域问题）
> 4. 项目部署流程，使用 `PM2` 管理应用进程（搭建服务器环境、上传项目、`PM2` 启动、管理项目）
> 5. 项目优化与迭代（性能优化、功能扩展）

## 一、需求分析

**1. 功能规划：分角色、分模块**

- **公共功能**：用户注册、用户登录（`JWT`认证）、图书借阅（模糊查询、分类查询）
- **管理员功能**：图书管理（添加、修改、删除图书）、借阅管理（查看借阅记录、审核借阅申请）、用户管理（查看用户列表、禁用用户）
- **普通用户功能**：个人中心（修改个人信息、查看借阅记录）、图书借阅、图书归还

**2. 技术栈**

- **后端**：`Node.js`、`Express`、`MongoDB`、`JWT`、`CORS`
- **前端**：`HTML`、`CSS`、`JavaScript`、`Bootstrap`
- **工具**：`Apifox`、`PM2`

## 二、项目架构设计

**1. 目录结构设计**

<!-- prettier-ignore-start -->
```markdown
book-management-system/
├── client/
│ ├── css/
│ ├── index.html
│ └── js/
└── server/
├── config/         # 配置文件(数据库配置、JWT配置等)
├── controller/     # 控制器(处理请求、返回响应)
├── middleware/     # 中间件(认证、异常处理、跨域)
├── model/          # 数据模型（MongoDB 集合定义）
├── route/          # 路由（接口地址定义）
├── utils/          # 工具函数（密码加密、JWT 生成/验证）
├── app.js
└── package.json
```
<!-- prettier-ignore-end -->

**2. 模块划分**

- **用户模块**：负责用户注册、登录、个人信息修改（对应 `controller`、`route`、`model` 的 `user` 相关文件）
- **图书模块**：负责图书的增删改查（对应 `book` 相关文件）
- **借阅模块**：负责图书借阅、归还、借阅记录查询（对应 `borrow` 相关文件）
- **公共模块**：负责配置、中间件、工具函数（全局通用）

**3. 接口设计**

<!-- prettier-ignore-start -->
|接口地址|<center>请求方式</center>|功能描述|请求参数|
|---|:---:|---|---|
|`api/user/register`|`POST`|用户注册|`username`、`password`、`email` |
|`api/user/login`|`POST`|用户登录|`username`、`password`|
|`api/book/list`|`GET`|查询图书列表|`page`、`size`、`keyword`|
|`api/book/add`|`POST`|添加图书（管理员）|`title`、`author`、`price`、`category`|
|`api/borrow/apply`|`POST`|借阅图书|`bookId`、`userId`|
<!-- prettier-ignore-end -->

## 三、后端开发

**1. 数据库设计**

**2. 接口实现**

**3. 认证授权**

**4. 异常处理**

## 四、前后端联调

**1. 接口测试**

**2. 解决跨域问题**

## 五、项目部署

**1. 服务器环境搭建**

**2. 项目打包**

**3. `PM2` 进程管理**

```sh
// 1. 启动项目
pm2 start app.js --name "book-system"

// 2. 查看项目运行状态
pm2 list

// 3. 重启项目
pm2 restart "book-system"

// 4. 停止项目
pm2 stop "book-system"

// 5. 查看项目日志
pm2 logs "book-system"

// 6. 设置PM2 开机启动（关键，服务器重启后自动启动项目）
pm2 startup
pm2 save
```

## 六、项目优化与迭代

**1. 性能优化**

- 数据库优化：给常用字段（`username`、`title`）添加索引，查询速度翻倍
- 接口优化：减少不必要的数据库查询，查询图书列表，只返回需要的字段
- 静态资源优化：前端静态资源（`CSS`、`JS`、图片）压缩，减少加载时间

**2. 功能扩展**

- 新增图书分类功能：给图书添加多级分类，方便用户查询
- 新增借阅提醒功能：用户借阅图书后，到期前发送提醒（`nodemailer` 模块）
- 新增评论功能：用户可以给图书评论、打分
- 优化前端页面：用 `Vue`、`React` 框架重构前端，提升用户体验

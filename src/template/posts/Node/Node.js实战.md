# 全栈图书管理系统

> 项目地址：[node-galaxy](https://github.com/whjin/node-galaxy)

`Express`、`MongoDB`、`JWT`、前后端联调、部署上线

## 需求分析

### 1. 功能规划：分角色、分模块

- **公共功能**：用户注册、用户登录（`JWT`认证）、图书借阅（模糊查询、分类查询）
- **管理员功能**：图书管理（添加、修改、删除图书）、借阅管理（查看借阅记录、审核借阅申请）、用户管理（查看用户列表、禁用用户）
- **普通用户功能**：个人中心（修改个人信息、查看借阅记录）、图书借阅、图书归还

### 2. 技术栈

- **后端**：`Node.js`、`Express`、`MongoDB`、`JWT`、`CORS`
- **前端**：`HTML`、`CSS`、`JavaScript`、`Bootstrap`
- **工具**：`Apifox`、`PM2`

## 项目架构设计

### 1. 目录结构设计

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

### 2. 模块划分

- **用户模块**：负责用户注册、登录、个人信息修改（对应 `controller`、`route`、`model` 的 `user` 相关文件）
- **图书模块**：负责图书的增删改查（对应 `book` 相关文件）
- **借阅模块**：负责图书借阅、归还、借阅记录查询（对应 `borrow` 相关文件）
- **公共模块**：负责配置、中间件、工具函数（全局通用）

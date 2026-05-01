## `MCP` 接口标准

> `MCP`-`Model Context Protocol`，模型上下文协议
> 提升对大模型行为的控制能力：优化提问方式，设计输入环境，连接外部能力，形成可复用能力单元。
> 为模型提供可调用的能力（查询数据、执行操作或访问服务），通过标准化接口，让模型能够可靠地调用外部能力。

> [各厂商 Function Calling Tools 实例代码](https://github.com/whjin/blog/tree/master/src/test/ai)
> [各厂商 Function Calling Tools 实例代码](https://github.com/whjin/blog/blob/master/src/test/ai/function-calling.js)

## `MCP` 核心组件

- `MCP Client`
- `MCP Server`
- `MCP Host`

## `MCP Server`

1. `Tools` 执行动作 基于统一的协议标准定义和调用，具有更好的通用性和可复用行
2. `Resources` 提供信息

- `MCP` `Server Resources` 是一种数据源
- `RAG` 是一种数据检索策略
- `MCP Server Resources` 可以作为 `RAG` 的数据源

3. `Prompts` 提示词

## `MCP Client`

- 连接 `MCP Server`
- 完成协议握手
- 发送请求，接受 `MCP Server` 的响应
- 获取 `MCP Server` 的能力

```js
class MCPClient {
  // 连接
  connect(transport)

  // 生命周期
  initialize()

  // 能力发现
  listTools()
  listResources()
  listPrompts()

  // 能力调用
  callTool()
  readResource()
  getPrompt()

  // 通信
  request()
  notify()

  // 会话管理
  close()
  reconnect()
}
```

**1. 连接层**

建立和 `MCP Server` 的连接，`transport` 可以是：

- `stdio`
- `http`
- `websocket`

**2. 生命周期**

- 初始化会话
- 获取 `server` 能力
- 协议握手

**3. 能力发现**

**4. 能力调用**

调用 `MCP Server` 提供的方法，拿到对应的上线爱文内容

**5. 会话管理**

用于管理连接生命周期，处理断连/重连等场景

## `MCP Host`

`MCP Host` 是一个 `Agent` 应用，而 `MCP Client` 是整个 `Agent` 应用的其中一个模块。

## 通信方式

**通信格式**

- `xml`
- `json`
- 字符串

`MCP`中的通信格式采用 `JSON-RPC2.0`，`JSON Remote Procedure Call`，远程函数调用。

```json
{
  "jsonrpc": "2.0",
  "method": "callTool",
  "params": {
    "name": "weather",
    "argumengs": {
      "location": "北京"
    }
  },
  "id": 1
}

{
  "jsonrpc": "2.0",
  "result": {
    "temperature": 25,
    "condition": "晴"
  }
}
```

**通信方式**

- `stdio`：本地进程通信
- `http`：网络通信

`Streamable HTTP` 是 `MCP` 中基于 `http` 的通信方式，主要用于远程和 `Web` 场景。

- 通过 `HTTP` 接收 **远程** 请求（前端网页、`API` 网关）
- 需要支持 **多客户端** 并发访问
- 浏览器与 `MCP Server` 通信
- 流式响应（`SSE` 推送）

客户端基于 `HTTP POST` 发送 `JSON-RPC` 请求：

- `initialize`
- `callTool`
- `listResources`

服务端根据场景返回：

- 普通 `JSON` 响应（`application/json`）
- 流式 `SSE` 响应（`text/event-stream`）

除了请求响应外，客户端还可以通过 `GET` 请求建立 `SSE` 连接，用于接收服务端的通知，`SSE` 主要用于 **服务端主动推送**。

- `notifications/resources/list_changed`
- `notifications/tools/list_changed`

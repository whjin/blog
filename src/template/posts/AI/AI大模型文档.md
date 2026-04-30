## `MCP` 接口标准

> `MCP`-`Model Context Protocol`，模型上下文协议
> 提升对大模型行为的控制能力：优化提问方式，设计输入环境，连接外部能力，形成可复用能力单元。
> 为模型提供可调用的能力（查询数据、执行操作或访问服务），通过标准化接口，让模型能够可靠地调用外部能力。

> [各厂商 Function Calling Tools 实例代码](https://github.com/whjin/blog/tree/master/src/test/ai)

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

### 1. 连接层

建立和 `MCP Server` 的连接，`transport` 可以是：

- `stdio`
- `http`
- `websocket`

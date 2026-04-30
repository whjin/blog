## `MCP` 接口标准

> `MCP`-`Model Context Protocol`，模型上下文协议
> 提升对大模型行为的控制能力：优化提问方式，设计输入环境，连接外部能力，形成可复用能力单元。
> 为模型提供可调用的能力（查询数据、执行操作或访问服务），通过标准化接口，让模型能够可靠地调用外部能力。

> [各厂商 Function Calling Tools 实例代码](https://github.com/whjin/blog/tree/master/src/test/ai)

## `MCP` 核心组件

- `MCP Client`
- `MCP Server`
  - `Tools` 基于统一的协议标准定义和调用，具有更好的通用性和可复用行
  - `Resources`
  - `Prompts`
- `MCP Host`

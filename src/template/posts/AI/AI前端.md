## 模型侧

- `LLM` （大语言模型）
- `fine-tuning`
- **模型微调**：成本较高，灾难性遗忘
- **多模态**：输入：图片、音视频 输出：富媒体内容
- **模型效果评测**：AI Code 实现场景（实现一个电商网站，是否有登录、是否有购物车），核心评测手段，依靠人工来评测
- 模型部署优化（模型压缩）
- 数据蒸馏
- **推理加速优化**：核心方法，模型提前按照高频的使用场景（`query`词）生成好模板

## 工程侧

- 领域能力 webview的IDE应用 LSP
- 上下文管理
- **提示词工程**：通过指令的方式，规范化模型的输出，让模型的回复（处理效果）更符合预期
- `multi agent`：工程分治的思想，`planner agent`原始输入拆解为每一个工作节点和流程
- `MCP（Function call）`：`Model Control Protocal` Web应用，接口调用后，写入交易的记录，定义了一套标准的通讯协议
- `Agent client`

## 前端工程提效

通过AI实现前端研发工作流程中的自动化，减少研发成本

- `AI Code Review`：`trigger gitlab webhooks`，接口
  1. 除基座模型外，有没有自身的一些业务规范和必须遵守的代码规范 知识库
  2. 获取代码的 `diff` 本身是否包含全部代码上下文
- AI自动化工作流：核心技术方案
  1. `browser-use` 让大模型可以读懂浏览器内的页面
  2. `playwright/puppeteer` 无头浏览器 让大模型具备操作网页的能力

## AI编程方向

指标体系，AI出码率：AI生成的代码总行数 / `commit` 代码总行数

**AI编程助手**

TDD Test-Drive
KDD Knowledge-Drive

D2C 设计稿转码

生成基础的 `HTML/CSS` 通用组件 -> 业务组件

让AI读懂设计稿 获取组件库知识 实现一个 `Agent` 处理 设计稿出代码

**生成式UI（AI原生UI）**

1. 面向用户侧：根据不同的上下文环境，直接生成不同的可交互页面/组件
2. 研发侧：生产提效

两种方式：

1. 完全生产：大模型返回 `HTML/CSS`，`iframe`、微前端、`webview` 把AI生成的组件渲染用用户界面
2. `Google A2UI`：AI生成的 `lowcode schema` `UI=F(state) A2UI UI=F(state) + AI(UI)`

**知识库**

1. `AI Coding`(`vibe coding`、`spec coding`)
2. 设计稿转码
3. AI IDE 建设（主流前端IDE都是 `webview`）
   1. IDE AI Agent 需要大量和用户运行环境交互的能力
   2. Cursor已经可以集成 `browser-like`方案，让AI可以感知Web运行是状态
4. 自动化测试

**核心观点**

1. 前端主流工作内容会以人机协作的形态共存（`coding -> promt + coding共存`）
2. 核心岗位能力要求上，会更偏重于「创造性」和「问题解决」

## AI前端工程

1. 基础知识
   1. `LLM`、`context`、`Agent`、`Function call`、`MPC`、`embedding`等AI工程落地相关必备的基础知识
2. `MPC`
   1. `MCP`协议详解 `MCP Client/Server` 实现原理
3. 知识库
   1. 向量数据库
   2. `embedding`
4. 主流 `AI Agent` 架构
   1. `ReAct`
   2. `Plan-and-Execute`
   3. `Multi-Agent`
   4. `AI workflow`
5. AI前端工程实践：通过 `MCP` + 合理AI架构，解决实际的工程问题

### AI全栈工程

组件化思维、工程化能力和用户体验敏感度。端到端构建可落地的 `AI` 应用。

**`AI能力集成` -> 后端服务开发 -> 前端交互设计 -> 部署上线 -> 监控迭代** 全流程开发。

### 技能图谱

**第一优先级：`AI` 应用层核心技能**

<!-- prettier-ignore-start -->
|技能模块|核心知识点|学习重点|
|--|--|--|
|**大模型基础原理**|`Transformer`架构、上下文窗口、`Token` 计算、温度系数、`Top-P` 采样|理解“大模型如何生成文本”，重点掌握参数对输出的影响|
|**提示工程（`Prompt Engineering`）**|结构化提示、思维链（`CoT`）、少样本学习、角色设定、提示词优化|`AI` 应用开发的“第一语言”，积累提示词库|
|**检索增强生成（`RAG`）**|文档加载 -> 分块 -> 向量化 -> 向量存储 -> 检索 -> 重排序 -> 生成|`AI` 全栈的核心技术，企业级 `AI` 应用都基于 `RAG` 构建|
|**函数调用（`Function Calling`）**|工具定义、参数解析、多工具调用、错误处理|让大模型“能做事”而非“能说话”的关键，是 `Agent` 开发的基础|
|**`Agent` 开发**|规划能力、记忆系统、工具使用、多 `Agent` 写作|下一代 `AI` 应用的主流形态|
<!-- prettier-ignore-end -->

**第二优先级：编程能力扩展**

1. `Python` 基础
   - 核心语法：变量、数据类型、函数、类、异常处理
   - 常用库：`requests` （`API` 调用）、`pandas`（数据处理）、`numpy`（数值计算）
2. `typeScript` 深化
   - 强化：泛型、类型体操、异步编程（`Promise/async-await`）
   - 重点掌握：流式数据处理（`ReadableStream`）、`Web Worker`（多线程）、`Service Worker`（后台线程）

**第三优先级：`AI` 全栈后端技能**

1. 后端框架
   - `FastAPI`（首选）：`Python` 生态最火的 `AI` 后端框架，自动生成 `API` 文档，性能优异，与 `LangChain` 等 `AI` 库无缝集成
   - `NestJS`（备选）：`TypeScript`编写，`Node.js` 框架
2. 数据库
   - 传统数据库：`PostgreSQL`（支持向量扩展 `pgvector`，一库多用）
   - 向量数据库：`Chroma`（轻量本地）、`Pinecone`（云服务）、`Milvus` （开源企业级）
3. 中间件
   - 消息队列：`Redis`（简单场景）、`RabbitMQ`（复杂场景）
   - 缓存：`Redis`（缓存大模型响应、向量检索结果）

****

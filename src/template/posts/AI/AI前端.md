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
   - 文件处理：`PDF` 解析（`PyPDF2`、`LangChain` 文档加载器）、`Excel` 解析（`pandas`）

**第四优先级：前端 `AI` 技能**

- **流式输出实现**：使用 `fetch` + `ReadableStream` 实现打字机效果，处理中断与错误
- **`AI` 交互组件**：聊天界面、文件上传、进度条、思考过程展示
- **多模态交互**：语音输入（`Web Speech API`）、语音输出（`Web Speech Synthesis`）、图片上传与预览
- **前端 `AI` 推理**：使用 `Transformer.js` 在浏览器中运行小模型（如 `Llama 3 8B` 量化版）
- **`AI` 组件库**：`Vercel AI SDK`、`shadcn/ui AI` 组件、`LangChain JS`

**第五优先级：工程化部署**

- **容器化**：写 `Dockerfile` 和 `docker-compose.yml` 配置文件
- **云服务**：`Vercel` （前端 + `Next.js` 全栈一键部署）
- **模型部署**：`Ollama`（本地部署开源模型）、`vLLM` （高性能推理）
- **监控与运维**：日志收集(`ELK Stack`)、错误监控 `Sentry`、大模型调用监控 `LangSmith`
- **安全**：`API` 密钥管理、`Prompt` 注入防护、数据脱敏、限流与鉴权

### 实战项目

1. `RAG` 全流程：文档加载 -> 分块 -> 向量化 -> 向量存储 -> 检索 -> 重排序 -> 渲染生成
2. 向量数据库：掌握 `Chroma`、`Pinecone` 的使用，理解向量检索的基本原理
3. 函数调用：学习 `Function Calling`，能让大模型调用外部工具
4. `FastAPI`：学习 `FastAPI`，能编写简单的 `AI` 后端服务
5. `LangChain JS/Python`：掌握 `LangChain`的核心概念（链、工具、代理、`Memory`）

### 学习资源

#### 一、核心

<!-- prettier-ignore-start -->
| 学习阶段 | 技能模块 | 资源名称 | 核心内容/优势 | 访问地址 |
|---------|---------|---------|-------------|---------|
| **入门期（1-2个月）** | 全栈框架 | Next.js 15 App Router 官方文档 | AI应用90%后端逻辑可通过API路由/Server Actions实现，无需单独学Node.js | https://nextjs.org/docs |
| | AI SDK | Vercel AI SDK 5.x 官方文档⭐ | 前端转AI全栈第一入口，一行代码实现多模型切换、流式输出、工具调用 | https://sdk.vercel.ai/docs |
| | 大模型API | DeepSeek API 文档 | 国内访问速度快，完全兼容OpenAI接口，免费额度充足 | https://platform.deepseek.com/docs |
| | 实战教程 | Vercel官方AI Chatbot模板 | 开箱即用，集成shadcn/ui、Tailwind、多模型支持，直接fork修改 | https://vercel.com/templates/next.js/ai-chatbot |
| | | 从0到1用Vercel AI SDK实现AI对话应用 | 完整源码，包含流式输出、多轮对话、Supabase存储、Vercel部署 | https://blog.csdn.net/Zacks_xdc/article/details/158421034 |
| | 提示工程 | DeepLearning.AI《ChatGPT Prompt Engineering for Developers》⭐ | 全球最好的提示工程入门课，1小时掌握核心技巧 | https://www.deeplearning.ai/short-courses/chatgpt-prompt-engineering-for-developers/ |
| | | OpenAI官方提示工程指南 | 官方最佳实践，包含结构化提示、思维链等高级技巧 | https://platform.openai.com/docs/guides/prompt-engineering |
| | Python基础 | 《Python for JavaScript Developers》 | 专门写给前端开发者的Python教程，对比JS语法，快速上手 | https://pythonforjsdevs.com/ |
| **成长期（3-6个月）** | RAG核心技术 | LangChain JS 官方文档⭐ | 优先学JS版，与前端生态无缝集成，掌握文档加载、分块、检索全流程 | https://js.langchain.com/docs/ |
| | | 从零实现RAG：企业级问答系统实战 | 完整讲解RAG全流程，包含分块优化、检索重排序、上下文管理 | https://juejin.cn/post/7507840946038751242 |
| | | LangChain进阶：从Demo到生产级应用 | 重点讲生产环境坑点：缓存设计、错误处理、性能优化 | https://xie.infoq.cn/article/40bb7533533896540a41d563a |
| | 向量数据库 | Chroma 官方文档 | 纯JS实现，无需额外服务，适合原型开发和个人项目 | https://docs.trychroma.com/ |
| | | Pinecone 官方文档 | 托管云服务，无需运维，支持大规模向量检索 | https://www.pinecone.io/docs/ |
| | | pgvector + PostgreSQL | 一库多用，在PostgreSQL基础上扩展向量能力 | https://github.com/pgvector/pgvector |
| | 函数调用 | Vercel AI SDK 工具调用完全指南 | 用TS定义工具，自动处理参数解析和错误，比LangChain更简单 | https://sdk.vercel.ai/docs/guides/tools |
| | | OpenAI Function Calling 官方指南 | 行业标准，掌握工具定义、多工具调用、错误处理 | https://platform.openai.com/docs/guides/function-calling |
| | 后端基础 | FastAPI 官方教程 | Python后端首选，自动生成API文档，与LangChain无缝集成 | https://fastapi.tiangolo.com/tutorial/ |
| | | NestJS 官方文档 | TS后端首选，前端开发者零学习成本 | https://nestjs.com/docs/ |
| **成熟期（6-12个月）** | Agent开发 | LangGraph JS 官方文档⭐ | 目前最好的Agent框架，掌握状态管理、循环、多Agent协作 | https://langchain-ai.github.io/langgraphjs/ |
| | | DeepLearning.AI《AI Agentic Design Patterns with AutoGen》 | 免费系统课程，掌握Agent核心设计模式 | https://www.deeplearning.ai/short-courses/ai-agentic-design-patterns-with-autogen/ |
| | | 多Agent协作系统实战：CrewAI + Next.js | 完整实现产品开发团队多Agent系统，包含前后端联调 | https://www.iesdouyin.com/share/video/7559533782563310886 |
| | 前端AI推理 | Transformers.js 官方文档⭐ | 浏览器端AI推理事实标准，支持WebGPU加速，数据不离开设备 | https://huggingface.co/docs/transformers.js/index |
| | | Transformers.js + Llama 3 浏览器推理实战 | 在浏览器中运行Llama 3 8B量化版，实现离线聊天机器人 | https://juejin.cn/post/7536972217294127139 |
| | | WebLLM 官方文档 | 针对大语言模型优化的浏览器推理引擎，性能更优 | https://webllm.mlc.ai/ |
| | 大模型微调 | LlamaFactory 官方文档 | 低代码微调工具，支持一键LoRA/QLoRA微调，无需写复杂代码 | https://github.com/hiyouga/LLaMA-Factory |
| | | DeepLearning.AI《Finetuning Large Language Models》 | 免费入门课，掌握微调的适用场景和基本流程 | https://www.deeplearning.ai/short-courses/finetuning-large-language-models/ |
| | 工程化部署 | Ollama 官方文档⭐ | 本地部署开源模型首选，一行命令运行Llama 3、Qwen等 | https://ollama.com/docs |
| | | Docker 入门教程 | 容器化基础，AI应用部署必备 | https://docs.docker.com/get-started/ |
<!-- prettier-ignore-end -->

#### 二、前端AI专属

<!-- prettier-ignore-start -->
| 资源类型 | 资源名称 | 核心内容/优势 | 访问地址 |
|---------|---------|-------------|---------|
| AI组件库 | shadcn/ui AI组件 | 包含聊天界面、文件上传、思考过程展示等常用AI组件 | https://ui.shadcn.com/components |
| | Chatbot UI | 功能完整的开源聊天机器人界面，支持多模型、多会话、插件系统 | https://github.com/mckaywrigley/chatbot-ui |
| | Vercel AI Templates | 包含RAG、Agent、多模态等各种AI应用模板，一键部署 | https://vercel.com/templates?category=ai |
| 多模态交互 | Web Speech API 文档 | 浏览器原生API，实现语音输入和语音输出 | https://developer.mozilla.org/zh-CN/docs/Web/API/Web_Speech_API |
| | MediaPipe 官方文档 | 浏览器端实时图像、视频处理，支持手势识别、人脸检测等 | https://developers.google.com/mediapipe |
<!-- prettier-ignore-end -->

#### 三、工具与社区

<!-- prettier-ignore-start -->
| 资源类型 | 资源名称 | 核心内容/优势 | 访问地址 |
|---------|---------|-------------|---------|
| 开发工具 | Cursor⭐ | AI代码编辑器，内置GPT-4o，支持代码生成、重构、解释，效率提升10倍 | https://cursor.sh/ |
| | GitHub Copilot | 代码补全工具，与VS Code无缝集成 | https://github.com/copilot |
| | LangSmith | LangChain官方调试工具，用于调试和监控AI应用运行过程 | https://smith.langchain.com/ |
| 社区资讯 | Hugging Face | 全球最大的AI模型社区，下载开源模型、数据集 | https://huggingface.co/ |
| | GitHub Trending | 关注AI相关开源项目，跟进最新技术动态 | https://github.com/trending |
| | 掘金前端AI专栏 | 国内优质前端AI技术文章聚集地 | https://juejin.cn/column/7264354086042181668 |
| | 前端AI Weekly | 每周更新前端AI技术动态、开源项目、教程 | https://frontendaiweekly.com/ |
<!-- prettier-ignore-end -->

#### 四、书籍

<!-- prettier-ignore-start -->
| 书籍名称 | 核心内容/优势 |
|---------|-------------|
| 《图解大模型：生成式AI原理与实战全解析》 | 全程用图解拆概念，不用啃公式也能懂Transformer、RAG、Agent |
| 《LangChain实战：构建大语言模型应用》 | 系统讲解LangChain核心概念和实战技巧，包含大量代码示例 |
| 《AI全栈开发实战》（TypeScript版） | 专门针对前端开发者，用TS实现完整的AI全栈应用 |
<!-- prettier-ignore-end -->

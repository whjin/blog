## 子进程

> - 创建 `node` 子进程用 `fork`，自带通道方便通信

充分利用多核 `CPU` 的优势，用到 `child_process` 模块创建子进程，有四种方法可以创建子进程：

- `exec`
- `execFile`
- `spawn`
- `fork`

四个方法都会返回 `ChildProcess` 实例（继承自 `EventEmitter`），该实例拥有三个标准的 `stdio` 流：

1. `child.stdin`
2. `child.stdout`
3. `child.stderr`

子进程生命周期内可以注册监听的事件有：

- `exit`：子进程结束时触发，参数 `code` 错误码和 `signal` 中断信号
- `close`：子进程结束并且 `stdio` 流被关闭时触发，参数同 `exit` 事件
- `disconnect`：父进程调用 `child.disconnect()` 或子进程调用 `process.disconnect()` 时触发
- `error`：子进程无法创建、无法被杀掉、发消息给子进程失败时触发
- `message`：子进程通过 `process.send()` 发送消息时触发
- `spawn`：子进程成功创建时触发

`exec`、`execFile` 方法额外提供了一个回调函数，在子进程终止时触发：

### `exec`

`exec`方法用于执行 `base` 命令，它的参数是一个命令字符串。

```js
// 统计当前目录下的文件数量
const { exec } = reqwuire('child_process');
exec('find . -type f | wc -l', (err, stdout, stderr) => {
  if (err) return console.log(err);
  console.log(stdout);
});
```

`exec` 会新建一个子进程，然后缓存它的运行结果，运行结束后调用回调函数。

**由于 `exec` 会在内存中缓存全部的输出结果，当数据比较大时，`spawn` 会是更好的选择。**

**`execFile`**

`execFile` 和 `exec` 的区别：不会创建 `shell`，直接执行命令，更高效。参数作为数据传入，具有较高安全性。

```js
const { execFile } = require('child_process');
const child = execFile('node', ['--version'], (err, stdout, stderr) => {});
```

### `spawn`

`spawn` 函数默认不开启 `shell`，`execFile` 会缓存命令行的输出，然后把结果传入回调函数中，而 `spawn` 则是以流的方式输出。

```js
const { spawn } = require('child_process');
const child = spawn('wc');
process.stdin.pipe(child.stdin);
child.stdout.on('on', (data) => {});

// 统计当前目录下的文件数量
const find = spawn('find', ['.', '-type', 'f']);
const wc = spawn('wc', ['-l']);
find.stdout.pipe(wc.stdin);
wc.stdout.on('data', (data) => {});

// spawn 自定义配置
const options = {
  stdio: 'inherit', // 继承父进程的输入输出流 stdio
  shell: true, // 开启命令行模式
  cwd: '/User/xxx/code', // 指定执行目录
  env: { ANSWER: 42 }, // 指定环境变量（默认是 process.env ）
  detached: true, // 作为独立进程存在
};
```

### `fork`

`fork`函数是 `spawn` 函数的变体，使用 `fork` 创建的子进程和父进程之间会自动创建一个通信通道，子进程的全局对象 `process` 上面会挂载 `send` 方法。

```js
// 父进程 parent.js
const { fork } = require('child_process');
const forked = fork('./child.js');

forked.on('message', (msg) => {});
forked.send('hello');

// 子进程 child.js
process.on('message', (msg) => {});
let counter = 0;
setInterval(() => {
  process.send(counter++);
}, 1000);
```

当调用 `fork(./child.js)` 时，就是用 `node` 执行该文件中的代码，相当于 `spawn('node', ['./child.js'])`。

```js
// 用 Node.js 创建一个 http 服务，当路由为 `compute` 时，执行一个耗时的运算
const http = require('http');
const { fork } = require('child_process');
const server = http.createServer((req, res) => {});
server.on('request', (req, res) => {
  if (req.url === '/compute') {
    const compute = fork('./computer.js');
    compute.send('start');
    compute.on('message', (sum) => {
      res.end(`Sum is ${sum}`);
    });
  } else {
    res.end('ok');
  }
});
server.listen(3000);

// 解决 耗时运算占用 CPU，用户其他请求被阻塞
// 解决方案：把耗时运算放到子进程中去处理 compute.js
process.on('message', (msg) => {
  const sum = longComputation();
  process.send(sum);
});
```

更简单的处理方式是利用 `cluster` 模块。

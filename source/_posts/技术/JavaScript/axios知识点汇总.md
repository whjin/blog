---
title: axios知识点汇总
date: 2024-11-25 23:15:58
updated:
category: ["技术"]
tags: ["前端","JavaScript","Axios"]
cover: https://img2.baidu.com/it/u=1234823801,3673394801&fm=253&fmt=auto?w=1423&h=800
main_color: "#5A29E4"
keywords:
description:
top_img:
comments:
aside: 
---

# 简介

> `Axios`是一个基于`Promise`网络请求库，作用于`node.js`和浏览器中。在服务端使用原生`node.js http`模块，在浏览器段使用`XMLHttpRequest`。

- 拦截请求和响应
- 转换请求和响应数据
- 取消请求
- 超时处理
- 查询参数序列化支持嵌套项处理
- 自动将请求体序列化为：
    - `JSON（application/json）`
    - `Multipart/FormData(multipart/form-data)`
    - `URL encoded form(application/x-www-form-urlencoded)`
- 将`HTMLForm`转换为`JSON`进行请求
- 自动转换`JSON`数据
- 获取浏览器和`node.js`的请求进度，并提供额外的信息（速度、剩余时间）
- 为`node.js`设置带宽限制
- 兼容符合规范的`FormData`和`Blob`（包括`node.js`）
- 客户端支持防御`XSRF`

# API

- `axios.request(config)`
- `axiox.get(url[, config])`
- `axiox.delete(url[, config])`
- `axiox.head(url[, config])`
- `axiox.options(url[, config])`
- `axiox.post(url[, data[, config]])`
- `axiox.put(url[, data[, config]])`
- `axiox.patch(url[, data[, config]])`
- `axiox.postForm(url[, data[, config]])`
- `axiox.putForm(url[, data[, config]])`
- `axiox.patchForm(url[, data[, config]])`

# 请求配置

```json
{
    url: '/user',
    method: 'get',
    baseURL: 'https://some-domain.com/api/',

    // `transformRequest` 允许在向服务器发送前，修改请求数据
    // 它只能用于 'PUT', 'POST' 和 'PATCH' 这几个请求方法
    // 数组中最后一个函数必须返回一个字符串， 一个Buffer实例，ArrayBuffer，FormData，或 Stream
    // 你可以修改请求头。
    transformRequest: [function (data, headers) {
        // 对发送的 data 进行任意转换处理
        return data;
    }],

    // `transformResponse` 在传递给 then/catch 前，允许修改响应数据
    transformResponse: [function (data) {
        // 对接收的 data 进行任意转换处理
        return data;
    }],

    // 自定义请求头
    headers: { 'X-Requested-With': 'XMLHttpRequest' },
    // `params` 是与请求一起发送的 URL 参数
    // 必须是一个简单对象或 URLSearchParams 对象
    params: {
        ID: 12345
    },

    // `paramsSerializer`是可选方法，主要用于序列化`params`
    // (e.g. https://www.npmjs.com/package/qs, http://api.jquery.com/jquery.param/)
    paramsSerializer: function (params) {
        return Qs.stringify(params, { arrayFormat: 'brackets' });
    },

    // `data` 是作为请求体被发送的数据
    // 仅适用 'PUT', 'POST', 'DELETE 和 'PATCH' 请求方法
    // 在没有设置 `transformRequest` 时，则必须是以下类型之一:
    // - string, plain object, ArrayBuffer, ArrayBufferView, URLSearchParams
    // - 浏览器专属: FormData, File, Blob
    // - Node 专属: Stream, Buffer
    data: {
        firstName: 'Fred'
    },

    // 发送请求体数据的可选语法
    // 请求方式 post
    // 只有 value 会被发送，key 则不会
    data: 'Country=Brasil&City=Belo Horizonte',

    // `timeout` 指定请求超时的毫秒数。
    // 如果请求时间超过 `timeout` 的值，则请求会被中断
    timeout: 1000, // 默认值是 `0` (永不超时)

    // `withCredentials` 表示跨域请求时是否需要使用凭证
    withCredentials: false, // default

    // `adapter` 允许自定义处理请求，这使测试更加容易。
    // 返回一个 promise 并提供一个有效的响应 （参见 lib/adapters/README.md）。
    adapter: function (config) {
    },

    // `auth` HTTP Basic Auth
    auth: {
        username: 'janedoe',
        password: 's00pers3cret'
    },

    // `responseType` 表示浏览器将要响应的数据类型
    // 选项包括: 'arraybuffer', 'document', 'json', 'text', 'stream'
    // 浏览器专属：'blob'
    responseType: 'json', // 默认值

    // `responseEncoding` 表示用于解码响应的编码 (Node.js 专属)
    // 注意：忽略 `responseType` 的值为 'stream'，或者是客户端请求
    // Note: Ignored for `responseType` of 'stream' or client-side requests
    responseEncoding: 'utf8', // 默认值

    // `xsrfCookieName` 是 xsrf token 的值，被用作 cookie 的名称
    xsrfCookieName: 'XSRF-TOKEN', // 默认值

    // `xsrfHeaderName` 是带有 xsrf token 值的http 请求头名称
    xsrfHeaderName: 'X-XSRF-TOKEN', // 默认值

    // `onUploadProgress` 允许为上传处理进度事件
    // 浏览器专属
    onUploadProgress: function (progressEvent) {
        // 处理原生进度事件
    },

    // `onDownloadProgress` 允许为下载处理进度事件
    // 浏览器专属
    onDownloadProgress: function (progressEvent) {
        // 处理原生进度事件
    },

    // `maxContentLength` 定义了node.js中允许的HTTP响应内容的最大字节数
    maxContentLength: 2000,

    // `maxBodyLength`（仅Node）定义允许的http请求内容的最大字节数
    maxBodyLength: 2000,

    // `validateStatus` 定义了对于给定的 HTTP状态码是 resolve 还是 reject promise。
    // 如果 `validateStatus` 返回 `true` (或者设置为 `null` 或 `undefined`)，
    // 则promise 将会 resolved，否则是 rejected。
    validateStatus: function (status) {
        return status >= 200 && status < 300; // 默认值
    },

    // `maxRedirects` 定义了在node.js中要遵循的最大重定向数。
    // 如果设置为0，则不会进行重定向
    maxRedirects: 5, // 默认值

    // `socketPath` 定义了在node.js中使用的UNIX套接字。
    // e.g. '/var/run/docker.sock' 发送请求到 docker 守护进程。
    // 只能指定 `socketPath` 或 `proxy` 。
    // 若都指定，这使用 `socketPath` 。
    socketPath: null, // default

    httpAgent: new http.Agent({ keepAlive: true }),
    httpsAgent: new https.Agent({ keepAlive: true }),

    // `proxy` 定义了代理服务器的主机名，端口和协议。
    // 您可以使用常规的`http_proxy` 和 `https_proxy` 环境变量。
    // 使用 `false` 可以禁用代理功能，同时环境变量也会被忽略。
    // `auth`表示应使用HTTP Basic auth连接到代理，并且提供凭据。
    // 这将设置一个 `Proxy-Authorization` 请求头，它会覆盖 `headers` 中已存在的自定义 `Proxy-Authorization` 请求头。
    // 如果代理服务器使用 HTTPS，则必须设置 protocol 为`https`
    proxy: {
        protocol: 'https',
        host: '127.0.0.1',
        port: 9000,
        auth: {
            username: 'mikeymike',
            password: 'rapunz3l'
        }
    },

    cancelToken: new CancelToken(function (cancel) {
    }),

    decompress: true
}
```

# 默认配置

**全局`axios`默认值**

```JS
axios.defaults.baseURL = 'https://api.example.com';
axios.defaults.headers.common['Authorization'] = AUTH_TOKEN;
axios.defaults.headers.post['Content-Type'] = 'application/x-www-form-urlencoded';
```

**自定义实例默认值**

```JS
// 创建实例时配置默认值
const instance = axios.create({
  baseURL: 'https://api.example.com'
});

// 创建实例后修改默认值
instance.defaults.headers.common['Authorization'] = AUTH_TOKEN;
```

**配置的优先级**

配置将会按优先级进行合并。顺序是：在`lib/defaults.js`中找到的库默认值，然后是实例的`defaults`属性，最后是请求的`config`参数。后面的优先级要高于前面的。

```JS
// 使用库提供的默认配置创建实例
// 此时超时配置的默认值是 `0`
const instance = axios.create();

// 重写库的超时默认值
// 现在，所有使用此实例的请求都将等待2.5秒，然后才会超时
instance.defaults.timeout = 2500;

// 重写此请求的超时时间，因为该请求需要很长时间
instance.get('/longRequest', {
    timeout: 5000
});
```

# 拦截器

在请求或响应被`then`或`catch`处理前拦截。

```JS
// 添加请求拦截器
axios.interceptors.request.use(function (config) {
    return config;
}, function (error) {
    return Promise.reject(error);
});

// 添加响应拦截器
axios.interceptors.response.use(function (response) {
    // 2xx 范围内的状态码都会触发该函数。
    return response;
}, function (error) {
    // 超出 2xx 范围的状态码都会触发该函数。
    return Promise.reject(error);
});
```

稍后需要移除拦截器：

```JS
const interceptor = axios.interceptors.request.use(function () {/*...*/ });
axios.interceptors.request.eject(interceptor);
```

# 错误处理

使用`validateStatus`配置选项，可以自定义抛出错误的`HTTP code`。

```JS
axios.get('/user/12345', {
    validateStatus: function (status) {
        return status < 500; // 处理状态码小于500的情况
    }
});
```

使用`toJSON`可以获得更多关于`HTTP`错误的信息。

```JS
axios.get('/user/12345')
    .catch(function (error) {
        console.log(error.toJSON());
    });
```

# 取消请求

**`AbortController`**

从`v0.22.0`开始，`Axios`支持以`fetch API`方式——`AbortController`取消请求：

```JS
const controller = new AbortController();

axios.get('/foo/bar', {
    signal: controller.signal
}).then(function (response) {
});

controller.abort();
```

**`CancelToken` `deprecated`**

可以使用`CancelToken.source`工厂方法创建一个`cancel token`。

```JS
const CancelToken = axios.CancelToken;
const source = CancelToken.source();

axios.get('/user/12345', {
    cancelToken: source.token
}).catch(function (thrown) {
    if (axios.isCancel(thrown)) {
        console.log('Request canceled', thrown.message);
    } else {
        // 处理错误
    }
});

axios.post('/user/12345', {
    name: 'new name'
}, {
    cancelToken: source.token
});

// 取消请求（message 参数是可选的）
source.cancel('Operation canceled by the user.');
```

也可以通过传递一个`executor`函数到`CancelToken`的构造函数来创建一个`cancel token`：

> 可以使用同一个`cancel token`或`signal`取消多个请求。

```JS
const CancelToken = axios.CancelToken;
let cancel;

axios.get('/user/12345', {
    cancelToken: new CancelToken(function executor (c) {
        // executor 函数接收一个 cancel 函数作为参数
        cancel = c;
    })
});

// 取消请求
cancel();
```

在过渡期间，可以使用这两种取消`API`，即使是针对同一个请求：

```JS
const controller = new AbortController();

const CancelToken = axios.CancelToken;
const source = CancelToken.source();

axios.get('/user/12345', {
    cancelToken: source.token,
    signal: controller.signal
}).catch(function (thrown) {
    if (axios.isCancel(thrown)) {
        console.log('Request canceled', thrown.message);
    } else {
        // 处理错误
    }
});

axios.post('/user/12345', {
    name: 'new name'
}, {
    cancelToken: source.token
});

// 取消请求 (message 参数是可选的)
source.cancel('Operation canceled by the user.');
// 或
controller.abort(); // 不支持 message 参数
```

# 请求体编码

默认情况下，`axios`将`JavaScript`对象序列化为`JSON`。 要以`application/x-www-form-urlencoded`格式发送数据。

**浏览器**

在浏览器中，可以使用`URLSearchParams` `API`。

```JS
const params = new URLSearchParams();
params.append('param1', 'value1');
params.append('param2', 'value2');
axios.post('/foo', params);
```

可以使用`qs`库编码数据：

```JS
const qs = require('qs');
axios.post('/foo', qs.stringify({ 'bar': 123 }));
```
```JS
import qs from 'qs';
const data = { 'bar': 123 };
const options = {
    method: 'POST',
    headers: { 'content-type': 'application/x-www-form-urlencoded' },
    data: qs.stringify(data),
    url,
};
axios(options);
```

**自动序列化**

当请求头中的`content-type`是`application/x-www-form-urlencoded`时，`Axios`将自动地将普通对象序列化成`urlencoded`的格式。

# `Multipart`实体请求

## 使用`multipart/form-data`类型发起`POST`请求

### 使用`FormData API`

**浏览器**

```JS
const form = new FormData();
form.append('my_field', 'my value');
form.append('my_buffer', new Blob([1, 2, 3]));
form.append('my_file', fileInput.files[0]);

axios.post('https://example.com', form);
```

`Axios`会将传入数据序列化，因此使用`Axios`提供的`API`可以无需手动处理`FormData`的数据并实现一样的效果：

```JS
axios.postForm('https://httpbin.org/post', {
  my_field: 'my value',
  my_buffer: new Blob([1, 2, 3]),
  my_file: fileInput.files
});
```

`HTML`表单可以直接作为请求内容来进行传输。

**`Node.js`**

```JS
import axios from 'axios';

const form = new FormData();
form.append('my_field', 'my value');
form.append('my_buffer', new Blob(['some content']));

axios.post('https://example.com', form);
```

**自动序列化**

从`v0.27.0`版本开始，当请求头中的`Content-Type`是`multipart/form-data`时，`Axios`支持自动地将普通对象序列化成一个`FormData`对象。

```JS
import axios from 'axios';

axios.post('https://httpbin.org/post', {
  user: {
    name: 'Dmitriy'
  },
  file: fs.createReadStream('/foo/bar.jpg')
}, {
  headers: {
    'Content-Type': 'multipart/form-data'
  }
}).then(({ data }) => console.log(data));
```

`Axios FormData`序列化支持一些特殊的结尾，以执行以下操作：

- `{}`-通过`JSON.stringify`序列化数据
- `[]`-将`array-like`的对象使用相同的键值来展开为单独的字段

> 默认情况下，展开、扩展操作将在数组和`FileList`对象上使用。

`FormData`序列化支持通过`config.formSerializer:object`这个参数来传递一些额外的选项，以支持一些特殊的情况:

- `visitor: Function`-用户定义的处理函数，将递归调用以安装自定义规则将数据对象序列化为`FormData`对象
- `dots :boolean = false`-使用点符号而不是括号来序列化数组和对象。
- `metaTokens: boolean = true`-在`FormData`键值中添加特殊对象。后端的`body-parser`可能会使用此元信息自动将值解析为`JSON`。
- `indexes: null|false|true = false`-控制如何添加索引到打平的`array-like`对象的展开键值中
    - `null`-不添加中括号（`arr: 1,arr: 2,arr: 3`）
    - `false`（默认值）-添加空中括号（`arr[]: 1,arr[]: 2,arr[]: 3`）
    - `true`-添加带有索引的中括号（`arr[0]: 1,arr[1]: 2,arr[2]: 3`）

`Axios`支持一下别名方法：`postForm`，`putForm`，`patchForm`，这些方法只是对应的`HTTP`方法，其`content-type`头部默认设为`multipart/form-data`。
---
title: ADB命令集合
date: 2024-10-24 22:59:05
updated: 2024-10-24 23:04:23
category: ["技术"]
tags: ["Android","ADB"]
cover: https://s1.imagehub.cc/images/2025/04/09/d6368fce31cf7513d178f346463ccc22.md.webp
main_color: "#54C276"
keywords:
description:
top_img:
comments:
aside:
---

# 设备基础 #
|命令|说明|
|----|----|
|`adb devices`|列出已连接设备|
|`adb devices -l`|列出已连接设备和种类|
|`adb connect/disconnect [ip:port]`|连接到指定`IP`和端口的设备/断开连接|
|`adb root`|以`root`权限重新启动`adb`|
|`adb remount`|重新挂载具有读/写访问权限的文件系统|
|`adb start-server`|启动`adb`服务|
|`adb kill-server`|停止`adb`服务|
|`adb reboot`|重启设备|
|`adb reboot bootloader`|将设备重启到`fastboot`模式|
|`adb reboot recovery`|将设备重启到恢复模式|
|`adb disable-verify`|禁用设备的`dm-verity`安全特性|

# logcat #
|命令|说明|
|----|----|
|`adb logcat`|将日志消息打印到标准输出|
|`adb logcat -g`|显示当前日志缓冲大小|
|`adb logcat -G <size>`|设置缓冲区大小（`K`或`M`）|
|`adb logcat -c`|清除日志缓冲区|
|`adb logcat *:V`|启用所有日志消息（详细）|
|`adb logcat *:W`|显示优先级不低于**警告**的所有标记的所有日志消息|
|`adb logcat -f <filename>`|将日志转储到指定文件|

# 文件管理 #
|命令|说明|
|----|----|
|`adb push <local> <remote>`|将本地文件复制到远程设备|
|`adb pull <remote> <local>`|将远程设备文件复制到本地|

# 远程shell #
|命令|说明|
|----|----|
|`adb shell <command>`|在设备上运行指定的命令|
|`adb shell wm size`|显示当前屏幕分辨率|
|`adb shell wm size WxH`|将分辨率设置为`WxH`|
|`adb shell pm list packages`|列出所有已安装的应用包|
|`adb shell pm list packages -3`|列出所有已安装的第三方的应用包|
|`adb shell monkey -p app.package.name <count>`|启动指定包名的应用程序，并执行测试|
|`adb shell ls`|列出目录内容|
|`adb shell ls -s`|每个文件的打印尺寸|
|`adb shell ls -R`|递归列出子目录|

# 包安装 #
|命令|说明|
|----|----|
|`adb install <apk>`|安装应用程序|
|`adb install <path>`|从手机路径安装应用|
|`adb install -r <path>`|从手机路径安装应用（允许覆盖安装）|
|`adb uninstall <name>`|卸载应用程序|

# 包信息 #
|命令|说明|
|----|----|
|`adb shell pm list packages`|列出包名称|
|`adb shell pm list packages -f`|列出包+`apks`的路径|
|`adb shell pm list packages -3`|列出第三方包名称|
|`adb shell pm list packages -s`|仅列出系统包|
|`adb shell pm list packages -u`|列出包和未安装包|
|`adb shell pm list packages -i`|列出包名称+安装来源|
|`adb shell pm list packages -e`|列出启用的包|
|`adb shell pm list packages -d`|列出禁用的包|
|`adb shell dumpsys package packages`|列出所有应用程序的信息|
|`adb shell dumpsys package <name>`|列出一个包的信息|
|`adb shell pm path <package>`|列出`APK`文件的路径|

# 手机信息 #
|命令|说明|
|----|----|
|`adb get-state`|打印设备状态|
|`adb get-serialno`|获取设备的序列号|
|`adb shell dumpsys iphonesybinfo`|获取设备的`IMEI`信息|
|`adb shell netstat`|列出设备上的所有`TCP`连接|
|`adb shell pwd`|打印当前工作目录|
|`adb shell dumpsys dattery`|获取设备电池状态|
|`adb shell pm list features`|列出设备支持的所有功能|
|`adb shell service list`|列出设备上运行的所有服务|
|`adb shell dumpsys activity <package>/<activity>`|获取指定包和活动的信息|
|`adb shell ps`|打印设备上所有运行的进程状态|
|`adb shell wm size`|显示当前设备的屏幕分辨率|

# 设备相关 #
|命令|说明|
|----|----|
|`adb reboot recovery`|重启设备进入恢复模式|
|`adb reboot fastboot`|重启设备进入恢复模式|
|`adb reboot screencap -p "/path/to/screenshot.png"`|截图|
|`adb reboot screenrecord "/path/to/record.mp4"`|录制设备屏幕|
|`adb backup -apk -all -f backup.ab`|备份设置和应用程序|
|`adb backup -apk -shared -all -f backup.ab`|备份设置、应用程序和共享存储|
|`adb backup -apk -nosystem -all -f backup.ab`|仅备份非系统应用程序|
|`adb restore backup.ab`|恢复以前的备份|
|`adb shell am start -a android.intent.action.VIEW -d URL`|打开网址|
|`adb shell am start -t image/* -a android.intent.action.VIEW`|打开画廊|

# 权限 #
|命令|说明|
|----|----|
|`adb shell permissions groups`|列出所有已定义的权限组|
|`adb shell list permissions -g -r`|列出所有权限的详细信息|

# logs #
|命令|说明|
|----|----|
|`adb logcat [options][filter][filter]`|查看设备日志|
|`adb bugreport`|打印错误报告|

# 常见命令 #
|命令|说明|
|----|----|
|`adb push example.apk /sdcard/Download/`|将文件推送到`Android`设备的下载文件夹|
|`adb install example.apk`|从主机安装`APK`到`Android`设备|
|`adb shell settings put global http_proxy :0`|禁用网络代理|
|`adb shell pm list packages -f`|列出所有已安装的包并获取完整路径|
|`adb install /sdcard/Download/example.apk`|从`Android`设备存储安装`APK`|
|`adb devices`<br/>`adb -s 7f1c864e shell`|显示连接的设备并指定一个设备进行`shell`|
|`adb install /Users/dev/projects/myapp.apk`|将计算机上的`APK`文件安装到设备|
|`adb shell pm list packages \| grep app_name`|通过名称查找应用的包名|
|`adb push path/to/local/file /sdcard/foo.txt`|将文件从计算机复制到设备|
|`adb shell input text "Hello World"`|使用虚拟键盘发送文本|
|`adb shell input tap x y`|点击屏幕发送点击|
|`adb pull /sdcard/Download/example.apk`|从安卓设备中提取文件|
|`adb shell settings put global http_proxy <address>:<port>`|设置网络代理|
|`adb connect 192.168.56.101:5555`|通过`IP`地址连接到设备|
|`adb shell pm path com.example.myapp`|查找应用的`APK`路径|
|`adb shell pm path com.example.myapp`|从设备提取`APK`到计算机|
|`adb shell input swipe 300 300 500 1000`|滚动屏幕|
|`adb shell input keyevent 66`|发送按键事件|
|`adb shell 'logcat --pid=$(pidof -s <package_name>)'`|查看包的日志|
|`adb devices`<br/>`adb shell ifconfig`<br/>`adb tcpip 5555`<br/>`adb connect 192.168.1.4:5555`|记下`inet addr`后的`IP`地址。<br/>断开`USB`线缆|

# 命令
```js
.\adb.exe shell pm list package -3
```
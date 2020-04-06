---
title: Linux重装后必做!
date: 2020-02-16 12:45:54
tags: Linux
---

最近重装好几次Ubuntu了，每次重装后都有些准备工作要做，老是得上网查，这里记录一下所有步骤。

<!--more-->

### 1. 安装openssh-service

安装这个是为了用Xshell等连接工具连接到我们的虚拟机，使用终端界面。因为VM虚拟机里无法把主机的内容复制粘贴进去，装了VM Tools才行，所以现在用连接工具比较多。
使用下面的命令安装openssh-service：

```
sudo apt-get install openssh-server
```

安装完毕后，查看本机的ip，之后就可以通过连接工具登录啦。

### 2. 修改镜像源

ubuntu默认使用的是外国的镜像源，下载速度巨慢无比，务必换成国内镜像源。我通常使用的是阿里的镜像源，使用其他的也可。

首先先备份本地的源文件，位置在`/etc/apt/sources.list`

```
sudo cp /etc/apt/sources.list /etc/apt/sources.list.bk
```

然后用vim打开，源文件，将国内镜像粘贴进去。

```
sudo vi /etc/apt/sources.list
```

**Ubuntu 18.04 LTS 阿里云镜像**

```


# https://opsx.alibaba.com/mirror
deb https://mirrors.aliyun.com/ubuntu/ bionic main restricted universe multiverse 
deb https://mirrors.aliyun.com/ubuntu/ bionic-security main restricted universe multiverse 
deb https://mirrors.aliyun.com/ubuntu/ bionic-updates main restricted universe multiverse 
deb https://mirrors.aliyun.com/ubuntu/ bionic-proposed main restricted universe multiverse 
deb https://mirrors.aliyun.com/ubuntu/ bionic-backports main restricted universe multiverse 

# 仿照清华镜像源，注释了源码镜像以提高 apt update 速度，如有需要可自行取消注释
# deb-src https://mirrors.aliyun.com/ubuntu/ xenial main restricted universe multiverse 
# deb-src https://mirrors.aliyun.com/ubuntu/ xenial-security main restricted universe multiverse 
# deb-src https://mirrors.aliyun.com/ubuntu/ xenial-updates main restricted universe multiverse 
# deb-src https://mirrors.aliyun.com/ubuntu/ xenial-proposed main restricted universe multiverse 
# deb-src https://mirrors.aliyun.com/ubuntu/ xenial-backports main restricted universe multiverse


```

最后更新列表

```
sudo apt-get update
sudo apt-get upgrade
```

### 3. 安装vim

Ubuntu不知道为什么，默认安装的vim是个残次品，用起来相当难受，所以安装一下完整版的vim。

```
sudo apt install vim
```

### 4. 息屏

```
关闭息屏，最后0是代表关闭锁屏，将0替换为60代表60s后自动息屏，以此类推。
gsettings set org.gnome.desktop.session idle-delay 0
 
 
关闭锁屏
gsettings set org.gnome.desktop.screensaver lock-enabled false
```

### 5. gcc

```
sudo apt install gcc
```


---
title: 初识Maven
date: 2020-04-23 23:10:26
tags: Maven
---

<center>
  Maven介绍以及安装，换源
</center>

<!--more-->

## 什么是Maven

Maven 翻译为"专家"、"内行"，是 Apache 下的一个纯 Java 开发的开源项目。基于项目对象模型（缩写：POM）概念，Maven利用一个中央信息片断能管理一个项目的构建、报告和文档等步骤。

Maven 是一个项目管理工具，可以对 Java 项目进行构建、依赖管理。

## 环境配置

| 项目 |                             要求                             |
| :--: | :----------------------------------------------------------: |
| JDK  | Maven 3.3 要求 JDK 1.7 或以上<br> Maven 3.2 要求 JDK 1.6 或以上 <br>Maven 3.0/3.1 要求 JDK 1.5 或以上 |

**Mac通过brew安装Maven**

首先`brew search maven`得到以下结果：

```
==> Formulae
maven                         maven-shell                   maven@3.3
maven-completion              maven@3.2                     maven@3.5 ✔
==> Casks
mavensmate                                    homebrew/cask-fonts/font-maven-pro
```

可以选择直接下载maven，这个是最新版的，我下的是3.5这个版本。

下载命令：`brew install maven`或者`brew install maven@你想要的版本`

下载完成之后，我们还需要配置maven的环境变量。zsh环境变量在`~/.zshrc`中，我们加入下面的内容。（⚠️：每个操作系统环境变量可能不一样，以自己本机进行设置）

```
export M2_HOME=/usr/local/Cellar/maven@3.5/3.5.4_1/libexec
export PATH=$PATH:$M2_HOME/bin
```

添加后使文件生效：`source ~/.zshrc`

**测试是否安装成功**

利用`mvn -v`命令进行检测，得到下面的结果基本就没问题啦～

```
Apache Maven 3.5.4 (1edded0938998edf8bf061f1ceb3cfdeccf443fe; 2018-06-18T02:33:14+08:00)
Maven home: /usr/local/Cellar/maven@3.5/3.5.4_1/libexec
Java version: 11.0.2, vendor: Oracle Corporation, runtime: /Library/Java/JavaVirtualMachines/openjdk-11.0.2.jdk/Contents/Home
Default locale: zh_CN_#Hans, platform encoding: UTF-8
OS name: "mac os x", version: "10.15.3", arch: "x86_64", family: "mac"
```

## 阿里镜像

Maven仓库默认的是国外的仓库，下载速度感人，切换成国内的镜像下载就很快了，这里我换成了阿里的镜像源。

进入你刚下载maven的目录，然后打开conf目录下的settings.xml，找到mirrors健值对，在中间加上：

```xml
<mirrors>
    <mirror>
      <id>alimaven</id>
      <name>aliyun maven</name>
  　　<url>http://maven.aliyun.com/nexus/content/groups/public/</url>
      <mirrorOf>central</mirrorOf>        
    </mirror>
</mirrors>
```


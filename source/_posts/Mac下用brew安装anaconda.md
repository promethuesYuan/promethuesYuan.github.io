---
title: Mac下用brew安装anaconda
date: 2020-05-21 21:36:11
tags: Python
---

<center>
  机器学习作业要用到python，总结一下如何用brew轻松安装anaconda
</center>

<!--more-->

# 为什么要用anaconda

Anaconda是一个免费开源的Python和R语言的发行版本，用于计算科学（数据科学、机器学习、大数据处理和预测分析），Anaconda致力于简化包管理和部署。 Anaconda的包使用软件包管理系统Conda进行管理。超过1200万人使用Anaconda发行版本，并且Anaconda拥有超过1400个适用于Windows、Linux和MacOS的数据科学软件包。

有了anaconda之后，python的包管理会变的相当容易，搞python必装工具😎

# 安装过程

## 安装anaconda

在Mac上可以用brew来安装，只需要一句命令行即可开始安装

```bash
$ brew cask install anaconda
```

安装过程中可能又步骤会让你输入密码，输入即可

## 配置环境变量

安装完成后，还需要配置环境变量，才可以在命令行中使用conda

```bash
$ echo 'export PATH=/usr/local/anaconda3/bin:$PATH' >> ~/.bash_profile
$ source ~/.bash_profile  
```

第一个命令是将环境变量写入bash配置中，第二个则是加载配置，使其生效～

配置完后，来进行测试，看是否安装成功

```bash
$ conda -V
conda 4.8.3
```

出现了conda的版本，说明安装成功～


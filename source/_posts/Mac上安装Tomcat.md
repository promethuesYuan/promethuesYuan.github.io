---
title: Mac上安装Tomcat
date: 2020-04-15 21:07:17
tags: Java
---

<center>
  在Mac上安装Tomcat步骤记录
</center>

<!--more-->

## 1.安装Tomcat

先到官网上下载Tomcat：[https://tomcat.apache.org/download-80.cgi](https://tomcat.apache.org/download-80.cgi)。这里我下载的版本是Tomcat 8.5，可以根据自己的需要选择版本进行下载。

![](https://1900-1300387133.cos.ap-chengdu.myqcloud.com/image/20200415211233.png)



解压Tomcat文件，可以重新命名为`AppacheTomcat`，方便查找，最后放入/Library（系统资源库）文件夹中。该目录为隐藏文件夹，可以通过shift+command+g来进行跳转。

## 2.终端操作

进入刚才保存Tomcat的路径下，该目录下有以下文件：

![](https://1900-1300387133.cos.ap-chengdu.myqcloud.com/image/20200415211802.png)

我们输入`cd ./bin`,进入bin目录

进入后，需要修改文件的访问权限，在终端输入`sudo chmod 755 *.sh`，输完回车。此时需要输入密码，输入密码后回车。

修改完成后，就可以启动Tomcat了。终端输入`sudo sh ./startup.sh`，终端会输出以下内容：

![](https://1900-1300387133.cos.ap-chengdu.myqcloud.com/image/20200415212147.png)

从图中可以看出，Tomcat已经启动成功。

打开浏览器，网址框中输入：`localhost:8080`， 会出现以下画面

<img src="https://1900-1300387133.cos.ap-chengdu.myqcloud.com/image/20200415212332.png" style="zoom:50%;" />

想要关闭Tomcat的运行，在该目录下输入`sh ./shutdown.sh`,回车即可关闭


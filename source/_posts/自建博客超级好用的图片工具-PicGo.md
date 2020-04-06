---
title: '自建博客超级好用的图片工具:PicGo'
date: 2020-03-12 16:29:11
tags:
categories: 个人博客
---

<center>
    对个人博客来说,超级好用的图片管理工具,不容错过!
</center>

<!--more-->

## 图片的困扰😫

最开始写博客的时候,用的七牛云作为图床.博客里插入一张图片特别复杂,需要经历以下过程:

1. 打开七牛云点进自己存储空间
2. 点击上传一张图片
3. 上传完毕后,复制该图片的链接
4. 在博客中插入该链接

整个过程非常繁琐低效,导致我都不怎么喜欢插入图片.后来又因为我的七牛云没有域名备案没法使用,索性就一直没有加图片.最近发现了一个方便插入图片的神器,来和大家分享一下



## 神器:PicGo :rocket:

**介绍:PicGo  一个用于快速上传图片并获取图片URL链接的工具, 开源免费**

下载地址:[PicGo](https://github.com/Molunerfinn/PicGo/releases)

进入页面我们可以看到以下的下载选项,选择对应的操作系统下载即可

![](https://1900-1300387133.cos.ap-chengdu.myqcloud.com/image/20200312165915.png)

安装完成后打开软件,就可以看到以下的画面啦😉

![](https://1900-1300387133.cos.ap-chengdu.myqcloud.com/image/20200312170030.png)



## 如何使用

### 创建自己的云储存:cloud:

我们的图片需要上传到云存储中,推荐有[腾讯云](https://cloud.tencent.com/product/cos), [阿里云](https://www.aliyun.com/product/oss?spm=5176.10695662.1112155.1.2f2d36b9i9gSAT). 这两个产品都有各自的优惠, 选择一个你自己喜欢的就可以. 我选的是腾讯云, 之前用云服务器挺好用的.

购买成功后我们进入自己的对象存储管理界面, 创建新的存储桶

<img src="https://1900-1300387133.cos.ap-chengdu.myqcloud.com/image/20200312171109.png" style="zoom: 67%;" />

创建成功后, 我们进入该存储桶, 新增一个文件夹,如image, 我们的博客图片都将放置到该文件夹下

![](https://1900-1300387133.cos.ap-chengdu.myqcloud.com/image/20200312171237.png)

然后点击**密钥管理**来生成我们的密钥

![](https://1900-1300387133.cos.ap-chengdu.myqcloud.com/image/20200312171415.png)

新建密钥后,我们就得到了自己的SecretId和SecretKey

![](https://1900-1300387133.cos.ap-chengdu.myqcloud.com/image/20200312171507.png)

好了, 在云端服务器要做的都差不多了, 然后就是看软件如何配置啦😎~

### 配置PicGo

打开软件, 我们来到图床设置的腾讯云COS(ps:此处根据自己的图床服务商来选择), 可以看到以下画面

![](https://1900-1300387133.cos.ap-chengdu.myqcloud.com/image/20200312172049.png)

说一下这几个配置:

- COS现基本都是v5了, 所以咱们选到v5
- SecretId, SecretKey, APPID 在咱们刚才配置密钥的地方有, 复制粘贴过来
- 存储空间名: 就是我们存储桶的名, 可以再腾讯云对象存储->存储桶列表看到, 确认存储区也是的, 都复制过来
- 指定存储路径: 这个就是咱们刚才创建的那个image文件夹, 以后图片都会存到该目录下
- **设置为默认图床:**咱就一个图床, 设置成为默认以后都会发到我的腾讯云图床上

OK, 到现在咱们的PicGo就已经配置好了, 马上开用!🤩

### 具体使用

来到我们的上传区

![](https://1900-1300387133.cos.ap-chengdu.myqcloud.com/image/20200312170030.png)

我们可以把需要上传的图片拖到上传区域, 也可以点击上传按钮批量上传. 学习中我们需要很多的截图, **剪贴板图片上传**就很好用了.

链接格式. 由于我们是写markdown, 就选择Markdown格式就行, 如果有别的用途也可以选择.

我们随便上传一张图片, 上传完成, Windows电脑右下角会有如下提示

<img src="https://1900-1300387133.cos.ap-chengdu.myqcloud.com/image/20200312173218.png" style="zoom:50%;" />

❗注意, 上传成功后, 会自动生成该图片链接的markdown语句, 我们只需要ctrl+v, 就可以复制到我们的博客中啦~真的是超级好用

### 进阶使用

我们可以再相册页面进行图片批量的删除和复制

![](https://1900-1300387133.cos.ap-chengdu.myqcloud.com/image/20200312173632.png)



老是开着这个窗口, 拖照片挺麻烦的, 怎么办:question:

windows下可以把窗口最小化, 功能也很丰富, 拖动照片到这个小蓝圈上就可以上传了

![](https://1900-1300387133.cos.ap-chengdu.myqcloud.com/image/20200312173906.png)

**终极无敌好用的快捷键😆**

我们在软件页面点击PicGo设置

<img src="https://1900-1300387133.cos.ap-chengdu.myqcloud.com/image/20200312174127.png" style="zoom:80%;" />

点击修改快捷键, 我把快捷键改成了ctrl + [ , 觉得非常好用

<img src="https://1900-1300387133.cos.ap-chengdu.myqcloud.com/image/20200312174237.png" style="zoom:80%;" />

## 最后

好了, 现在我们可以截图 - 快捷键上传 - 快捷键粘贴, 一气合成插入图片了, 软件的作者真的太厉害了:thumbsup:

希望这篇文章能对你有所帮助, 一起写博客勤积累, 做个life-long learner吧~
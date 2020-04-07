---
title: hexo迁移
date: 2020-04-06 23:43:11
tags:
categories: 个人博客
---

<center>
  迁移hexo博客
</center>
<!--more-->

最近换电脑了，需要把之前电脑上的hexo博客相关内容进行迁移。通过网上博客以及知乎上相关内容学习，最终迁移成功，写一下博客记录一下整个过程。

参考资料：[使用hexo，如果换电脑了怎么办](https://www.zhihu.com/question/21193762/answer/489124966)

## GitHub同步

`hexo d`部署到GitHub上的内容都是hexo编译后的文件，不包含本地的源文件。所以可以利用GitHub的分支管理，将源文件上传到GitHub的另一个分支。



## hexo分支

在自己的博客仓库创建一个hexo分支，如下图所示：

:framed_picture:

在仓库的设置settings中，选择默认分支为hexo分支，如下所示：

:framed_picture:

然后在本地的任意目录下，将自己的仓库clone下来

`git clone git@github.com:xxx/xxx.github.io.git`

(PS:将xxx换成自己对应的名称)

打开该目录，保留.git文件，其余文件删除。把之前博客的源文件复制过来，除去.deploy_git文件。

:warning:注意，如果之前主题文件是通过克隆下来的，应该把主题文件中.git文件删除。原因是git不能嵌套上传，不删除的话主题文件会无法上传。

最后

```
git add .
git commit -m "hexo branch"
git push
```

上传完毕，可以去hexo分支检查一下内容是否与本地一致。注意，`node_modules`、`public`、`db.json`三个文件因为`.gitignore`忽略上传了，分支没有这三个内容是正常情况。



## 迁移至新电脑

首先，安装并配置`git`、`npm`、`hexo`

然后在任意目录下`git clone`你的博客

然后进入该文件夹，进行如下操作：

```
npm install
npm install hexo-deployer-git --save
```

生成并部署hexo 博客：`hexo g -d`

然后就可以在该电脑继续写文章啦～:happy:
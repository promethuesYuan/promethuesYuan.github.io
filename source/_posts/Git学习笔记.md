---
title: Git学习笔记
date: 2019-09-01 16:25:02
tags: Git
categories: 学习笔记
---

一直说是要学习Git，但总是一拖再拖。花了不到一天的时间，就把廖老师的Git教程学完了，受益匪浅，接下来可以在GitHub玩耍了233。顺便掌握了一些windows命令行操作，也很有用。

<!--more-->

# Git的第一步——创建版本库

创建版本库

```
$ mkdir <repository name>
$ cd <repository name>
创建一个目录

$ git init （创建一个版本库）
Initialized empty Git repository in <当前路径>.git/

添加文件到Git仓库，分两步:
$ git add <file name>
$ git commit -m <message>
可以先多次添加，最后一次提交
```



# 版本控制

版本回退

```
$ git log
$ git log --pretty=oneline
显示从最近到最远的提交日志

$ git reset --hard HEAD~<num>(往前num个版本)
$ git reset --hard <commit id>(前往对应的提交版本)
修改HEAD指向的版本，HEAD指向的版本就是当前版本

$ git reflog 查看命令历史，以便确定要回到未来的哪个版本
```



工作区和暂存区

```
$ git status 常看状态
```



管理修改

```
$git diff HEAD -- <file name>
查看工作区和版本库里面最新版本的区别
```



撤销修改

```
$ git checkout -- file
总之，就是让这个文件回到最近一次git commit或git add时的状态

$ git reset HEAD <file>
可以把暂存区的修改撤销掉（unstage），重新放回工作区
```



删除文件

```
情况一：将版本库中的删除
$ git rm删掉，并且git commit
情况二：误删除，需要恢复到版本库中
$ git checkout -- test.txt
```



# 远程仓库

添加远程仓库

```
$ git remote add origin git@github.com:michaelliao/learngit.git
连接远程仓库，github.com：后面接的是自己需要关联的仓库

$ git push -u origin master
将本地内容推到远程仓库

第一次推送master分支的所有内容的命令行需要带 -u
此后，每次本地提交后，只要有必要，就可以使用命令git push origin master推送最新修改
```



从远程仓库克隆到本地

```
$ git clone git@github.com:michaelliao/gitskills.git
从远程仓库克隆到当前目录下，同样的，github.com：后面接的是自己需要克隆的仓库
```



# 分支管理

创建与合并分支

```
$ git checkout -b <branch name>
创建并且切换到该 分支上

$ git branch 
查看当前分支情况，*对应的是当前所在的分支

$ git checkout master
切回到主分支

$ git merge <branch name>
将该分支合并到主分支上

$ git branch -d <branch name>
删除该分支
```



解决冲突

```
当Git无法自动合并分支时，就必须首先解决冲突。解决冲突后，再提交，合并完成。
解决冲突就是把Git合并失败的文件手动编辑为我们希望的内容，再提交。
用git log --graph命令可以看到分支合并图。
```



分支管理策略

```
合并分支时，加上--no-ff参数就可以用普通模式合并，合并后的历史有分支，能看出来曾经做过合并，而fast forward合并就看不出来曾经做过合并。
```



Bug分支

```
修复bug时，我们会通过创建新的bug分支进行修复，然后合并，最后删除；
当手头工作没有完成时，先把工作现场git stash一下，然后去修复bug，修复后，再git stash pop，回到工作现场；
在master分支上修复的bug，想要合并到当前dev分支，可以用git cherry-pick <commit>命令，把bug提交的修改“复制”到当前分支，避免重复劳动。
```



Feature分支

```
开发一个新feature，最好新建一个分支；
如果要丢弃一个没有被合并过的分支，可以通过git branch -D <name>强行删除。
```



多人协作

**(由于没有多人协作的项目经验，这一块看的并不是很明白，只能先把小结部分的内容接下来，以后有类似经验了再消化吸收)**

```
查看远程库信息，使用git remote -v；
本地新建的分支如果不推送到远程，对其他人就是不可见的；
从本地推送分支，使用git push origin branch-name，如果推送失败，先用git pull抓取远程的新提交；
在本地创建和远程分支对应的分支，使用git checkout -b branch-name origin/branch-name，本地和远程分支的名称最好一致；
建立本地分支和远程分支的关联，使用git branch --set-upstream branch-name origin/branch-name；
从远程抓取分支，使用git pull，如果有冲突，要先处理冲突。
```



Rebase

```
$git rebase
（这个操作也是没有实践不大好理解啊，就先放这儿）
```

# 标签管理

创建标签

```
命令git tag <tagname>用于新建一个标签，默认为HEAD，也可以指定一个commit id；
命令git tag -a <tagname> -m "blablabla..."可以指定标签信息；
命令git tag可以查看所有标签。
```



操作标签

```
命令git push origin <tagname>可以推送一个本地标签；
命令git push origin --tags可以推送全部未推送过的本地标签；
命令git tag -d <tagname>可以删除一个本地标签；
命令git push origin :refs/tags/<tagname>可以删除一个远程标签。删除远程标签时，需要先删除本地标签。
```



# 配置别名

这个看完了感觉还是很实用的，可以把一些比较长的命令行给简化拼写。
我这刚刚入门，也不知道这么配置完了之后如果有问题，如何再修改回原来的配置，所以就先用着默认指令吧，以后再来修改。



# windows下一些命令行操作

```
ls dir 当前目录下的文件
pwd chdir 显示当前所在的路径
cat type <file> 显示文件内容
rm del <file> 删除文件
cd .. 返回上一级目录
```


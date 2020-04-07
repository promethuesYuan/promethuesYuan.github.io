---
title: 解决homebrew下载过慢
date: 2020-04-07 19:36:19
tags: homebrew
---

<center>
  homebrew原生镜像下载过慢，本博客给出解决方法
</center>

<!--more-->

**第一步：跟换镜像源**

此处我是将homebrew的镜像源换成了清华镜像，相关操作如下

```
cd "$(brew --repo)"
git remote set-url origin https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git

cd "$(brew --repo)/Library/Taps/homebrew/homebrew-core"
git remote set-url origin https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git

brew update
```



**第二步：更换homebred-bottles镜像**

```
echo 'export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles' >> ~/.bash_profile
source ~/.bash_profile
```

PS:如果使用的shell不是bash而是zsh的话，则把.bash_profile改成.zshrc
---
title: Xshell中显示用户名和主机颜色
date: 2020-02-15 20:42:22
tags: Linux
---

最近开始用Xshell连接虚拟机，虽然Xshell可以更改配色方案，终端中默认不显示用户名和主机名的颜色，命令一多，非常难以辨认。于是记录一下如何使用户名和主机名显色。
<!--more-->
修改用户目录下的`.bashrc`文件  
1. 通过vi打开该文件，`vi ~/.bashrc`
2. 在文件稍微靠后的位置找到这么一句话，`# force_color_prompt=yes` , 把注释注销掉，保存退出
3. 加载文件。`source ~/.bashrc`
4. 然后就可以看到Xshell终端中用户名和主机名颜色变成主题对应的颜色了。
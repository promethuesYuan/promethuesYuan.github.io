---
title: Pycharm中文报错
date: 2020-04-22 23:31:37
tags:
---

<center>
  解决Pycharm中中文注释报错的问题
</center>

<!--more-->

尝试用python来生成数据库实验的数据源时，运行程序出现了以下错误

```
SyntaxError: Non-ASCII character '\xe6' in file test/t.py on line 19, but no encoding declared; see http://python.org/dev/peps/pep-0263/ for details
```

从错误信息中大概能猜测出跟字符集有关，应该是程序中有中文的缘故，不知道为什么注释中有中文也会报错= =

解决方法是在当前文件的文件头加上`# -*- coding:utf8 -*-` 表明使用utf-8的字符集，即可正常运行


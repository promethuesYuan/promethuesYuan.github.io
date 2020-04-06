---
title: printf与十六进制
date: 2019-10-06 23:25:07
tags: C++
categories: 学习笔记
---

<center>
    如何用printf输出十六进制
</center>

<!--more-->

CSP里面用到十六进制的地方还是挺多的，所以记录一下如何输出十六进制数据。

```c++
int a = 0xf;
printf("%x\n", a); //x为小写时，输出a~f
printf("%X\n", a); //注意这里的X为大写，输出时A~F为大写
printf("%4x\n", a); //补齐为4位，左边补空格
printf("%04x\n", a); //补齐为4位，左边补0
```

结果

```
f
F
   f
000f
```


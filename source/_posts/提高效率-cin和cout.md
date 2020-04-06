---
title: '提高效率:cin和cout'
date: 2019-10-06 23:02:27
tags: C++
categories: 学习笔记
---

<center>
    做题还是少用cin/cout,转用scanf/printf吧
</center>

<!--more-->

今天做CSP：190303_RAID5这个题的时候，第一版做完结果30分，运行超时。费劲心思优化之后，还是一样的结果。不知道怎么优化后，去网上查别人的解法。看别人代码的时候主意到了这么一句话

```c++
	std::ios::sync_with_stdio(false);//避免c++中cin操作超时。 
```

觉得可能跟这个原因有关，于是在代码中加上了上面这句话，于是就AC了...小伙感觉非常震惊，于是去网上了解详情。

**博客解释**

cin，cout之所以效率低，是因为先把要输出的东西存入缓冲区，再输出，导致效率降低，而这段语句可以来打消iostream的输入输出缓存，可以节省许多时间，使效率与scanf与printf相差无几，还有应注意的是scanf与printf使用的头文件应是stdio.h而不是iostream。

sync_with_stdio函数是一个“是否兼容stdio”的开关，C++为了兼容C，保证程序在使用了std::printf和std::cout的时候不发生混乱，将输出流绑到了一起。

所以以后要是大型输入输出时候，采用cin/cout还是需要加上这句话来提速。
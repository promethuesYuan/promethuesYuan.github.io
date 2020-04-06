---
title: (转)C++中struct和class的区别
date: 2019-09-27 21:14:02
tags: C++
categories: 学习笔记
---

<center>
初学C++，对struct的用法感觉非常奇怪，和C中差别挺大。看到一篇博客写的挺好，转载一下。    
</center>

<!--more-->

原博客地址：[C++中struct和class的区别](https://www.cnblogs.com/ccsccs/articles/4025215.html)

1）默认的继承访问权限。struct是public的，class是private的。

如果不知道什么是public继承，什么是private继承的，可以去查书，这里暂不讨论。

你可以写如下的代码：

```c++
struct A
{
char a;
}；

struct B : A
{
char b;
}；
```

这个时候B是public继承A的。如果都将上面的struct改成class，那么B是private继承A的。这就是默认的继承访问权限。所以我们在平时写类继承的时候，通常会这样写：

```c++
struct B : public A
```

就是为了指明是public继承，而不是用默认的private继承。

当然，到底默认是public继承还是private继承，取决于子类而不是基类。我的意思是，struct可以继承class，同样class也可以继承struct，那么默认的继承访问权限是看子类到底是用的struct还是class。如下：

```c++
struct A{}；

class B : A{}; //private继承

struct C : B{}； //public继承
```



2）struct作为数据结构的实现体，它默认的数据访问控制是public的，而class作为对象的实现体，它默认的成员变量访问控制是private的。

注意我上面的用词，我依   旧强调struct是一种数据结构的实现体，虽然它是可以像class一样的用。我依旧将struct里的变量叫数据，class内的变量叫成员，虽然它   们并无区别。其实，到底是用struct还是class，完全看个人的喜好，你可以将你程序里所有的class全部替换成struct，它依旧可以很正常   的运行。但我给出的最好建议，还是：当你觉得你要做的更像是一种数据结构的话，那么用struct，如果你要做的更像是一种对象的话，那么用class。

当然，我在这里还要强调一点的就是，对于访问控制，应该在程序里明确的指出，而不是依靠默认，这是一个良好的习惯，也让你的代码更具可读性。


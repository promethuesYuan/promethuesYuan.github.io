---
title: C++解题时的使用技巧
date: 2019-09-03 10:41:01
tags: C++, CSP, 数据结构与算法
categories: 学习笔记
---

<center>记录使用C++做CSP题目时用到的一些C中没用过的数据结构和算法</center>
<!--more-->

### 快排sort

#### 用法

>头文件 #include<algorithm>
>sort函数可以有两个参数，也可以有三个参数：
>
>1. 排序数组起始位置
>2. 排序数组结束为止
>3. 排序的方法，确认是升序还是降序，默认缺省情况为升序排序

#### 举例

```c++
#include <iostream>
#include <algorithm>
int main()
{
 int a[20]={2,4,1,23,5,76,0,43,24,65},i;
 for(i=0;i<20;i++)
  cout<<a[i]<<endl;
 sort(a,a+20);
 for(i=0;i<20;i++)
 cout<<a[i]<<endl;
 return 0;
}
```

注意sort函数第二个参数的范围。

下面主要举例讲解三个参数用来解决结构数组排序的问题。

在CSP 17-3-2排队问题中，我用了一个结构体来表示每个同学，其中包含他的学号和位置。我需要sort函数来对他们的位置进行排序，这个时候就需要用到带有三个参数的sort函数了。

**结构体声明如下**

```c++
typedef struct stu{
    int id;
    int place;
}stu;
```

**第三个参数函数声明如下**

````c++
bool cmp(stu a, stu b)
{
    return a.place < b.place;
}
````

因为我是要对他们的位置进行排序，而且是升序排序。通过修改return 的内容，可以实现对其他方面的排序以及修改排序的升降。

**使用方法**

``` c++
sort(array+1, array+1+n, cmp);
```

这样就能对结构数组其中的位置信息进行排序了。



### 栈和队列

#### stack

模板类定义在#include<stack>中
定义示例代码：`stack<int> s`
基本操作如下

| 操作      | 作用                                   |
| :-------- | -------------------------------------- |
| s.push(x) | 入栈                                   |
| s.pop()   | 出栈，注意该操作只删除元素，不返回元素 |
| s.top()   | 访问栈顶                               |
| s.empty() | 栈是否为空，为空时返回true             |
| s.size()  | 访问栈的元素个数                       |

#### queue

模板类定义在#include<queue>中
定义示例代码：`queue<int> q`
基本操作如下

| 操作      | 作用                                     |
| --------- | ---------------------------------------- |
| q.push(x) | 入队                                     |
| q.pop()   | 出队，弹出队列第一个元素，但不会返回其值 |
| q.front() | 访问队首元素，即第一个入队的             |
| q.back()  | 访问队尾元素，即最后一个入队的           |
| q.empty() | 判断队空，若为空返回true                 |
| q.size()  | 访问队元素个数                           |

#### 示例

``` c++
#include<iostream>
#include<stack>
#include<queue>
using namespace std;

void stackFunction()
{
    stack<int> s;
    //入栈
    s.push(1);
    s.push(2);
    s.push(3);
    //栈元素个数
    cout<<"size of stack:"<<s.size()<<endl;
    //栈顶元素
    cout<<"top of stack:"<<s.top()<<endl;
    //出栈
    s.pop();
    cout<<"after pop, top of stack is:"<<s.top()<<endl;
    //栈空
    if(!s.empty()) cout<<"stack is not empty"<<endl;
    s.pop();
    s.pop();
    if(s.empty() )  cout<<"stack is empty now"<<endl;
}

void queueFunction()
{
    queue<int> q;
    //入队
    q.push(1);
    q.push(2);
    q.push(3);
    //队首元素
    cout<<"front of queue:"<<q.front()<<endl;
    //队尾元素
    cout<<"back of queue:"<<q.back()<<endl;
    //队长度
    cout<<"size of queue:"<<q.size()<<endl;
    //出队
    q.pop();
    cout<<"after pop, front of queue is:"<<q.front()<<endl;
    //队空
    if(!q.empty()) cout<<"queue is not empty"<<endl;
    q.pop();
    q.pop();
    if(q.empty() )  cout<<"queue is empty now"<<endl;
} 

int main()
{
    stackFunction();
    cout<<endl;
    queueFunction();
    cout<<endl;
    return 0;
}
```

结果

```
size of stack:3
top of stack:3
after pop, top of stack is:2
stack is not empty
stack is empty now

front of queue:1
back of queue:3
size of queue:3
after pop, front of queue is:2
queue is not empty
queue is empty now
```

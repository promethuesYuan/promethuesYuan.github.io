---
title: C++之list
date: 2019-10-15 14:44:20
tags: C++, list
categories: 解题记录
---

<center>
    记录C++中list的用法
</center>

<!--more-->

### **list的实现**

list是 每个节点包含前继节点，后继节点，数据域三部分的双向循环链表。和普通链表性质一样，不提供随机访问，访问时间复杂度为0(n)，适合插入和删除。

头文件`#include<list>`

### **list包含的函数**

**1.声明list**

1. list list1; // 声明一个空的list1
2. list list3 (list2.begin(), list2.end()); // 用list2的迭代器内容声明list3
3. list list4 (list3); // 声明list4为list3的一个副本
4. list1.~list(); // 注销list

**2.访问元素**

1. list.front(); //返回第一个元素的值

2. list.back(); //返回最后一个元素的值

3. list.begin(); //返回第一个元素的迭代器

4. list.end(); //返回最后一个元素的迭代器

5. 遍历

   ```c++
   list<int> a;
   list<int>::iterator iter = a.begin();
   //或者 auto iter = a.begin();
   while(iter!=a.end()){
       cout<< *iter++ <<endl;
   }
   ```

**3.添加、删除元素**

1. list.pop_front(); //删除第一个元素
2. list.pop_back(); //删除最后一个元素
3. list.clear(); //清空list
4. list.insert(iter, t); //在iter之前插入元素t
5. list.erase(iter, t); //删除iter处的元素

如何控制iter位置：

```c++
auto iter = a.begin();
srd::advance(iter, 10); //将iter往后移10位
a.erase(iter); //此时删除的就是第十一个元素
```

**4.排序**

1. list.sort(); //默认升序排序
2. list.reverse(); //将list元素反转
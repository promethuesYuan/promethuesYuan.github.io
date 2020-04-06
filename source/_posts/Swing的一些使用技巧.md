---
title: Swing的一些使用技巧
date: 2019-09-25 00:10:14
tags: Swing, Java
categories: 学习笔记
---



<center>
记录一些Swing做GUI时候的一些技巧
</center>

<!--more-->

**窗体居中设置**

```Java
this.setLocationRelativeTo(null);//窗体居中显示
```



**窗口自适应大小**
用Java代码先获得屏幕大小，然后在设置宽高。获得屏幕大小代码如下

```java
Dimension screen=Toolkit.getDefaultToolkit().getScreenSize();//得到屏幕的大小
System.out.println (screen.getWidth());//输出屏幕的宽度
System.out.println (screen.getHeight());//输出屏幕的高度
```

然后可以设置相应的bounds的比例



**String使用的一个小经验**
下午在做判断两个字符串是否相等的时候，我用了==来进行判断，但一直会出错，当时一直不明白为什么。旁边的同学提醒我看idea的提示，让我改用equals()来判断，改完后就正确了。我就突然明白，两个字符串常量比较时候可以用==，因为他们判断时是判断他们是否指向同一个字符串。equals()是来判断两个字符串是否相等。
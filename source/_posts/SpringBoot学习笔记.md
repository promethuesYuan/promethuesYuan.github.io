---
title: SpringBoot学习笔记
date: 2020-05-04 23:25:20
tags: SpringBoot
---

<center>
  SpringBoot学习过程整理的笔记～
</center>

<!--more-->

# 第一个spring boot程序

创建项目：

- 官网生成
- idea创建



# 自动装配原理初探

> Spring没看，直接看这一块太苦难了:weary:  索性先跳了



# Spring boot配置

Springboot推荐使用yaml进行配置

yaml也可以对实体类进行赋值

 

# Web开发

需要结局的问题：

- 导入静态资源
- 创建首页
- 模版引擎Thymeleaf
- 装配扩展SpringMVC
- CRUD
- 拦截器
- 国际化



## 静态资源

1. Springboot下，可以用以下方式访问静态资源
   - Webjars `localhost:8080/webjars`
   - public, static, resources, /** `localhost:8080/`

2. 优先级：resources > static(默认) > public


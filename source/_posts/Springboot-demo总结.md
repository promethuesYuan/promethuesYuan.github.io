---
title: Springboot demo总结
date: 2020-05-19 20:42:33
tags: Springboot
---

<center>
  学习完Springboot后，对于如何使用其进行开发还有些一知半解，通过一个小demo整合来熟悉开发流程～
</center>

<!--more-->

## 项目概况👨‍💻

初学者整合项目，实现了一些基本的功能，目的是为了熟悉开发的整个过程。项目中一共两种角色，用户以及员工。

用户的功能：`注册和登录`

员工的功能：`对员工列表进行CRUD`

**整合的一些技术栈**

- Springboot
- mybatis
- druid
- thymeleaf

## 项目搭建步骤

### 通过idea初始化项目

选择所需要用的依赖

<img src="https://1900-1300387133.cos.ap-chengdu.myqcloud.com/image/image-20200519204954547.png" alt="image-20200519204954547" style="zoom:67%;" />

mybatis和druid的依赖无法在项目初始化时加入，从maven仓库得到两个的依赖

```xml

<!--mybatis-springboo-->
<dependency>
  <groupId>org.mybatis.spring.boot</groupId>
  <artifactId>mybatis-spring-boot-starter</artifactId>
  <version>2.1.2</version>
</dependency>
<!--druid -->
<dependency>
  <groupId>com.alibaba</groupId>
  <artifactId>druid</artifactId>
  <version>1.1.22</version>
</dependency>
```

### 建立项目结构

<img src="https://1900-1300387133.cos.ap-chengdu.myqcloud.com/image/image-20200519205302720.png" alt="image-20200519205302720" style="zoom:67%;" />

项目的基本结构搭建如上图，需要得到thymeleaf支持的html文件需要放在templates下

### 编写配置文件

```yaml
server:
  servlet:
    context-path: /ems

spring:
  datasource:
    type: com.alibaba.druid.pool.DruidDataSource
    driver-class-name: com.mysql.cj.jdbc.Driver
    url: jdbc:mysql://localhost:3306/ems?serverTimezone=UTC&userUnicode=true&characterEncoding=UTF-8
    username: xxxx
    password: xxxxx
  resources:
    static-locations: classpath:/templates/,classpath:/static/

mybatis:
  mapper-locations: classpath:/com/promethuesYuan/mapper/*.xml
  type-aliases-package: com.promethuesYuan.entity

```

这个地方主要的还是配置datasource和mybatis

### 初始化数据库

略～

---

😀至此，项目的框架已经搭建成功过了，剩下的就是根据需求开发了

之前学习看别人写项目为主，自己动手的比较少。通过上手实践一下，对流程什么的清楚了一下，但对原理还一知半解，接下来的项目实践中，既要积累经验，也要多思考这些原理的东西啊～
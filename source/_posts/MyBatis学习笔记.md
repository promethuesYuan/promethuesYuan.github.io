---
title: MyBatis学习笔记
date: 2020-04-24 22:36:19
tags: MyBatis
---

<center>
  记录学习MyBatis时的一些笔记
</center>

<!--more-->

# 1 简介

## 1.1 什么是MyBatis

- MyBatis是一款优秀的**持久层框架**

- 它支持定制化SQL、存储过程以及高级映射
- MyBatis避免了几乎所有的JDBC代码和手动设置参数以及获取届国际
- MyBatis可以使用简单的XML或注解来配置和映射原声类型、借口和Java的POJO为数据库中的记录
- MyBatis本是apache的一个开源项目iBatis,最后琴艺到了google code, 并改名为MyBatis



- maven仓库

  ```xml
  <!-- https://mvnrepository.com/artifact/org.mybatis/mybatis -->
  <dependency>
      <groupId>org.mybatis</groupId>
      <artifactId>mybatis</artifactId>
      <version>3.4.6</version>
  </dependency>
  ```



## 1.2 持久化

数据持久化

- 持久化就是将程序的数据在持久状态和瞬时状态转化的过程

- 内存：**断电即失**

- 数据库(jdbc)、io文件持久化

**为什么需要持久化？**

- 有一些对象，不能让其丢失
- 内存太贵



## 1.3 持久层

Dao层、Service层、Controller层……

- 完成持久化工作的代码块
- 层界限明显



## 1.4 为什么需要MyBatis?

- 简单易学
- 灵活
- sql和代码的分离，提高了可维护性
- 提供映射标签，支持对象与数据库的orm子段关系映射
- 提供对象关系映射标签，支持对象关系组建维护
- 提供xml标签，支持编写动态sql



# 2 第一个MyBatis程序

## 2.1 搭建环境

创建数据库

```sql
CREATE DATABASE `mybatis`;

USE `mybatis`;

CREATE TABLE `user`(
	`id` INT(20) NOT NULL PRIMARY KEY,
	`name` VARCHAR(30) DEFAULT NULL,
	`passwrod` VARCHAR(30) DEFAULT NULL
) ENGINE = INNODB DEFAULT CHARSET=utf8;

INSERT INTO `user`(`id`, `name`, `password`) VALUES
(1, "德玛西亚", "demacia"),
(2, "张三", "123"),
(3, "李四", "abcd")
```

新建项目：

1. 新建一个普通的maven项目

2. 倒入maven依赖

   

## 2.2 创建模块

- 编写mybatis核心配置







# 3 CRUD

## 3.1 namespace

namespace中的包名要和接口中的包名一致



## 3.2 select

- id: 就是对应的namespace中的方法名
- resultType: sql语句执行的返回值
- parameterType:参数类型



1. 编写借口

   ```java
   //get user by id
   User getUserById(int id);
   ```

2. 编写对应mapper中的sql语句

   ```xml
   <select id="getUserById" parameterType="int" resultType="com.promethuesYuan.pojo.User">
     select * from user where id = #{id}
   </select>
   ```

3. 测试

   ```java
   @Test
   public void getUserByIdTest(){
   
     try (SqlSession sqlSession = MyBatisUtils.getSqlSession()){
       UserMapper userMapper = sqlSession.getMapper(UserMapper.class);
       User userById = userMapper.getUserById(4);
   
       System.out.println(userById);
     }
   }
   ```

## 3.3 insert

```xml
<insert id="addUser" parameterType="com.promethuesYuan.pojo.User">
  insert into user (id, name, password) values (#{id}, #{name}, #{password})
</insert>
```

## 3.4 update

```xml
<insert id="updateUser" parameterType="com.promethuesYuan.pojo.User">
  update user set name=#{name}, password=#{password} where id=#{id}
</insert>
```

## 3.5 delete

```xml
<delete id="deleteUser" parameterType="com.promethuesYuan.pojo.User">
  delete from user where id=#{id}
</delete>
```



⚠️：增删改需要提交事物



## 3.6 万能的map

假设，我们的实体类或者数据库中的表，字段或者参数过多，我们应当考虑使用map！

```java
//insert one user vid map
int addUserByMap(Map<String, Object> map);

```

```xml	
<insert id="addUserByMap" parameterType="map">
  insert into user (id, name, password) values (#{mapid}, #{mapname}, #{mappassword})
</insert>
```

```java
public void addUserByMapTest(){

  try (SqlSession sqlSession = MyBatisUtils.getSqlSession()){
    UserMapper userMapper = sqlSession.getMapper(UserMapper.class);
    Map<String, Object> map = new HashMap<>();
    map.put("mapid", 5);
    map.put("mapname", "xiao 5");
    map.put("mappassword", "5555");

    userMapper.addUserByMap(map);
    sqlSession.commit();
  }
}
```

map传递参数，直接在sql中取出key即可

多个参数用map,或者注解



# 4 配置解析

## 4.1 核心配置文件

- Mybatis-config.xml

  ```
  properties（属性）
  settings（设置）
  typeAliases（类型别名）
  typeHandlers（类型处理器）
  objectFactory（对象工厂）
  plugins（插件）
  environments（环境配置）
  environment（环境变量）
  transactionManager（事务管理器）
  dataSource（数据源）
  databaseIdProvider（数据库厂商标识）
  mappers（映射器）
  ```

  

## 4.2 环境配置（environments）

MyBatis 可以配置成适应多种环境，。

**不过要记住：尽管可以配置多个环境，但每个 SqlSessionFactory 实例只能选择一种环境。**

MyBatis默认的事务管理器就是JDBC, 连接池：POOLED

## 4.3 属性（properties）

可以通过properties属性来实现引用配置文件

这些属性可以在外部进行配置，并可以进行动态替换。你既可以在典型的 Java 属性文件中配置这些属性，也可以在 properties 元素的子元素中设置。



编写一个配置文件

```properties
driver=com.mysql.jdbc.Driver
url=jdbc:mysql://localhost:3306/mybatis?useSSL=false&useUnicode=true&characterEncoding=UTF-8&serverTimezone=UTC
username=root
password=11235813
```

核心配置文件中引入

```xml
<properties resource="db.properties"></properties>

    <environments default="development">
        <environment id="development">
            <transactionManager type="JDBC"/>
            <dataSource type="POOLED">
                <property name="driver" value="${driver}"/>
                <property name="url" value="${url}"/>
                <property name="username" value="${username}"/>
                <property name="password" value="${password}"/>
            </dataSource>
        </environment>
    </environments>
```

- 可以直接引入外部文件
- 可以在其中增加一些属性
- 如果两个文件中有同名属性，优先使用外部配置文件的



## 4.4 类型别名（typeAliases）

类型别名可为 Java 类型设置一个缩写名字，意在降低冗余的全限定类名书写

```xml
<typeAliases>
  <typeAlias type="com.promethuesYuan.pojo.User" alias="User"/>
</typeAliases>
```

也可以指定一个包名，mybatis会在该包下搜索需要的java bean。扫描实体类的包，他的默认别名为该类类名首字母小写

```xml
<typeAliases>
  <package name="com.promethuesYuan.pojo"/>
</typeAliases>
```

如果实体类比较少，使用第一种。十分多时，建议使用第二种。如果需要改，可以在实体类上加注释

```java
@Alias("hello")
public class User {
```



## 4.5 设置（settings）

这是 MyBatis 中极为重要的调整设置，它们会改变 MyBatis 的运行时行为。



## 4.6 映射器（mappers）

注册绑定我们的mapper文件

```xml
<!-- 使用相对于类路径的资源引用 -->
<mappers>
  <mapper resource="org/mybatis/builder/AuthorMapper.xml"/>
  <mapper resource="org/mybatis/builder/BlogMapper.xml"/>
  <mapper resource="org/mybatis/builder/PostMapper.xml"/>
</mappers>
```

```xml
<!-- 使用映射器接口实现类的完全限定类名 -->
<mappers>
  <mapper class="org.mybatis.builder.AuthorMapper"/>
  <mapper class="org.mybatis.builder.BlogMapper"/>
  <mapper class="org.mybatis.builder.PostMapper"/>
</mappers>
```

```xml
<!-- 将包内的映射器接口实现全部注册为映射器 -->
<mappers>
  <package name="org.mybatis.builder"/>
</mappers>
```

后面两种方法的注意点：

- 接口和他的mapper文件必须同名

- 接口和他的mapper文件必须在同一个包下

## 4.7 作用域（Scope）和生命周期

> 作用域和生命周期类别是至关重要的，因为错误的使用会导致非常严重的并发问题。

![](https://1900-1300387133.cos.ap-chengdu.myqcloud.com/image/20200424180658.png)

**SqlSessionFactoryBuilder:**

- 一旦创建了SqlSessionFactory，就不再需要他了
- 局部变量

**SqlSessionFactory:**

- 说白了就是可以想象为：数据库连接池
- 一旦被创建就应该在应用的运行期间一直存在，**没有任何理由丢弃它或重新创建另一个实例**
- 因此SqlSessionFactory的最佳作用域是应用作用域
- 最简单的就是使用**单例模式**或者静态单例模式

**SqlSession：**

- 连接到数据库连接池的一个请求
- SqlSession 的实例不是线程安全的，因此是不能被共享的，所以它的最佳的作用域是请求或方法作用域。
- 用完之后需要赶紧关闭

每一个Mapper，就代表一个具体的业务



# 5 解决属性名和字段名不一致的问题


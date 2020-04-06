---
title: JDBC学习笔记
date: 2019-09-11 23:50:27
tags: Java
categories: 学习笔记
---

<center>记录JDBC使用方法</center>
<!--more-->

## 什么是JDBC

JDBC, Java Database Connecive, Java 数据库连接，是一组专门负责连接并操作数据库的标准，在整个JDBC 
中实际上大量的提供的是接口。针对于各个不同的数据库生产商 ，只要想使用JAVA 进行数据库的开发，则对这些标准有所支持。



## JDBC操作步骤

1. 加载数据库驱动程序
2. 连接数据库，通过Connection 接口和 DriverManager 类完成
3. 操作数据库，通过Statement、PreparedStatement、ResultSet 三个接口完成
4. 关闭数据库



## 加载数据库

我使用的是mysql连接，需要将mysql-connector-java-8.0.17.jar（我使用的是这个版本）这个包导入到项目之中。
IDEA导入方法是，File -> project structre -> 左边选择Modules -> 在这个包管理界面，点击右侧的➕ -> 通过你的包的路径，选择这个jar包即可导入。



## 连接数据库

``` java
public class Demo {
    public static void main(String[] args) {
        try {
            //加载驱动类
            Class.forName("com.mysql.cj.jdbc.Driver");
            //建立连接(连接对象内部其实包含了Socket对象，是一个远程连接。比较耗时！)
            //真正开发中，为了提高效率，都会使用连接池来管理连接对象。
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/test_db?serverTimezone=UTC",
                    "user","password");
            System.out.println(con);
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }
}
```

连接的时候遇到了几个问题。

1.报错：Loading class `com.mysql.jdbc.Driver`. This is deprecated. The new driver class is `com.mysql.cj.jdb`
这个问题是因为高版本的驱动，连接class有所修改，forname()里面需要写“com.mysql.cj.jdbc.Driver” 而不是"com.mysql.jdbc.Driver"

2.报错：SQLException: The server time zone value '�й���׼ʱ��' is unrecognized
在配置datasource.url时出现了时区不一致的问题，在后面加上“?serverTimezone=UTC”即可

3.这里有两个异常操作，Java基础不是很好，暂时无法理解为什么这么写，先记住就好。



## 操作数据库

### Statement接口

``` java
public class Demo1 {
    public static void main(String[] args) {
        try {
            //加载驱动类
            Class.forName("com.mysql.cj.jdbc.Driver");
            //建立连接
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/test_db?serverTimezone=UTC",
                    "user","password");

            Statement stmt = con.createStatement();
            String sql = " INSERT INTO tb_courses" +
                    " (course_id,course_name,course_grade,course_info)" +
                    " VALUES(2,'Network',3,'Computer Network');";
            stmt.execute(sql);
            //SQL注入
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }
}
```

建立连接和前面时一致的。主要是中间的执行有所区别。

Statement是通过一个String来存储所要进行的sql操作，然后通过execute()方法来实现要进行的操作。存储的sql操作支持字符串拼接，可以将values的值拼接成一句sql语句。

这种可拼接的方法就带来了一个问题，叫做**SQL注入**。什么是SQL注入，也就是说，你在拼接的过程中是没有进行字符串检查的，万一在某个where语句后面拼接时，出现了判断结果与你预期的不一致，最后导致数据库内容出错，甚至删库的情况出现。视频讲解并不推荐这种方法。



### PreparedStatement接口

```java
public class Demo2 {
    public static void main(String[] args) {
        try {
            //加载驱动类
            Class.forName("com.mysql.cj.jdbc.Driver");
            //建立连接(连接对象内部其实包含了Socket对象，是一个远程连接。比较耗时！)
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/test_db?serverTimezone=UTC",
                    "user","password");

            String sql = "INSERT into tb_courses (course_name, course_grade) values(?,?)";
            //?占位符
            PreparedStatement ps = con.prepareCall(sql);
            //传参方法1
//            ps.setString(1, "JDBClearning");
//            ps.setFloat(2, 6.0f);

            //传参方法2
            ps.setObject(1, "JDBC");
            ps.setObject(2, 12);

            System.out.println("插入正在学习JDBC");
            ps.execute();

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }
}
```

PreparedStatement作为Statement的子类，可以使用预编译，然后传参的方法，来实现sql语句。符号"?"作为占位符，为后面传参做准备。
传参一共有两种方法可以使用。

一种是明确传参类型。比如传参是String类型，就用setString()方法来传参。第一个参数是表示位置信息，第二个是你要插入的数据。插入int就用setInt()方法，其他的类似。
另一种是不明确传参类型。使用setObject()方法传所有参数。



![查询操作图](https://1900-1300387133.cos.ap-chengdu.myqcloud.com/image/20200401160738.png)
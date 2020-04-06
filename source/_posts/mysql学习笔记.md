---
title: MySQL学习笔记
date: 2019-09-07 11:39:40
tags: MySQL
categories: 学习笔记
---

<center>MySQL学习记录</center>
<!--more-->

## MySQL安装

这个部分在暑假实习时候已经安装成功，就没有多花时间在这个上面。
但为什么当时没有学习使用MySQL呢....当时用了navicat图形化管理，到后来不还是得学，哎....

## MySQL数据库相关操作

### 创建

在MySQL中，使用`create database`语句创建数据库，语法格式如下：

	CREATE DATABASE [IF NOT EXISTS] <数据库名>
	[[DEFAULT] CHARACTER SET <字符集名>] [[DEFAULT] COLLATE <校对规则名>];

语法说明：

-  IF NOT EXISTS：在创建数据库之前进行判断，只有该数据库目前尚不存在时才能执行操作。此选项可以用来避免数据库已经存在而重复创建的错误。
- [DEFAULT] CHARACTER SET：指定数据库的默认字符集。
-  [DEFAULT] COLLATE：指定字符集的默认校对规则。

**实例1**

输入`create database test_db`语句， 即可创建一个名为test_db的数据库

**实例2**

创建一个数据库，名为test_db_char，默认字符集为utf8，默认校对规则为utf8_general_ci

	mysql> CREATE DATABASE IF NOT EXISTS test_db_char
	-> DEFAULT CHARACTER SET utf8
	-> DEFAULT COLLATE utf8_chinese_ci;
	Query OK, 1 row affected (0.03 sec)
### 查看

`show databases`语句，可以查看所有用户范围内的数据库
该语句可以加上后缀like, 用于匹配数据库名称, 后面所借数据库名需用' '括起来。

**实例**

	show databases like  'test_db'	完全匹配查找名为test_db的数据库
	show databases like  '%test%'	查找数据库名称中含有test的所有数据库
	show databases like  'db%'	查找数据库名称中以db开头的所有数据库
	show databases like  '%db'	查找数据库名称中以db结尾的所有数据库

### 修改

修改数据库语法格式为：

	ALTER DATABASE [数据库名] { [ DEFAULT ] CHARACTER SET <字符集名> |
	[ DEFAULT ] COLLATE <校对规则名>}

查看数据库的定义声明：`show create database 数据库名`

**实例**

	mysql> CREATE DATABASE test_db
	    -> DEFAULT CHARACTER SET gb2312
	    -> DEFAULT COLLATE gb2312_chinese_ci;
	mysql> SHOW CREATE DATABASE test_db;


### 删除

语法格式：

	DROP DATABASE [ IF EXISTS ] <数据库名>

-  <数据库名>：指定要删除的数据库名。
-  IF EXISTS：用于防止当数据库不存在时发生错误。
-  DROP DATABASE：删除数据库中的所有表格并同时删除数据库。使用此语句时要非常小心，以免错误删除。如果要使用 DROP DATABASE，需要获得数据库 DROP 权限。

### 选择

语法格式:

	use <数据库名>

如何查看当前使用的是哪个数据库?有三条语句可以实现。

1. select database();
2. show table;
3. status;

### 引擎

设置默认引擎：

	SET default_storage_engine=< 存储引擎名 >

InnoDB 是系统的默认引擎，支持可靠的事务处理。通过上述语句修改后，默认引擎可以改变，但是MySQL重启后，默认引擎依然是InnoDB。

## MySQL常见数据类型

在MySQL中常见的数据类型如下所示:

**1) 整数类型**
 包括 TINYINT、SMALLINT、MEDIUMINT、INT、BIGINT，浮点数类型 FLOAT 和 DOUBLE，定点数类型 DECIMAL。 

**2) 日期/时间类型**
 包括 YEAR、TIME、DATE、DATETIME 和 TIMESTAMP。 

**3) 字符串类型**
 包括 CHAR、VARCHAR、BINARY、VARBINARY、BLOB、TEXT、ENUM 和 SET 等。 

**4) 二进制类型**
 包括 BIT、BINARY、VARBINARY、TINYBLOB、BLOB、MEDIUMBLOB 和 LONGBLOB。

具体数据类型的讲解可以看这儿[MySQL常见数据类型](http://c.biancheng.net/view/2421.html)

## MySQL表相关操作

### 创建

其语法格式为： 

	CREATE TABLE <表名> ([表定义选项])[表选项][分区选项];
其中，[表定义选项]的格式为：

	<列名1> <类型1> [,…] <列名n> <类型n>

**实例**

船舰一个员工表，结构如下。

| 字段名称 | 数据类型    | 备注         |
| -------- | ----------- | ------------ |
| id       | INT(ll)     | 员工编号     |
| name     | VARCHAR(25) | 员工名称     |
| deptld   | INT(ll)     | 所在部门编号 |
| salary   | FLOAT       | 工资         |

    mysql> USE test_db;
    Database changed
    mysql> CREATE TABLE tb_emp1
        -> (
        -> id INT(11),
        -> name VARCHAR(25),
        -> deptId INT(11),
        -> salary FLOAT
        -> );
    Query OK, 0 rows affected (0.37 sec)

使用`show tables`语句查看数据表是否创建成功

### 查看

DESCRIBE/DESC 语句可以查看表的字段信息，包括字段名、字段数据类型、是否为主键、是否有默认值等，语法规则如下：

	DESCRIBE <表名>;

 或简写成： 

	DESC <表名>;

SHOW CREATE TABLE语句可以用来显示创建表时的CREATE TABLE语句，语法格式如下： 

	SHOW CREATE TABLE <表名>\G；

### 修改

常用的语法格式如下： 

	ALTER TABLE <表名> [修改选项]

 修改选项的语法格式如下： 

    { ADD COLUMN <列名> <类型>
    | CHANGE COLUMN <旧列名> <新列名> <新列类型>
    | ALTER COLUMN <列名> { SET DEFAULT <默认值> | DROP DEFAULT }
    | MODIFY COLUMN <列名> <类型>
    | DROP COLUMN <列名>
    | RENAME TO <新表名> }
#### 添加字段

	ALTER TABLE <表名> ADD <新字段名> <数据类型> [约束条件] [FIRST|AFTER 已存在的字段名]；

**实例：**在第一列添加int类型字段col1


    mysql> ALTER TABLE tb_emp1
    -> ADD COLUMN col1 INT FIRST;
    Query OK, 0 rows affected (0.94 sec)
    Records: 0  Duplicates: 0  Warnings: 0


若无 first 或 after，则默认在最后一行添加新字段

#### 修改字段类型

	ALTER TABLE <表名> MODIFY <字段名> <数据类型>

#### 删除字段

	ALTER TABLE <表名> DROP <字段名>；

#### 修改字段名称

	ALTER TABLE <表名> CHANGE <旧字段名> <新字段名> <新数据类型>；

新数据类型指的是修改后的数据类型，如果不需要修改字段的数据类型，可以将新数据类型设置成与原来一样，但数据类型不能为空。

#### 修改表名

	ALTER TABLE <旧表名> RENAME [TO] <新表名>；

### 删除

语法格式如下：

	DROP TABLE [IF EXISTS] <表名> [ , <表名1> , <表名2>] …

语法说明如下：
1.<表名>：被删除的表名。DROP TABLE 语句可以同时删除多个表，用户必须拥有该命令的权限。
2.表被删除时，所有的表数据和表定义会被取消，所以使用本语句要小心。
3.表被删除时，用户在该表上的权限并不会自动被删除。
4.参数IF EXISTS用于在删除前判断删除的表是否存在，加上该参数后，在删除表的时候，如果表不存在，SQL 语句可以顺利执行，但会发出警告（warning）。

## MySQL键约束

键约束感觉就是给一些键增加特定的标识，作为这个表的某一种标识的体现。

键约束一共有主键、外键、唯一约束。

### 主键

**定义&作用：**“主键（PRIMARY KEY）”的完整称呼是“主键约束”。MySQL 主键约束是一个列或者列的组合，其值能唯一地标识表中的每一行。这样的一列或多列称为表的主键，通过它可以强制表的实体完整性。

**创建语法：**

	<字段名> <数据类型> PRIMARY KEY [默认值]

实例：`id int(11) primary key`，此时id即成为这个表的主键。

在定义完所有列之后，**指定主键的语法格式为：**

	[CONSTRAINT <约束名>] PRIMARY KEY [字段名]

实例：`primary key(id)`,此时id即成为这个表的主键。

**创建复合主键：**

	PRIMARY KEY [字段1，字段2，…,字段n]

实例：`primary key(id, deptId)`,此时id和deptId即成为这个表的复合主键。

**修改表时添加主键：**

	ALTER TABLE <数据表名> ADD PRIMARY KEY(<列名>);

实例：`ALTER TABLE tb_emp2  ADD PRIMARY KEY(id);`，此时添加id成为这个表的主键。



### 外键

**定义&作用：**
MySQL 外键约束（FOREIGN KEY）用来在两个表的数据之间建立链接，它可以是一列或者多列。一个表可以有一个或多个外键。
外键对应的是参照完整性，一个表的外键可以为空值，若不为空值，则每一个外键的值必须等于另一个表中主键的某个值。
外键是表的一个字段，不是本表的主键，但对应另一个表的主键。定义外键后，不允许删除另一个表中具有关联关系的行。

**创建语法：**

	[CONSTRAINT <外键名>] FOREIGN KEY 字段名 [，字段名2，…]
	REFERENCES <主表名> 主键列1 [，主键列2，…]

实例：`CONSTRAINT fk_emp_dept1 FOREIGN KEY(deptId) REFERENCES tb_dept1(id)`

**修改表时添加外键：**

	ALTER TABLE <数据表名> ADD CONSTRAINT <索引名>
	FOREIGN KEY(<列名>) REFERENCES <主表名> (<列名>);

实例：

	mysql> ALTER TABLE tb_emp2
	-> ADD CONSTRAINT fk_tb_dept1
	-> FOREIGN KEY(deptId)
	-> REFERENCES tb_dept1(id);
**删除外键：**

	ALTER TABLE <表名> DROP FOREIGN KEY <外键约束名>;

实例:

	mysql> ALTER TABLE tb_emp2
		-> DROP FOREIGN KEY fk_tb_dept1;



### 唯一约束

**定义&作用：**

MySQL唯一约束（Unique Key）要求该列唯一，允许为空，但只能出现一个空值。唯一约束可以确保一列或者几列不出现重复值。

**创建语法：**

	<字段名> <数据类型> UNIQUE

**添加唯一约束：**

	ALTER TABLE <数据表名> ADD CONSTRAINT <唯一约束名> UNIQUE(<列名>);

实例：
	mysql> ALTER TABLE tb_dept1
		-> ADD CONSTRAINT unique_name UNIQUE(name);

**删除唯一约束：**

	ALTER TABLE <表名> DROP INDEX <唯一约束名>;



### 检查约束

具体语法: `CHECK <表达式>`

修改表时添加约束： `ALTER TABLE tb_emp7 ADD CONSTRAINT <检查约束名> CHECK(<检查约束>)`

删除约束: `ALTER TABLE <数据表名> DROP CONSTRAINT <检查约束名>;`



### 默认值

设置：`<字段名> <数据类型> DEFAULT <默认值>;`



### 非空约束

设置: `<字段名> <数据类型> NOT NULL;`



## 选择数据

### select

select语句语法：

    SELECT
    {* | <字段列名>}
    [
    FROM <表 1>, <表 2>…
    [WHERE <表达式>
    [GROUP BY <group by definition>
    [HAVING <expression> [{<operator> <expression>}…]]
    [ORDER BY <order by definition>]
    [LIMIT[<offset>,] <row count>]
    ]

查询表中**全部内容**，具体格式：

	SELECT * FROM 表名;

**查询指定字段**，具体格式：

	SELECT < 列名 > FROM < 表名 >;

### 去重

消除重复的记录值，使用关键字distinct,具体语法:

	SELECT DISTINCT <字段名> FROM <表名>;

### 限制查询条数

当只需要查询某几行内容时，需要用到关键字llimit，具体格式:

	<LIMIT> [<位置偏移量>,] <行数>

实例1：

	SELECT * FROM tb_students_info LIMIT 4;
	查询的就是1~4行的内容

实例2：
	SELECT * FROM tb_students_info LIMIT 3,5;
	查询的就是偏移3行，即4~8行的内容

### 排序

具体格式：

	ORDER BY {<列名> | <表达式> | <位置>} [ASC|DESC]

**注:**
关键字 ASC 表示按升序分组，关键字 DESC 表示按降序分组，其中 ASC 为默认值。这两个关键字必须位于对应的列名、表达式、列的位置之后。

实例1：

	 SELECT * FROM tb_students_info ORDER BY height;

以height为升序排序

实例2：

	SELECT name,height FROM tb_student_info ORDER BY height DESC,name ASC;

先以height为降序排序，然后以name为升序排序

### 条件查询

筛选数据，具体格式：

	WHERE <查询条件> {<判定运算1>，<判定运算2>，…}

判断语法如下:
<表达式1>{=|<|<=|>|>=|<=>|<>|！=}<表达式2>
<表达式1>[NOT]LIKE<表达式2>
<表达式1>[NOT][REGEXP|RLIKE]<表达式2>
<表达式1>[NOT]BETWEEN<表达式2>AND<表达式3>
<表达式1>IS[NOT]NULL



## 插入数据


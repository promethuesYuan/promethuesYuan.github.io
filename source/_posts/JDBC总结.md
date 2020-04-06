---
title: JDBC总结
date: 2020-04-03 22:28:37
tags: JDBC

---

<center>
    JDBC学习总结
</center>



<!--more-->

## 考虑事务后的数据库操作

1. 获取数据库连接

   - DriverClass
   - url
   - username
   - password

   Connection conn = JDBCUtils.getConnection()

   - 方法1：手动连接
   - 方法2：数据连接池连接

   conn.setAutoCommit(false)  //体现事务

2. 如下的多个DML操作，作为一个事务出现

   操作1：需要使用通用的增删改查操作

   操作2：需要使用通用的增删改查操作

   操作3：需要使用通用的增删改查操作

   conn.commit()

   CRUD如何实现？

   - 方法1：手动使用PreparedStatement实现
   - 方法2：使用dbUtils.jar中QurryRunner类

3. 如果出现异常

   conn.rollback()

4. 关闭资源

   JDBCUtils.closeResource()

   - 方法1：手动关闭
   - 方法2：DbUtils类关闭

## 两种编程思想

面向接口编程的思想

ORM编程思想：（object relational mapping）
 * 一个数据表对应一个java类
 * 表中的一条记录对应java类的一个对象
 * 表中的一个字段对应java类的一个属性


## 数据库事务概念

1.事务：一组逻辑操作单元,使数据从一种状态变换到另一种状态。

一组逻辑操作单元：一个或多个DML操作。
2.事务处理的原则：
保证所事务都作为一个工作单元来执行，即使出现了故障，都不能改变这种执行方式。
当在一个事务中执行多个操作时，要么所有的事务都被提交(commit)，那么这些修改就永久地保存
下来；要么数据库管理系统将放弃所作的所有修改，整个事务回滚(rollback)到最初状态。

说明：
1.数据一旦提交，就不可回滚

2.哪些操作会导致数据的自动提交？

- DDL操作一旦执行，都会自动提交。

  set autocommit = false 对DDL操作失效

- DML默认情况下，一旦执行，就会自动提交。

  我们可以通过set autocommit = false的方式取消DML操作的自动提交。

- 默认在关闭连接时，会自动的提交数据



### 事务的ACID属性

1. 原子性（Atomicity） 原子性是指事务是一个不可分割的工作单位，事务中的操作要么都发生，要么都不发
生。
2. 一致性（Consistency） 事务必须使数据库从一个一致性状态变换到另外一个一致性状态。
3. 隔离性（Isolation） 事务的隔离性是指一个事务的执行不能被其他事务干扰，即一个事务内部的操作及使用的
数据对并发的其他事务是隔离的，并发执行的各个事务之间不能互相干扰。
4. 持久性（Durability） 持久性是指一个事务一旦被提交，它对数据库中数据的改变就是永久性的，接下来的其
他操作和数据库故障不应该对其有任何影响。

### 数据库的并发问题
对于同时运行的多个事务, 当这些事务访问数据库中相同的数据时, 如果没有采取必要的隔离机制, 就会导致各种
并发问题:

- **脏读**: 对于两个事务 T1, T2, T1 读取了已经被 T2 更新但还没有被提交的字段。之后, 若 T2 回滚, T1读取的
  内容就是<u>临时且无效</u>的。
- **不可重复读**: 对于两个事务T1, T2, T1 读取了一个字段, 然后 T2 更新了该字段。之后, T1再次读取同一个字
  段, 值就不同了。

- **幻读**: 对于两个事务T1, T2, T1 从一个表中读取了一个字段, 然后 T2 在该表中插入了一些新的行。之后, 如
  果 T1 再次读取同一个表, 就会多出几行。

数据库事务的隔离性: 数据库系统必须具有隔离并发运行各个事务的能力, 使它们不会相互影响, 避免各种并发问题。

一个事务与其他事务隔离的程度称为隔离级别。数据库规定了多种事务隔离级别, 不同隔离级别对应不同的干扰程度, **隔离级别越高, 数据一致性就越好, 但并发性越弱。**

### 四种隔离级别
数据库提供的4种事务隔离级别：![](https://1900-1300387133.cos.ap-chengdu.myqcloud.com/image/20200404170412.png)



## 手动实现方法

### 数据库连接与关闭

```java
/**
 * 获取数据库的连接
 * @return
 * @throws Exception
 */
@Test
public static Connection getConnection() throws Exception{
    // 1.读取配置信息
    InputStream inputStream = ClassLoader.getSystemClassLoader().getResourceAsStream("jdbc.properties");

    Properties properties = new Properties();
    properties.load(inputStream);

    String user = properties.getProperty("user");
    String password = properties.getProperty("password");
    String url = properties.getProperty("url");
    String driverClass = properties.getProperty("driverClass");

    // 2.加载驱动
    Class.forName(driverClass);

    // 3.获取连接
    Connection connection = DriverManager.getConnection(url, user, password);
    return connection;
}
```



```java
/**
 * @description 关闭数据库连接
 * @param connection
 * @param ps
 * @param rs
 */
//选择性关闭Connection, Statement, ResultSet
public static void closeResource(Connection connection, Statement ps, ResultSet rs){
    try {
        if(rs != null) rs.close();
    } catch (SQLException e){
        e.printStackTrace();
    }
    try {
        if(ps != null) ps.close();
    } catch (SQLException e){
        e.printStackTrace();
    }
    try {
        if(connection != null) connection.close();
    } catch (SQLException e){
        e.printStackTrace();
    }
}
```

### PreparedStatement实现增删改查

**获取当前泛型参数**

```java
private Class<T> clazz = null;

{
    //获取当前BaseDAO的子类继承的父类中的泛型
    Type genericSuperclass = this.getClass().getGenericSuperclass();
    ParameterizedType paramType = (ParameterizedType) genericSuperclass;

    Type[] typeArguments = paramType.getActualTypeArguments();//获取了父类的泛型参数
    clazz = (Class<T>) typeArguments[0];//泛型的第一个参数
}
```



**增删改操作**

```java
// 通用的增删改操作---version 2.0 （考虑上事务）
// 实现时记得考虑事物操作
public int update(Connection conn, String sql, Object... args) {// sql中占位符的个数与可变形参的长度相同！
    PreparedStatement ps = null;
    try {
        // 1.预编译sql语句，返回PreparedStatement的实例
        ps = conn.prepareStatement(sql);
        // 2.填充占位符
        for (int i = 0; i < args.length; i++) {
            ps.setObject(i + 1, args[i]);// 小心参数声明错误！！
        }
        // 3.执行
        int count = ps.executeUpdate();
        return count;
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        // 4.资源的关闭
        JDBCUtils.closeResource(null, ps);
    }
    return 0;
}
```



**查询操作**

```java
// 通用的查询操作，用于返回数据表中的一条记录（version 2.0：考虑上事务
public T getInstance(Connection conn, String sql, Object... args) {
    PreparedStatement ps = null;
    ResultSet rs = null;
    try {

        ps = conn.prepareStatement(sql);
        for (int i = 0; i < args.length; i++) {
            ps.setObject(i + 1, args[i]);
        }

        rs = ps.executeQuery();
        // 获取结果集的元数据 :ResultSetMetaData
        ResultSetMetaData rsmd = rs.getMetaData();
        // 通过ResultSetMetaData获取结果集中的列数
        int columnCount = rsmd.getColumnCount();

        if (rs.next()) {
            T t = clazz.newInstance();
            // 处理结果集一行数据中的每一个列
            for (int i = 0; i < columnCount; i++) {
                // 获取列值
                Object columValue = rs.getObject(i + 1);

                // 获取每个列的列名
                // String columnName = rsmd.getColumnName(i + 1);
                String columnLabel = rsmd.getColumnLabel(i + 1);

                // 给t对象指定的columnName属性，赋值为columValue：通过反射
                Field field = clazz.getDeclaredField(columnLabel);
                field.setAccessible(true);
                field.set(t, columValue);
            }
            return t;
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        JDBCUtils.closeResource(null, ps, rs);

    }

    return null;
}

// 通用的查询操作，用于返回数据表中的多条记录构成的集合（version 2.0：考虑上事务
public List<T> getForList(Connection conn, String sql, Object... args) {
    PreparedStatement ps = null;
    ResultSet rs = null;
    try {

        ps = conn.prepareStatement(sql);
        for (int i = 0; i < args.length; i++) {
            ps.setObject(i + 1, args[i]);
        }

        rs = ps.executeQuery();
        // 获取结果集的元数据 :ResultSetMetaData
        ResultSetMetaData rsmd = rs.getMetaData();
        // 通过ResultSetMetaData获取结果集中的列数
        int columnCount = rsmd.getColumnCount();
        // 创建集合对象
        ArrayList<T> list = new ArrayList<T>();
        while (rs.next()) {
            T t = clazz.newInstance();
            // 处理结果集一行数据中的每一个列:给t对象指定的属性赋值
            for (int i = 0; i < columnCount; i++) {
                // 获取列值
                Object columValue = rs.getObject(i + 1);

                // 获取每个列的列名
                // String columnName = rsmd.getColumnName(i + 1);
                String columnLabel = rsmd.getColumnLabel(i + 1);

                // 给t对象指定的columnName属性，赋值为columValue：通过反射
                Field field = clazz.getDeclaredField(columnLabel);
                field.setAccessible(true);
                field.set(t, columValue);
            }
            list.add(t);
        }

        return list;
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        JDBCUtils.closeResource(null, ps, rs);

    }

    return null;
}
```

### PreparedStatement实现批操作的范例

```java
/**
 * 批量插入方式4
 * 1.addBatch, executeBatch, clearBatch
 * 2.整个批处理作为一个事务提交
 */
@Test
public void testInsert4(){
    String sql = "insert into goods(name) values(?)";
    try (Connection conn = JDBCUtils.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)){
        //关闭自动提交
        conn.setAutoCommit(false);

        long start = System.currentTimeMillis();

        for(int i = 1; i<=1000000; i++){
            ps.setObject(1, "name_" + i);

            //1.攒sql
            ps.addBatch();
            if(i % 500 == 0) {
                ps.executeBatch();
                ps.clearBatch();
            }
        }
        //批处理结束后一起提交
        conn.commit();

        long end  = System.currentTimeMillis();
        System.out.println("总用时:" + (end - start));

    } catch (Exception e) {
        e.printStackTrace();
    }
}
```

### PreparedStatement操作Blob类型

```java
//向数据库中插入blob类型
@Test
public void testInsert(){
    String sql = "insert into customers(name, email, birth, photo) values(?,?,?,?)";
    try(Connection conn = JDBCUtils.getConnection();
        PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setObject(1, "大哥");
        ps.setObject(2, "big@qq.com");
        ps.setObject(3, "1999-03-02");
        //设置Blob输入流
        FileInputStream is = new FileInputStream(new File("src/volume2/jdbc/no3Blob/big.jpg"));
        ps.setBlob(4, is);

        ps.execute();

    } catch (Exception e) {
        e.printStackTrace();
    }
}

```

## 数据库连接池Druid & DbUtils实现

### Druid数据库连接池创建

```java
//连接属性设置
username = root
password=11235813
url=jdbc:mysql://localhost:3306/test?serverTimezone=UTC&rewriteBatchedStatements=true
driverClassName=com.mysql.cj.jdbc.Driver
```

```java
/**
 * @description Druid数据库连接池连接
 * @throws Exception
 */
private static DataSource source = null;
static {
    try {
        //设置连接属性
        Properties pros = new Properties();
        InputStream is = 		ClassLoader.getSystemClassLoader().getResourceAsStream("druid.properties");
        pros.load(is);
        source = DruidDataSourceFactory.createDataSource(pros);
    } catch (IOException e) {
        e.printStackTrace();
    } catch (Exception e) {
        e.printStackTrace();
    }
}
public static Connection druidGetConnection() throws Exception {
    Connection conn = source.getConnection();
    return conn;
}
```

### DbUtils实现增删改查

**增删改示例**

```java
@Test
//通过QueryRunner来实现
public void testInsert()   {
    try(Connection connection = JDBCUtils.druidGetConnection()){
        QueryRunner runner = new QueryRunner();
        String sql = "insert into customers(name, email, birth)values(?, ?, ?)";
        runner.update(connection, sql, "小火","huo@qq.com","1999-01-01");
    } catch (SQLException e) {
        e.printStackTrace();
    } catch (Exception e) {
        e.printStackTrace();
    }
}
```

**查询示例**

```java
//测试查询
/*
 * BeanHander:是ResultSetHandler接口的实现类，用于封装表中的一条记录。
 */
@Test
public void testQuery1(){
    Connection conn = null;
    try {
        QueryRunner runner = new QueryRunner();
        conn = JDBCUtils.getConnection3();
        String sql = "select id,name,email,birth from customers where id = ?";
        BeanHandler<Customer> handler = new BeanHandler<>(Customer.class);
        Customer customer = runner.query(conn, sql, handler, 23);
        System.out.println(customer);
    } catch (SQLException e) {
        // TODO Auto-generated catch block
        e.printStackTrace();
    }finally{
        JDBCUtils.closeResource(conn, null);

    }

}

/*
 * BeanListHandler:是ResultSetHandler接口的实现类，用于封装表中的多条记录构成的集合。
 */
@Test
public void testQuery2() {
    Connection conn = null;
    try {
        QueryRunner runner = new QueryRunner();
        conn = JDBCUtils.getConnection3();
        String sql = "select id,name,email,birth from customers where id < ?";

        BeanListHandler<Customer>  handler = new BeanListHandler<>(Customer.class);

        List<Customer> list = runner.query(conn, sql, handler, 23);
        list.forEach(System.out::println);
    } catch (SQLException e) {
        e.printStackTrace();
    }finally{

        JDBCUtils.closeResource(conn, null);
    }
}
```

**查询特殊值示例**

```java
/*
 * ScalarHandler:用于查询特殊值
 */
@Test
public void testQuery5(){
    Connection conn = null;
    try {
        QueryRunner runner = new QueryRunner();
        conn = JDBCUtils.getConnection3();

        String sql = "select count(*) from customers";

        ScalarHandler handler = new ScalarHandler();

        Long count = (Long) runner.query(conn, sql, handler);
        System.out.println(count);
    } catch (SQLException e) {
        e.printStackTrace();
    }finally{
        JDBCUtils.closeResource(conn, null);

    }

}
```


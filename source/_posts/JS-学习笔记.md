---
title: JS 学习笔记
date: 2020-04-11 22:48:12
tags: JavaScript
---

<center>
  记录学习JS时的一些知识点
</center>

<!--more-->

## 输出

JavaScript 能够以不同方式“显示”数据：

- 使用 window.alert() 写入警告框
- 使用 document.write() 写入 HTML 输出
- 使用 innerHTML 写入 HTML 元素
- 使用 console.log() 写入浏览器控制台



### 使用 innerHTML

如需访问 HTML 元素，JavaScript 可使用 document.getElementById(id) 方法。

id 属性定义 HTML 元素。innerHTML 属性定义 HTML 内容：`document.getElementById("demo").innerHTML = 5 + 6;`

### 使用 document.write()

出于测试目的，使用 document.write() 比较方便：`document.write(5 + 6);`

**注意：**在 HTML 文档完全加载后使用 **document.write()** 将*删除所有已有的 HTML*

### 使用 window.alert()

您能够使用警告框来显示数据：`window.alert(5 + 6);`

### 使用 console.log()

在浏览器中，您可使用 console.log() 方法来显示数据。

请通过 F12 来激活浏览器控制台，并在菜单中选择“控制台”。`console.log(5 + 6);`



## 语句

| 关键词        | 描述                                              |
| :------------ | :------------------------------------------------ |
| break         | 终止 switch 或循环。                              |
| continue      | 跳出循环并在顶端开始。                            |
| debugger      | 停止执行 JavaScript，并调用调试函数（如果可用）。 |
| do ... while  | 执行语句块，并在条件为真时重复代码块。            |
| for           | 标记需被执行的语句块，只要条件为真。              |
| function      | 声明函数。                                        |
| if ... else   | 标记需被执行的语句块，根据某个条件。              |
| return        | 退出函数。                                        |
| switch        | 标记需被执行的语句块，根据不同的情况。            |
| try ... catch | 对语句块实现错误处理。                            |
| var           | 声明变量。                                        |



## 语法

- 混合值（字面量）

  - 数值
  - 字符串（单双引号）

- 变量 val

  - 运算符
  - 表达式

- 注释

  同Java

特殊运算

```js
var x = "8" + 3 + 5; //结果为835
var y = 3 + 5 + "8"; //结果为88
```

运算符基本与Java相同，几个不同的列举一下

| 运算符     | 描述                                  |
| :--------- | :------------------------------------ |
| ==         | 等于                                  |
| ===        | 等值等型                              |
| !=         | 不相等                                |
| !==        | 不等值或不等型                        |
| typeof     | 返回变量的类型。                      |
| instanceof | 返回 true，如果对象是对象类型的实例。 |
| **         | 幂                                    |



## 数据类型

**字符串值，数值，布尔值，数组，对象。**

JavaScript 变量能够保存多种*数据类型*：数值、字符串值、数组、对象等等：

```js
var length = 7;                             // 数字
var lastName = "Gates";                      // 字符串
var cars = ["Porsche", "Volvo", "BMW"];         // 数组
var x = {firstName:"Bill", lastName:"Gates"};    // 对象 
```

JavaScript 从左向右计算表达式。不同的次序会产生不同的结果：这个之前有记哪个特例

### JavaScript 拥有动态类型

JavaScript 拥有动态类型。这意味着相同变量可用作不同类型：

### 实例

```
var x;               // 现在 x 是 undefined
var x = 7;           // 现在 x 是数值
var x = "Bill";      // 现在 x 是字符串值
```

### JavaScript 对象

JavaScript 对象用花括号来书写。

对象属性是 *name*:*value* 对，由逗号分隔。

### 实例

```
var person = {firstName:"Bill", lastName:"Gates", age:62, eyeColor:"blue"};
```

### Undefined 与 Null 的区别

Undefined 与 null 的值相等，但类型不相等：

```
typeof undefined              // undefined
typeof null                   // object
null === undefined            // false
null == undefined             // true
```

typeof 运算符可返回以下原始类型之一：

- string
- number
- boolean
- undefined

typeof 运算符可返回以下两种类型之一：

- function
- object

typeof 运算符把对象、数组或 null 返回 object。

typeof 运算符不会把函数返回 object。

typeof 运算符把数组返回为 "object"，因为在 JavaScript 中数组即对象。

##  事件

下面是一些常见的 HTML 事件：

| 事件        | 描述                         |
| :---------- | :--------------------------- |
| onchange    | HTML 元素已被改变            |
| onclick     | 用户点击了 HTML 元素         |
| onmouseover | 用户把鼠标移动到 HTML 元素上 |
| onmouseout  | 用户把鼠标移开 HTML 元素     |
| onkeydown   | 用户按下键盘按键             |
| onload      | 浏览器已经完成页面加载       |



## 字符串

.length 提取长度

查找：

- indexOf()

- lastIndexOf()
- search()

两种方法，indexOf() 与 search()，是*相等的*。

这两种方法是不相等的。区别在于：

- search() 方法无法设置第二个开始位置参数。
- indexOf() 方法无法设置更强大的搜索值（正则表达式）。

您将在[正则表达式](https://www.w3school.com.cn/js/js_regexp.asp)的章节学习到这些更强大的检索值。

有三种提取部分字符串的方法：

- slice(*start*, *end*):负数索引，从后往前
- substring(*start*, *end*)：类似⬆️，但不接受负数索引
- substr(*start*, *length*)：不同之处在于第二个参数规定被提取部分的*长度*



## 数字🔢

### JavaScript 数值始终是 64 位的浮点数

与许多其他编程语言不同，JavaScript 不会定义不同类型的数，比如整数、短的、长的、浮点的等等。

JavaScript 数值始终以双精度浮点数来存储，根据国际 IEEE 754 标准。

此格式用 64 位存储数值，其中 0 到 51 存储数字（片段），52 到 62 存储指数，63 位存储符号：

| 值(aka Fraction/Mantissa) | 指数              | 符号       |
| :------------------------ | :---------------- | :--------- |
| 52 bits(0 - 51)           | 11 bits (52 - 62) | 1 bit (63) |

在所有数字运算中，JavaScript 会尝试将字符串转换为数字：

该例如此运行：

```js
var x = "100";
var y = "10";
var z = x / y;       // z 将是 10
```

### NaN - 非数值

NaN 属于 JavaScript 保留词，指示某个数不是合法数。

尝试用一个非数字字符串进行除法会得到 NaN（Not a Number）：

### Infinity

Infinity （或 -Infinity）是 JavaScript 在计算数时超出最大可能数范围时返回的值。

**实例**

```js
var myNumber = 2;

while (myNumber != Infinity) {          // 执行直到 Infinity
    myNumber = myNumber * myNumber;
}
```

### 全局方法

JavaScript 全局方法可用于所有 JavaScript 数据类型。

这些是在处理数字时最相关的方法：

| 方法         | 描述                         |
| :----------- | :--------------------------- |
| Number()     | 返回数字，由其参数转换而来。 |
| parseFloat() | 解析其参数并返回浮点数。     |
| parseInt()   | 解析其参数并返回整数。       |

### 数值属性

| 属性              | 描述                             |
| :---------------- | :------------------------------- |
| MAX_VALUE         | 返回 JavaScript 中可能的最大数。 |
| MIN_VALUE         | 返回 JavaScript 中可能的最小数。 |
| NEGATIVE_INFINITY | 表示负的无穷大（溢出返回）。     |
| NaN               | 表示非数字值（"Not-a-Number"）。 |
| POSITIVE_INFINITY | 表示无穷大（溢出返回）。         |

**实例**

```
var x = Number.MAX_VALUE;
```

### 数组方法

- toString
- join
- pop
- push
- shift:方法会删除首个数组元素，并把所有其他元素“位移”到更低的索引。方法返回被“位移出”的字符串
- unshift:方法（在开头）向数组添加新元素，并“反向位移”旧元素,方法返回新数组的长度。
- length属性
- delete删除元素
- Splice 添加或删除元素元素

- Concat 合并数组
- slice切片 slice(1). slice(1,3)
- toString

**排序**

- sort

  默认地，sort() 函数按照*字符串*顺序对值进行排序。

  该函数很适合字符串（"Apple" 会排在 "Banana" 之前）。

  不过，如果数字按照字符串来排序，则 "25" 大于 "100"，因为 "2" 大于 "1"。

  正因如此，sort() 方法在对数值排序时会产生不正确的结果。

  我们通过一个*比值函数*来修正此问题：

  **实例**

  ```js
  var points = [40, 100, 1, 5, 25, 10];
  points.sort(function(a, b){return a - b}); //升序
  
  points.sort(function(a, b){return a - b}); //降序
  ```

- reverse

- Math.min/max.apply(null, arr)

**迭代**

- forEach
- map
- filter
- reduce
- reduceRight
- every检测所有数组值是否通过测试
- some检测部分数组值是否通过测试

- indexOf 方法在数组中搜索元素值并返回其位置。
- lastIndexOf 从数组结尾开始搜索。
- find() 方法返回通过测试函数的第一个数组元素的值。
- findIndex() 方法返回通过测试函数的第一个数组元素的索引。

## 日期📅

### 创建

Date 对象由新的 Date() 构造函数创建。

有 4 种方法创建新的日期对象：

- new Date()

- new Date(year, month, day, hours, minutes, seconds, milliseconds)

  7个数字分别指定年、月、日、小时、分钟、秒和毫秒（按此顺序）您不能省略月份。如果只提供一个参数，则将其视为毫秒。

  **注释**：JavaScript 从 0 到 11 计算月份。

  一月是 0。十二月是11。

- new Date(milliseconds)u

- new Date(date string)

### 格式


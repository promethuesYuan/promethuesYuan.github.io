---
title: Flink之window介绍及API
date: 2020-03-12 12:55:37
tags: Flink
categories: Flink
---

<center>
    介绍window这个概念以及相关的API函数
</center>

<!--more-->

## window概念

![](https://1900-1300387133.cos.ap-chengdu.myqcloud.com/image/20200312103457.png)

- 真实的流为无界的流,如何进行处理?
- 可以把无限的数据流进行划分,得到有限的数据集进行处理,也就是**有界流**
- 窗口,就是将无界流切割为有界流的一种方式,它会把流数据分发到有限大小的桶中进行分析

## window类型

- 时间窗口(Time Window)

  - 滚动时间窗口
  - 滑动时间窗口
  - 会话窗口

- 计数窗口(Count Window)

  - 滚动计数窗口
  - 滑动计数窗口

  

### 滚动窗口(Tumbling Window)

![](https://1900-1300387133.cos.ap-chengdu.myqcloud.com/image/20200312104013.png)

- 将数据依据固定的窗口长度对数据进行切分
- 时间对齐,窗口长度固定,无重叠部分
- 一个数据只能划分到一个确定的窗口

### 滑动窗口(Sliding Window)

![](https://1900-1300387133.cos.ap-chengdu.myqcloud.com/image/20200312104254.png)

- 滑动窗口是固定窗口的更广义的一种形式,由固定的窗口长度和滑动间隔组成
- 窗口长度固定,可以有重叠

### 会话窗口(Session Window)

![](https://1900-1300387133.cos.ap-chengdu.myqcloud.com/image/20200312104656.png)

- 由一系列事件组成一个指定时间长度的timeout间隙组成,也就是一段时间没有接收到新数据就会生成新的窗口
- 特点:时间无对齐

## window API

![](https://1900-1300387133.cos.ap-chengdu.myqcloud.com/image/20200312111610.png)

窗口分配器--window()方法.该方法必须在keyBy之后才能使用

更简单调用为.timeWindow和.countWindow方法,用于定义时间窗口和计数窗口

**window assigner**

window()方法接受的输入参数是一个window assigner.它负责将输入的数据分发到正确的window中

通用的window assigner:

- 滚动窗口(tumbling window)
- 滑动窗口(sliding window)
- 会话窗口(session window)
- 全局窗口(global window)

## 创建不同类型的窗口

- 滚动时间窗口

  `.timeWindow(Time.seconds(15))`

- 滑动时间窗口

  `.timeWindow(Time.seconds(15), Time.seconds(5))`

- 会话窗口

  `.window(EventTimeSessionWindows.withGap(Time.minutes(10)))`

- 滚动计数窗口

  `.countWindow(5)`

- 滑动计数窗口

  `.countWindow(10, 2)`

## 窗口函数(window function)

定义要对窗口中收集的数据做计算操作

- 增量聚合函数
  - 每条数据到来就进行计算,保持一个简单的状态
  - reduce aggregate
- 全窗口函数
  - 先把窗口所有数据收集起来,等到计算的时候会遍历所有数据
  - process

## 其他可选API

| API                   | 作用                                      |
| --------------------- | ----------------------------------------- |
| .triger()             | 定义window什么时候关闭,触发计算并输出结果 |
| .evitor()             | 定义移出某些数据的逻辑                    |
| .allowedLateness()    | 允许处理迟到的数据                        |
| .sideOutputLateData() | 将迟到的数据放入侧输出流中                |
| .getSideOutput()      | 获取侧输出流                              |


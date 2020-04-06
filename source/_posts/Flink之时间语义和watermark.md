---
title: Flink之时间语义和watermark
date: 2020-03-12 20:28:12
tags:
categories: Flink
---

<center>
    Flink中很重要的时间的概念以及一个跟时间有关的watermark
</center>

<!--more-->

## 时间语义

![](https://1900-1300387133.cos.ap-chengdu.myqcloud.com/image/20200312111923.png)

**事件时间和处理时间举例**

![](https://1900-1300387133.cos.ap-chengdu.myqcloud.com/image/20200312112507.png)

- 不同的时间语义有不同的应用场合
- 往往更关心事件时间

![](https://1900-1300387133.cos.ap-chengdu.myqcloud.com/image/20200312112818.png)

### 代码中设置Event Time

- 代码中,对执行环境调用setStreamTimeCharacteristic方法,设置流的时间特性
- 具体的时间,需要从数据中提取时间戳(timestamp)
- 默认时间为处理时间(processing time)

`env.setStreamTimeCharacteristic(TimeCharacteristic.EventTime)`

### 乱序数据的影响

![](https://1900-1300387133.cos.ap-chengdu.myqcloud.com/image/20200312113350.png)

- 以event time模式处理数据流时,会根据时间戳来处理基于时间的算子
- 由于网络,分布式等原因,会导致乱序数据的产生
- 乱序数据会让窗口计算不准确



## 水位线 Watermark

> 如何避免乱序数据带来计算不正确?
>
> 遇到一个时间戳达到窗口关闭时间,不应该立刻触发窗口计算,而是等待一段时间,等迟到的数据来了再关闭窗口

Watermark是一种衡量Event Time进展的机制,可以设定延迟触发

Watermark是用于处理乱序事件的,而正确的处理乱序事件,通常采用Watermark机制结合window实现

数据流中的Watermark用于表示timestamp小于Watermark的数据都已经到达,因此,window的执行也是由Watermark触发的

Watermark用来让程序自己平衡延迟和结果正确性



### Watermark特点

![](https://1900-1300387133.cos.ap-chengdu.myqcloud.com/image/20200312114502.png)

Watermark必须单调递增,以确保任务的事件时间时钟在向前推进,而不是后退

Watermark与数据的timestamp相关

### Watermark的传递

![](https://1900-1300387133.cos.ap-chengdu.myqcloud.com/image/20200312114708.png)

### Watermark的引入

Event Time的使用一定要指定数据源中的时间戳



### Watermark的设定

需要对处理的事件有一定了解

如果设置的延迟太久,收到结果的速度可能就会很慢,解决办法是在水位线到达之前输出一个近似结果

如果到达太早,则可能收到错误结果,不过Flink处理迟到数据的机制可以解决这个问题
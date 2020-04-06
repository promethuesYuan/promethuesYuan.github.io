---
title: Flink之transformation
date: 2020-03-12 20:27:26
tags:
categories: Flink
---

<center>
    Flink数据处理的重头,本文仅简单介绍
</center>

<!--more-->

## 基本算子

### map

对数据进行转换,一个数据转换成另一个数据

### flatmap

采用一个数据元并生成零个，一个或多个数据元

### filter

一组元素进来,按照某种规则,bool值为true,则被筛选出来

### keyBy

![](https://1900-1300387133.cos.ap-chengdu.myqcloud.com/image/20200312093404.png)

DataStream -> KeyedStream: 逻辑地将一个流拆分成不相交的分区,每个分区包含具有相同key的元素,内部以hash的形式实现

### Aggregation

针对KeyedStream的每一个支流做聚合

- sum
- min
- max
- minBy
- maxBy

### Reduce

被Keys化数据流上的“滚动”Reduce。将当前数据元与最后一个Reduce的值组合并发出新值。



## 多流算子

### Split

DataStream -> SplitStream:根据某些特征把一个DataStream拆分成两个或者多个DataStream

![](https://1900-1300387133.cos.ap-chengdu.myqcloud.com/image/20200312100154.png)

### Select

SplitStream -> DataStream :从一个SplitStream 中获取一个或者多个DataStream 

![](https://1900-1300387133.cos.ap-chengdu.myqcloud.com/image/20200312100400.png)

### Connect

![](https://1900-1300387133.cos.ap-chengdu.myqcloud.com/image/20200312101326.png)

DataStream, DataStream -> ConnectedStrems: 连接两个保持他们类型的数据流,两个数据流被Connect之后,只是被放在了一个同一个流中,内部依然保持各自的数据和形式不发生任何变化,两个流相互独立.

### CoMap, CoFlatMap

![](https://1900-1300387133.cos.ap-chengdu.myqcloud.com/image/20200312101606.png)

ConnectedStreams -> DataStream:作用于ConnectedStreams 上,功能与map和flatMap一样,对ConnectedStreams 中的每一个Stream分别进行map和flatMap处理

### Union

![](https://1900-1300387133.cos.ap-chengdu.myqcloud.com/image/20200312102345.png)

和Connect作用类似,但是Connect只能合并两个stream.Union可以对两个或者两个以上的DataStream进行操作,DataStream中的数据类型需要一致.

**Connect和Union的区别**

1. Union之前的两个流类型必须一样,Connect可以不一样,在之后的coMap中再去调整成为一样的
2. Connect只能操作两个流,Union可以操作多个




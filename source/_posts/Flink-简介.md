---
title: Flink 简介
date: 2020-03-14 21:04:14
tags:
categories: Flink

---

<center>
    Flink刚入门时候讲的背景知识
</center>

<!--more-->

主要内容

- Flink是什么
- 为什么要用Flink
- 流处理的发展和演变
- Flink的主要特点
- Flink vs Spark Streaming

---

## Flink是什么

Apache Flink是一个框架和**分布式**处理引擎，用于对**无界和有解数据**流进行**状态**运算



## 为什么选择Flink

- 流数据更真实地反映了我们的生活方式
- 传统的数据架构是基于有限数据集的
- 目标
  - 低延迟
  - 高吞吐
  - 结果的准确性和良好的容错性

**行业进行流处理举例**

- 电商和市场销售
  数据报表、广告投放、业务流程需要
- 物联网
  传感器实时数据采集和显示、实时报警、交通运输业
- 电信业
  基站流量调配
- 银行和金融业
  实时结算和通知推送、实时检测异常行为



## 流处理的发展和演变

第一代流处理：来一个处理一个

优点：低延迟

![](https://1900-1300387133.cos.ap-chengdu.myqcloud.com/image/20200314205057.png)

第二代流处理：lambda架构

通过结合批处理和流处理，来做到低延迟和准确性

缺点是架构复杂，同时维护两套系统运维成本高

![](https://1900-1300387133.cos.ap-chengdu.myqcloud.com/image/20200314205223.png)

第三代流处理：flink

相对于spark streaming通过micro-batch来实现流处理，flink为纯流处理

![](https://1900-1300387133.cos.ap-chengdu.myqcloud.com/image/20200314205300.png)



## Flink使用场景

### 事件驱动型应用

![](https://1900-1300387133.cos.ap-chengdu.myqcloud.com/image/pr3wlx98.bmp)



### 数据分析应用

![](https://1900-1300387133.cos.ap-chengdu.myqcloud.com/image/puo9kfzg.bmp)



### 数据管道应用

![](https://1900-1300387133.cos.ap-chengdu.myqcloud.com/image/bv3bypbt.bmp)



## Flink特点

- 纯流处理
- 分层API
- 支持事件时间和处理时间语义
- exactly-once的状态一致性保证
- 低延迟，每秒处理书包玩个事件，毫秒级延迟
- 与众多常用存储系统的连接
- 高可用，动态扩展



## Flink vs Spark Streaming

stream & micro-batch

取决于看问题的角度，微批小到一个事件时，就是流处理，反之流处理也能看成批处理

![](https://1900-1300387133.cos.ap-chengdu.myqcloud.com/image/20200314210031.png)



数据模型

- spark采用RDD模型，spark streaming的DStream实际上也就是一组组小批数据RDD的集合
- flink基本数据模型是数据流，以及事件序列

运行架构

- spark是批计算，将DAG划分为不同的stage，一个完成后才可以计算下一个
- flink是标准的流执行模式，一个事件字一个节点处理完后可以直接发往下一个节点进行处理
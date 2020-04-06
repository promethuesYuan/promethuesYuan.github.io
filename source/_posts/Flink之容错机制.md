---
title: Flink之容错机制
date: 2020-03-14 21:04:04
tags:
categories: Flink

---

<center>
    关于Flink的checkpoint机制
</center>

<!--more-->

**主要内容**

- 一致性检查点（checkpoint）
- 从检查点回复状态
- 检查点算法
- 保存点（save points）

## 一致性检查点 checkpoint

<img src="https://1900-1300387133.cos.ap-chengdu.myqcloud.com/image/20200314171740.png" style="zoom:80%;" />

故障恢复机制的**核心：**应有状态的一致性检查点

有状态流应用的一致检查点，其实就是所有任务的状态，在某个时间点的一份拷贝（快照）。在这个时间点，应该是所有任务都恰好处理完一个相同的输入数据的时候

## 从检查点恢复

<img src="https://1900-1300387133.cos.ap-chengdu.myqcloud.com/image/20200314173609.png" style="zoom:80%;" />

执行流应用程序期间，Flink会定期保存状态的一致检查点

如果发生故障，会使用最近的检查点来一致恢复应用程序的状态，并重新启动处理流程

<img src="https://1900-1300387133.cos.ap-chengdu.myqcloud.com/image/20200314173850.png" style="zoom:80%;" />

遇到故障，第一步：重启应用

<img src="https://1900-1300387133.cos.ap-chengdu.myqcloud.com/image/20200314174203.png" style="zoom:80%;" />

第二步：从checkpoint中读取状态，将状态重置

从检查点重新启动应用后，其内部状态与检查点完成时的状态完全相同

<img src="https://1900-1300387133.cos.ap-chengdu.myqcloud.com/image/20200314174316.png" style="zoom:80%;" />

第三步：开始消费并处理检查点到发生故障之间的所有数据

这种你差点的保存和恢复机制可以为应用程序状态提供exactly-once的一致性，因为所有算子都会保存检查点并恢复所有状态，这样一来，所有的输入流都会被充值到检查点完成时的位置

## 算法实现

简单实现：暂停应用，保存状态到检查点，再重新恢复应用

:arrow_down:

Flink的改进实现：

- 基于Chandy-Lamport算法的分布式快照
- 将检查点的保存和数据处理分开，不暂停整个应用

**检查点分界线（checkpoint barrier）**

- 检查点算法用到了一种叫做分界线的特殊数据形式，用来把一条流上数据按照不同的检查点分开
- 分界线之前到来的数据状态导致的状态更改，都会被包含在当前分界线所属的检查点中；而基于分界线之后的数据导致的所有更改，就会被包含在之后的检查点中

### 实例分析

<img src="https://1900-1300387133.cos.ap-chengdu.myqcloud.com/image/20200314180745.png" style="zoom:80%;" />

现在是一个有两个输入流的应用程序，并行两个Source任务来读取

<img src="https://1900-1300387133.cos.ap-chengdu.myqcloud.com/image/20200314180851.png" style="zoom:80%;" />

JobManager会向每个Source任务发送一条带有新检查点ID的消息，通过这种方式启动检查点

![](https://1900-1300387133.cos.ap-chengdu.myqcloud.com/image/20200314180956.png)

数据源将它们的状态写入检查点，并发出一个检查点barrier

状态后端在状态存入检查点之后，会返回通知给source任务，任务回向JobManager确认检查点完成

<img src="https://1900-1300387133.cos.ap-chengdu.myqcloud.com/image/20200314181127.png" style="zoom:80%;" />

分界线对齐：barrier向下游传递，sum任务会等待所有输入分区的barrier到达

- 对barrier已经到达的分区，继续到达的数据会被缓存
- 对barrier还未到达的分区，数据会被正常处理

![](https://1900-1300387133.cos.ap-chengdu.myqcloud.com/image/20200314193044.png)

当收到所有输入分区的barrier时，任务就将其状态保存到状态后端的检查点中，然后将barrier继续向下游转发

![](https://1900-1300387133.cos.ap-chengdu.myqcloud.com/image/20200314193144.png)

向下游转发检查点barrier后，任务继续正常的数据处理

<img src="https://1900-1300387133.cos.ap-chengdu.myqcloud.com/image/20200314193238.png" style="zoom:80%;" />

sink任务向JobManager确认状态保存到checkpoint完毕

当所有任务都确认已成功将状态保存到检查点时，检查点就真正完成了

## 保存点(Savepoint)

Flink提供了可以自定义的镜像保存功能，就是savepoint

原则上，创建保存点使用的算法与检查点完全相同，因此保存点可以认为就是具有一些额外元数据的检查点

Flink不会自动创建保存点，因此用户（或外部调度程序）必须明确地触发创建操作

保存点是一个强大的功能。除了故障恢复外，保存点可以用于：有计划地手动备份，更新应用程序，版本迁移，暂停和重启应用等


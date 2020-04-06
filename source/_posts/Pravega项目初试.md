---
title: Pravega项目初试
date: 2020-03-03 22:23:44
tags: Pravega
---

<center>
    一个简单的Pravega项目
</center>

<!--more-->

Pravega中的event读取行为分别由writer & reader端来实现，下面就从这两个方面来入手分析。

## 项目介绍

一个简单的读写程序，Writer端一直等待输入，每次获得字符串后写入event。当读到"EXIT"时，写入并退出。Reader端持续读取event,每读到一个event，就把它输出并且统计其大小写出现的次数。当收到"EXIT"时，程序退出。

## Writer

### 1.一些定义

```java
final String scope = "mytest";
final String streamName = "helloStream";
final String uriString = "tcp://127.0.0.1:9090";
final URI controllerURI = URI.create(uriString);
final String routingKey = "helloRoutingKey";
```

首先是一些string的设置，用于在后面定义scope和stream。

每一个事件都有一个**Routing Key**。Routing Key是开发者用于把相似的事件定位一个组的字符串。Routing Key通常由事件中产生，如“customer-id”,"machine-id" ,或者是开发者自己定义的一个字符串。Routing Key

### 2.创建Scope & Stream

```java
StreamManager streamManager = StreamManager.create(controllerURI);
boolean scopeIsNew = streamManager.createScope(scope);
StreamConfiguration streamConfig = StreamConfiguration.builder()
    										.scalingPolicy(ScalingPolicy.fixed(1))
    										.build();
boolean streamIsNew = streamManager.createStream(scope, streamName, streamConfig);
```

创建scope和stream都需要由StreamManager来创建。首先先通过controllerURI来创建streamManager。创建scope时，创建成功则返回true，否则返回false。StreamConfiguration是用来设定stream的相关属性的，`scalingPolicy(ScalingPolicy.fixed(1))`就是定义stream中segment数目固定为1.创建stream时，需要`scope, streamName, streamConfig`三个参数，创建成功则返回true，否则返回false。

### 3.Write event

```java
try (ClientFactory clientFactory = ClientFactory.withScope(scope, controllerURI);
EventStreamWriter<String> writer = clientFactory.createEventWriter(streamName,
                        new JavaSerializer<String>(), 		
						EventWriterConfig.builder().build())) 
{
    Scanner sc = new Scanner(System.in);
    System.out.printf("please input:");
    while (sc.hasNextLine()) {
        String s = sc.nextLine();
        if (s.equals("EXIT")) {
            writer.writeEvent(routingKey, s);
            System.out.println("**** Exitting..");
            System.exit(1);
        }
        System.out.println("*** " + s);
        writer.writeEvent(routingKey, s);
        System.out.printf("please input:");
    }
}
```

writer的创建需要通过ClientFactory来实现，ClientFactory其需要`scope, controllerURI`这两个属性。createEventWriter创建时需要定义：

- 往哪个stream里写
- 序列化的方式，前后一致
- 配置属性（此处为默认属性）

写事件时，使用`writer.writeEvent(routingKey, s)`将event写入stream中，注意要加上Routing Key.



## Reader

### 1.一些定义

```java
final String scope = "mytest";
final String streamName = "helloStream";
final String uriString = "tcp://127.0.0.1:9090";
final URI controllerURI = URI.create(uriString);
final String routingKey = "helloRoutingKey";
final int READER_TIMEOUT_MS = 1000;
```

和writer一致的定义不再赘述，这里多了一个`READER_TIMEOUT_MS`,在后面读事件时候解释。

### 2.创建ReaderGroup

```java
final String readerGroup = "helloReaderGroup";
final ReaderGroupConfig readerGroupConfig = ReaderGroupConfig.builder()
                                            .stream(Stream.of(scope, streamName))
                                            .build();
try(ReaderGroupManager readerGroupManager = ReaderGroupManager.withScope(scope, 																			controllerURI))
{
    readerGroupManager.createReaderGroup(readerGroup, readerGroupConfig);
}
```

reader group通过`ReaderGroupConfig, ReaderGroupManager`来创建。

### 3.Read event

```java
try(ClientFactory clientFactory = ClientFactory.withScope(scope, controllerURI);
    EventStreamReader<String> reader = clientFactory.createReader("myreader",readerGroup,
         new JavaSerializer<String>(),ReaderConfig.builder().build()))
{
    EventRead<String> event = null;
    System.out.println("Reader is ready.");
    while(true){
        try{
            event = reader.readNextEvent(READER_TIMEOUT_MS);
            if(event.getEvent() != null){
                String res = event.getEvent();
                if(res.equals("EXIT")) break;
                int[] upperCase = new int[26];
                int[] lowerCase = new int[26];
                for(int i=0; i<res.length(); i++){
                    char c = res.charAt(i);
                    if(c >= 'a' && c <= 'z') lowerCase[c-'a']++;
                    else if(c >= 'A' && c <= 'Z') upperCase[c-'A']++;
                }
                System.out.println("Read event: " + res);
                for(int i=0; i<26; i++) {
                    if(lowerCase[i] != 0){
                        System.out.printf("%c:%d ", 'a'+i, lowerCase[i]);
                        lowerCase[i] = 0;
                    }
                }
                for(int i=0; i<26; i++) {
                    if(upperCase[i] != 0){
                        System.out.printf("%c:%d ", 'A'+i, upperCase[i]);
                        upperCase[i] = 0;
                    }
                }
                System.out.println();
            } 
        } catch(ReinitializationRequiredException e){
            e.printStackTrace();
        }
    }
}
```

reader的创建，需要通过ClientFactory，创建时候需要定义：

- reader的名字
- reader所属的reader group
- 反序列化的方式
- 配置属性（此处为默认属性）

读事件的时候，由`reader.readNextEvent(READER_TIMEOUT_MS)`来读取事件，此处的`READER_TIMEOUT_MS`就是我们在1中所定义的。如果当前没有event了，将会阻止等待事件的继续到来，`READER_TIMEOUT_MS`就是等待事件的上限。

当没有事件到来，`event.getEvent()`的值就是null，否则就是指向通过反序列化得到的实例。
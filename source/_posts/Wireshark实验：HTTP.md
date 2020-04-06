---
title: Wireshark实验：HTTP
date: 2019-07-21 16:57:40
tags: [Wireshark, 计算机网络]
categories: 实操纪录
---
<center>掌握HTTP相关，实验内容比较简单，尝试学习中成长。</center>
<!--more-->  

# 1.基本HTTP GET/response交互 #
这个实验的本身很简单，就是让你访问一个仅含有一段简单的html代码的网站，然后根据http协议的请求头所包含的信息，来回答问题即可。但是在这个过程中我还遇到了挺多奇奇怪怪的问题。  
最开始操作不熟练，每次筛选后的到的纪录依然很多，多次尝试后，终于得到了和任务书介绍的类似界面。  
![实验一](http://puui5s2bo.bkt.clouddn.com/blog/19_7_219V4A_X%60X%60S~%2869EMMLJCBDQ.png "实验一结果")
但是我发现自己的HTTP状态响应为304 Not Modified, 和任务书中的200 OK不同，就很奇怪为什么。当时在下面详情里面看到了If Modified Since, 以及Accept Language。因为不是很明白为什么会出现这种情况，于是就先跳过实验一，看实验二去了。看了实验二才知道，304响应是因为我之前就访问过这个界面，然后浏览器产生了这个网页的缓存，304是说这个界面没有改变的意思。

# 2.HTTP条件Get/response交互
实验二中熟悉操作之后就得到了对应的结果。  
![实验二结果](http://puui5s2bo.bkt.clouddn.com/$_%7BXFA4$N6%60GQ@NY132%5D$%28I.png "实验二结果")  
在检查If-Modified-Since时，发现状态304中出现了这个标识，而且在状态200中，对应的是Last Modified,而且二者时间是一致的。  
探究If-Modified-Since是何物，网上给到的结果是  
>意思是我们在请求时会发送给服务器上次它修改这个文件最后一次时间，如果服务器发现仍然没有修改这个文件，就会返回304文件为改变的信息，调用本地caceh缓存，如果改变就会重新得到。

# 3.检索长文件
实验三顺利执行，结果如下图  
![实验三](http://puui5s2bo.bkt.clouddn.com/HWI6%29%25CL~KO%299F%29U$EN8%2551.png "实验三结果")  
数据信息包含在HTTP响应体里面。由于html文本过长，所以TCP共分了4个帧来存放这些信息，分组情况如下图 
![TCP分组](http://puui5s2bo.bkt.clouddn.com/R%25BR%60@%7B2VD$LGKHAPZ%5D%5DLA0.png "TCP分组")  

# 4.具有嵌入对象的HTML文档
实验四捕获结果如下  
![实验四结果](http://puui5s2bo.bkt.clouddn.com/@%7DQ%258JZX%28HYLWYR%7DETBRWXB.png "实验四结果")   
一共有三个HTTP GET请求，访问的IP地址都是128.119.245.12，按顺序得到了三个内容，分别是：html文件、pearson的图片、以及教材第五版的封面图，由于请求的时间不同，所以判断应该不是并行获得，而是按顺序请求获得。  

# 5.HTTP认证
实验五结果如下图  
![实验5](http://puui5s2bo.bkt.clouddn.com/%28LO@E%5DQY%28LIWQ%28BMC7T_4LK.png "实验五结果")  
最开始登录之后得到的界面是404 Not Found，感觉很奇怪啊，这不应该啊。后来检查了一下仓库中的URL，发现是给的URL打漏了一个"-"，打开正确的URL即可得到正确的结果界面。然后就在issue里面提交了这个问题，觉得Github还是很有意思啊。任务中让我们尝试base64加密方式，在wireshark中会自动解码出来，具体结果如下所示  

	Authorization: Basic d2lyZXNoYXJrLXN0dWRlbnRzOm5ldHdvcms=\r\n  
	  Credentials: wireshark-students:network

上面是加密前，下面是解密后的结果。可见我们的密码并不是很安全，需要别的措施来防止别人窃取。

# 6.实验收获
这个实验还是蛮简单的，具体步骤不知道怎么做或者是不知道要得到什么结果，参照一下Github上的pdf也就很容易解决。相比较第一个Wireshark，这个更加有实际操作的感觉，也锻炼了使用这个工具，继续努力~

---
title: Linux下C程序获得shell脚本输出
date: 2020-02-17 23:39:23
tags: Linux
---

<center>
    shell脚本输出结果重定向
</center>

<!--more-->

课设里面，需要查看系统的相关信息。指导书上直接打开文件来获得，但我发现通过terminal中的一些命令更容易获得自己想要的信息，于是就研究如何把终端中输出的结果重定向过来。

**使用popen**

```c
FILE *popen(const char *command, const char *type);
```

该函数的作用是创建一个管道，fork一个进程，然后执行shell，而shell的**输出**可以采用读取文件的方式获得。采用这种方法，既避免了创建临时文件，又不受**输出**字符数的限制。

```c
#include <stdio.h>  //头文件
FILE *popen(const char *command, const char *type);
int pclose(FILE *stream);
```

popen 通过type是r还是w确定command的输入/**输出**方向，r和w是相对command的管道而言的。
r表示command从管道中读入，w表示 command通过管道**输出**到它的stdout，popen返回FIFO管道的文件流指针。pclose则用于使用结束后关闭这个指针。

---

下面看一个示例，将`free -m`命令输出情况重定向输出到buf中，方便处理。

```c
#include <sys/types.h> 
#include <unistd.h> 
#include <stdlib.h> 
#include <stdio.h> 
#include <string.h>

int main( void ) 
{ 
   FILE   *stream; 
   char   buf[1024]; 
     
   memset( buf, '\0', sizeof(buf) );
   stream = popen( "free -m", "r" ); 

   fread( buf, sizeof(char), sizeof(buf), stream); 
   printf("%s\n", buf);
   pclose( stream );  
    
   return 0;
}   
```


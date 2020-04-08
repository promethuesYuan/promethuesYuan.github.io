---
title: 解决hexo对emoji的支持问题
date: 2020-04-08 19:45:24
tags: hexo
Categoties: 个人博客
---

<center>
  原生hexo对emoji的支持不是很好，很多表情都没有办法显示，本文记录如何解决这种问题。
</center>

<!-- more -->

<br/>

hexo默认的markdown渲染引擎hexo-renderer-marked不支持对emoji的渲染，解决方法就是换一个引擎，以及增加一个emoji插件。

**安装**

命令行如下：

```
npm un hexo-renderer-marked --save
npm i hexo-renderer-markdown-it --save
npm install markdown-it-emoji --save
```

第一行是移除hexo默认的引擎，第二行是新安装的引擎，第三行是安装emoji插件。

:warning:PS:执行命令行时，在hexo博客所在的命令行进行，才会产生效果。



**配置**

在hexo博客所在目录下，配置站点信息_config.yml文件，配置情况如下。

```
## markdown 渲染引擎配置，默认是hexo-renderer-marked，这个插件渲染速度更快，且有新特性
markdown:
  render:
    html: true
    xhtmlOut: false
    breaks: true
    linkify: true
    typographer: true
    quotes: '“”‘’'
  plugins:
    - markdown-it-footnote
    - markdown-it-sup
    - markdown-it-sub
    - markdown-it-abbr
    - markdown-it-emoji
```



**使用**

1. 复制你想要的emoji表情，粘贴到博文中
2. 输入emoji表情编码，比如`:smile:`就是:smile:的编码～
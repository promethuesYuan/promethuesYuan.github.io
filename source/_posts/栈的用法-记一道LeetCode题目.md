---
title: '栈的用法:记一道LeetCode题目'
date: 2019-09-29 19:06:49
tags: 栈, Leetcode
categories: 学习笔记
---

<center>
周赛中遇到的一道活用栈的题目，比较有启发意义。
</center>

<!--more-->

| 题目     | 5206. 删除字符串中的所有相邻重复项                           |
| -------- | :----------------------------------------------------------- |
| 题目描述 | 给你一个字符串 s，「k 倍重复项删除操作」将会从 s 中选择 k 个相邻且相等的字母，并删除它们，使被删去的字符串的左侧和右侧连在一起。<br/><br/>你需要对 s 重复进行无限次这样的删除操作，直到无法继续为止。<br/><br/>在执行完所有删除操作后，返回最终得到的字符串。<br/><br/>本题答案保证唯一。<br/> |
| 示例     | 输入：s = "deeedbbcccbdaa", k = 3<br/>输出："aa"<br/>解释： <br/>先删除 "eee" 和 "ccc"，得到 "ddbbbdaa"<br/>再删除 "bbb"，得到 "dddaa"<br/>最后删除 "ddd"，得到 "aa"<br/> |

**数据结构：**栈

**解法：**将字符串的每个字符按照顺序依次进站，如果栈中已经有k个相同的字符，就将他们依次弹出。最后将栈中剩余的字符串按照反序连接起来输出即得到正确答案。

**启发：**之前学了数据结构，但是感觉自己并没有用到解题中，没有这种思考的意识。本来自己在想怎么解的时候，一直在思考如何对字符串进行操作，听到别人解析用栈来实现的时候，觉得恍然大悟。所以还是数据结构基础要打好，然后就是如何灵活应用这些数据结构来解决问题。

**代码**

```java
import javafx.util.Pair;
import java.util.Stack;

class Solution {
    public String removeDuplicates(String s, int k) {
        /**
        *Pair用来记录当前字符以及这个字符是第几个了
        */
   		Stack<Pair<Character, Integer>> stack = new Stack<>();
        Pair<Character, Integer> pair = new Pair<Character, Integer>(s.charAt(0), 1);
        stack.push(pair);
        int len = s.length();
        for(int i=1; i<len; i++){
            if(!stack.isEmpty()){
                char temp = stack.peek().getKey();
                int num = stack.peek().getValue();
                if(temp  == s.charAt(i)){
                    stack.push(new Pair<>(temp, num+1));
                    if(num+1 == k){
                        for(int a = 0; a<k; a++) {
                            stack.pop();
                        }
                    }
                }
                else{
                    stack.push(new Pair<>(s.charAt(i), 1));
                }
            }
            else {
                stack.push(new Pair<>(s.charAt(i), 1));
            }
        }
        String ans = "";
        while (!stack.isEmpty()){
            char a = stack.peek().getKey();
            ans = a + ans;
            stack.pop();
        }
        return ans;
    }
}
```


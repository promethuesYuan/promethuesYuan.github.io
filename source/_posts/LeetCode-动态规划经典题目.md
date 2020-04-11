---
title: LeetCode 动态规划经典题目
date: 2020-04-09 23:30:03
tags: 动态规划
categories: LeetCode
---

<center>
  动态规划几道经典题目
</center>

<!--more-->

## 62

```java
class Solution {

    //尝试用递归的思路进行求解
    public int uniquePaths(int m, int n) {
        int ans = step(1, 1, m, n);
        return ans;
    }

    //递归函数
    public int step(int i, int j, int m, int n){
        if(i > m || j > n) return 0;
        if(i == m && j == n) return 1;
        
        return step(i+1, j, m, n) + step(i, j+1, m , n);
    }
    //递归超时啦sad
}
```



## 198 打家劫舍

```java
//我的写法，自己思考出来的，但是写的不是很精炼
class Solution {
    public int rob(int[] nums) {
        int len = nums.length;
        if(len == 0) return 0;
        if(len == 1) return nums[0];
      
        int[] dp = new int[len];
        dp[0] = nums[0];
        dp[1] = Math.max(nums[0], nums[1]);
        //dp[i] = max(dp[i-1], dp[i-2]+nums[i])
        for(int i = 2; i<len; i++){
            dp[i] = Math.max(dp[i-1], dp[i-2]+nums[i]);
        }
        return dp[len-1];
    }
}
```

```java
public int rob(int[] num) {
    int prevMax = 0;
    int currMax = 0;
    for (int x : num) {
        int temp = currMax;
        currMax = Math.max(prevMax + x, currMax);
        prevMax = temp;
    }
    return currMax;
}

作者：LeetCode
链接：https://leetcode-cn.com/problems/house-robber/solution/da-jia-jie-she-by-leetcode/
来源：力扣（LeetCode）
著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。
```



## 213 打家劫舍2

```java
class Solution {
    public int rob(int[] nums) {
        int len = nums.length;
        if(len == 0) return 0;
        if(len == 1) return nums[0];

        //第一种情况，第一家一定打劫，最后一家一定不打劫
        int[] dp1 = new int[len];
        dp1[0] = dp1[1] = nums[0];
        for(int i = 2; i < len-1; i++){
            dp1[i] = Math.max(dp1[i-1], dp1[i-2] + nums[i]);
        }

        //第二种情况，第一家一定不打劫，最后一家一定打劫
        int[] dp2 = new int[len];
        dp2[0] = 0;
        dp2[1] = nums[1];
        for(int i = 2;  i <len; i++){
            dp2[i] = Math.max(dp2[i-1], dp2[i-2] + nums[i]);
        }

        return Math.max(dp1[len-2], dp2[len-1]);
    }
}
```


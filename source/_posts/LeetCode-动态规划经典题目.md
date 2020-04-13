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



## 120

```java
//自顶向下，有O(n)的空间开销
class Solution {
    public int minimumTotal(List<List<Integer>> triangle) {
        int n = triangle.size();
        if(n == 0) return 0;

        int[] dp = new int[n];
        dp[0] = triangle.get(0).get(0);
        int min = dp[0];
        for(int i = 2; i <= n; i++){
            List<Integer> line = triangle.get(i-1);
            for(int j = i-1; j >= 0; j--){
                if(j == i-1){
                    dp[j] = dp[j-1] + line.get(j);
                    min = dp[j];
                } else if(j == 0){
                    dp[j] = dp[j] + line.get(j);
                } else{
                    dp[j] = Math.min(dp[j], dp[j-1]) + line.get(j);
                }
                if(i == n) min = min < dp[j] ? min : dp[j];
            }
        }

        // int min = dp[0];
        // for(int i = 1; i<n; i++) min = min < dp[i] ? min : dp[i];
        return min;
    }
}
```

```java
//自底向上求解
class Solution {
    public int minimumTotal(List<List<Integer>> triangle) {
        int n = triangle.size();
        if(n == 0 || triangle == null) return 0;

        int[] dp = new int[n+1];
        for(int i = n-1; i >= 0; i--){
            List<Integer> down = triangle.get(i);
            for(int j = 0; j <= i; j++){
                dp[j] = down.get(j) + Math.min(dp[j], dp[j+1]);
            }
        }
        return dp[0];
    }
}
```



## 221.最大正方形

1. 我们用 0 初始化另一个矩阵 dp，维数和原始矩阵维数相同；
2. **dp(i,j) 表示的是由 1 组成的最大正方形的边长；**
3. 从 (0,0)(0,0) 开始，对原始矩阵中的每一个 1，我们将当前元素的值更新为

$$
\text{dp}(i,\ j) = \min \big( \text{dp}(i-1,\ j),\ \text{dp}(i-1,\ j-1),\ \text{dp}(i,\ j-1) \big) + 1
dp(i, j)=min(dp(i−1, j), dp(i−1, j−1), dp(i, j−1))+1
$$

4. 我们还用一个变量记录当前出现的最大边长，这样遍历一次，找到最大的正方形边长 maxsqlenmaxsqlen，那么结果就是 maxsqlen^2maxsqlen 

作者：LeetCode
链接：https://leetcode-cn.com/problems/maximal-square/solution/zui-da-zheng-fang-xing-by-leetcode/

```java
class Solution {
    public int maximalSquare(char[][] matrix) {
        int row = matrix.length;
        if(row == 0 || matrix == null) return 0;
        int col = matrix[0].length;
        int[] dp = new int[col+1];
        int max = 0, prev = 0;
        for(int i = 1; i<= row; i++){
            for(int j = 1; j <= col; j++){
                int tmp = dp[j];
                if(matrix[i-1][j-1] == '1'){
                    dp[j] = Math.min(Math.min(dp[j-1], dp[j]), prev) + 1;
                    max = Math.max(max, dp[j]);
                } else {
                    dp[j] = 0;
                }
                prev = tmp;
            }
        }    
        return max * max;
    }
}
```

```java
public class Solution {

    public String longestPalindrome(String s) {
        int len = s.length();
        if (len < 2) {
            return s;
        }

        boolean[][] dp = new boolean[len][len];

        // 初始化
        for (int i = 0; i < len; i++) {
            dp[i][i] = true;
        }

        int maxLen = 1;
        int start = 0;

        for (int j = 1; j < len; j++) {
            for (int i = 0; i < j; i++) {

                if (s.charAt(i) == s.charAt(j)) {
                    if (j - i < 3) {
                        dp[i][j] = true;
                    } else {
                        dp[i][j] = dp[i + 1][j - 1];
                    }
                } else {
                    dp[i][j] = false;
                }

                // 只要 dp[i][j] == true 成立，就表示子串 s[i, j] 是回文，此时记录回文长度和起始位置
                if (dp[i][j]) {
                    int curLen = j - i + 1;
                    if (curLen > maxLen) {
                        maxLen = curLen;
                        start = i;
                    }
                }
            }
        }
        return s.substring(start, start + maxLen);
    }
}

作者：liweiwei1419
链接：https://leetcode-cn.com/problems/longest-palindromic-substring/solution/zhong-xin-kuo-san-dong-tai-gui-hua-by-liweiwei1419/
来源：力扣（LeetCode）
著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。
```


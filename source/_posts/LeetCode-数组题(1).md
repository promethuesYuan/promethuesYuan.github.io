---
title: 'LeetCode:数组题(1)'
date: 2019-08-01 21:12:56
tags: [LeetCode]
categories: 算法
---

<center>LeetCode刷题记录</center>
<!--more-->

# 26. 删除排序数组中的重复项

## 题目描述(简单)

给定一个排序数组，你需要在原地删除重复出现的元素，使得每个元素只出现一次，返回移除后数组的新长度。

不要使用额外的数组空间，你必须在原地修改输入数组并在使用 O(1) 额外空间的条件下完成。

示例 1:

```
给定数组 nums = [1,1,2], 

函数应该返回新的长度 2, 并且原数组 nums 的前两个元素被修改为 1, 2。 

你不需要考虑数组中超出新长度后面的元素。
```

示例 2:

```
给定 nums = [0,0,1,1,1,2,2,3,3,4],

函数应该返回新的长度 5, 并且原数组 nums 的前五个元素被修改为 0, 1, 2, 3, 4。

你不需要考虑数组中超出新长度后面的元素。
```

来源：力扣（LeetCode）
链接：https://leetcode-cn.com/problems/remove-duplicates-from-sorted-array

## 解题思路

开始对原地修改有一些疑问, 后来发现直接进行覆盖即可, 就没什么难度了.

注意数组长度为0这种情况.



## 解题代码

```java
class Solution {
    public int removeDuplicates(int[] nums) {
    if(nums.length == 0) return 0;
    int i = 0;
        for(int j=1; j<nums.length; j++){
            if(nums[j]!= nums[i]){
                i ++;
                nums[i] = nums[j];
            }
        }
    return (i+1);
    }
}
```



# 27. 移除元素

## 题目描述(简单)

给定一个数组 nums 和一个值 val，你需要原地移除所有数值等于 val 的元素，返回移除后数组的新长度。

不要使用额外的数组空间，你必须在原地修改输入数组并在使用 O(1) 额外空间的条件下完成。

元素的顺序可以改变。你不需要考虑数组中超出新长度后面的元素。

示例 1:
```
给定 nums = [3,2,2,3], val = 3,

函数应该返回新的长度 2, 并且 nums 中的前两个元素均为 2。

你不需要考虑数组中超出新长度后面的元素。
```
示例 2:
```
给定 nums = [0,1,2,2,3,0,4,2], val = 2,

函数应该返回新的长度 5, 并且 nums 中的前五个元素为 0, 1, 3, 0, 4。

注意这五个元素可为任意顺序。

你不需要考虑数组中超出新长度后面的元素。
```
来源：力扣（LeetCode）
链接：https://leetcode-cn.com/problems/remove-element

## 解题思路

- 排序
- 双指针

先对数组进行排序, 然后通过双指针找到等于val的第一个数, 和不等于val的第一个数, 然后进行覆盖

## 解题代码

```java
class Solution {
    public int removeElement(int[] nums, int val) {
	if(nums.length == 0) return 0;
	Arrays.sort(nums);
	int front,tail;
	for(front=0; front<nums.length; front++) {
		if(nums[front] == val) break;
	}
	for(tail = front; tail<nums.length; tail++) {
		if(nums[tail] != val) break;
	}
	if(tail == nums.length)	return front;
	else {
		for(; tail<nums.length; tail++) {
			nums[front] = nums[tail];
			front++;
		}
	}
	return front;
    }
}
```



# 283. 移动零

## 题目描述(简单)

给定一个数组 nums，编写一个函数将所有 0 移动到数组的末尾，同时保持非零元素的相对顺序。

示例:
```
输入: [0,1,0,3,12]
输出: [1,3,12,0,0]
```
来源：力扣（LeetCode）
链接：https://leetcode-cn.com/problems/move-zeroes

## 解题思路

先把非0的数挪到前面, 并记录0的个数. 挪完后把后面的数全部置0即可

## 解题代码

```java
class Solution {
    public void moveZeroes(int[] nums) {
        int front= 0;
		int counter = 0;
		//int [] nums = {0,1,0,3,12};
		for(int i=0 ; i<nums.length; i++) {
			if(nums[i] != 0) {
				nums[front] = nums[i];
				front ++;
			}
			else counter++;
		}
		for(int i=front; i<nums.length; i++) {
			nums[i] = 0;
		}
    }
}
```



# 总结前三题

刚上手LeetCode, 大部分题目对目前的我有点难度, 所以就从自己比较熟悉的数组开始尝试, 边学习Java的使用, 边提高算法能力.

前三题其实还是挺简单的, 主要是一个原地修改数组不另外开辟空间的要求, 最后用覆盖的方法解决了就好了.



# 11. 盛最多水的容器
## 题目描述(中等)
给定 n 个非负整数 a1，a2，...，an，每个数代表坐标中的一个点 (i, ai) 。在坐标内画 n 条垂直线，垂直线 i 的两个端点分别为 (i, ai) 和 (i, 0)。找出其中的两条线，使得它们与 x 轴共同构成的容器可以容纳最多的水。

说明：你不能倾斜容器，且 n 的值至少为 2。

![](https://aliyun-lc-upload.oss-cn-hangzhou.aliyuncs.com/aliyun-lc-upload/uploads/2018/07/25/question_11.jpg)

图中垂直线代表输入数组 [1,8,6,2,5,4,8,3,7]。在此情况下，容器能够容纳水（表示为蓝色部分）的最大值为 49。

示例:

```
输入: [1,8,6,2,5,4,8,3,7]
输出: 49
```
来源：力扣（LeetCode）
链接：https://leetcode-cn.com/problems/container-with-most-water

## 解题思路

**解法一**

这个解法可以说相当好像到,就是暴力穷举, 用一个双重循环, 将所有的情况都枚举出来, 取其中的最大值即可. 想是很好想, 但是这个算法的效率却很低, 时间复杂度为O(n^2), 所以在这个题中, 我考虑的就是如何用别的算法来达到降低时间的这个目的.

我先用双重循环试了试它的时间, 最后结果为Java提交记录中的30%, 可见效率之低.

**解法二**

**双指针解法**:我是没想出来这个解法, 也是看了官方题解才明白的. 它的思路在于两条线段之间形成的区域面积受制于两条边中较短的边. 其次, 两条边距离越远, 面积越大. 通过放置两个指针, 一头一尾, 记录当前最大面积max. 然后移动较短的指针, 更新最大面积max, 直至头尾指针相遇. 只需要扫描一遍即可找到最大值, 所以时间复杂度为O(n).

这个方法看起来比较简单, 但是我在思考为什么这个算法正确的时候花了不少时间. 也看了很多讨论, 利用数学的论证这个方法的正确性, 最终也算是搞懂了.

**思考**

我发现对于一个问题啊, 我们特别喜欢用暴力穷举的方法来的到答案, 因为在你穷举的过程中看似吧每种可能都给考虑到了,是最周全的方法,结果也是最可靠的. 但是这种方法就会消耗更多的时间, 并且在问题规模大到一定程度后, 穷举在一定的时间内就是不可能完成的, 所以才会有**算法**的出现.

个人观点, 算法就是用一定的方法, 避免那些"不必要的"穷举, 只需要对部分内容进行操作, 就可以得到正确的结果的过程. 当然算法并不是说一拍脑子就想出来的, 可能想一个算法的过程会有aha moment, 但是想出来了之后都是要通过数学的证明来确定他的正确性的. 所以说数学这个工具也还是很重要的呢.

## 解题代码

```java
public static int maxAreaBetter(int[] height) {
		int max=0;
		for(int i=0,  j=height.length-1; i<j;) {
			max = Math.max(max, Math.min(height[i], height[j])*(j-i));
			if(height[i] < height[j]) {
				i++;
			}
			else j--;
		}
        return max;
    }
```


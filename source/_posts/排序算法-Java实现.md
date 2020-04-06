---
title: 排序算法 Java实现
date: 2020-03-23 09:46:25
tags: 排序算法
categories: 算法
---

<center>
    用Java把常见的排序算法实现了一遍
</center>



<!--more-->

## 冒泡排序

```java
/**
 * 冒泡排序，升序实现
 * @param arr:需要排序的数组
 */
public static void bubbleSort(int[] arr){
    /**
     * 添加一个标志位didSwap
     * 如果数组已经是升序排列，则只需要遍历一遍就可以结束遍历，此时时间复杂度为O(n)
     */
    boolean didSwap = false;
    for(int i = 0; i<arr.length-1; i++){
        for(int j = i+1; j<arr.length; j++){
            if(arr[j] < arr[i]){
                int tmp = arr[j];
                arr[j] = arr[i];
                arr[i] = tmp;
                didSwap = true;
            }
        }
        if(didSwap == false) return;
    }
}
```

## 插入排序

```java
/**
 * 插入排序
 * 升序实现
 * @param arr:需要排序的数组
 */
public static void insertSort(int[] arr){
    int num;
    for(int i = 1; i<arr.length; i++){
        num = arr[i];
        int j;
        for(j = i -1; j>=0 && arr[j] > num; j--){
            arr[j+1] = arr[j];
        }
        arr[j+1] = num;
    }
}
```

## 选择排序

```java
/**
 * 选择排序，升序实现
 * @param arr:需要排序的数组
 */
public static void selectSort(int[] arr){
    for(int i = 0; i < arr.length-1; i++){
        int min = arr[i];
        int place = 0;
        for(int j = i+1; j<arr.length; j++){
            if(arr[j] < min){
                min = arr[j];
                place = j;
            }
        }
        int tmp = arr[place];
        arr[place] = arr[i];
        arr[i] = tmp;
    }

}

```

## 希尔排序

```java
/**
 * 希尔排序，升序实现
 * @param arr:需要排列的数组
 */
public static void shellSort(int[] arr){
    int len = arr.length;
    while (len != 0){
        len /= 2;
        for(int i = 0; i<len; i++){
            for(int j = i + len; j<arr.length; j += len){
                int k = j - len;
                int tmp = arr[j];
                while (k >= 0 && tmp < arr[k]){
                    arr[k+len] = arr[k];
                    k -= len;
                }
                arr[k+len] = tmp;
            }
        }
    }
}

```

## 归并排序

```java
/**
 * 归并排序
 * 升序排列int数组
 * @param A:需要排列的数组
 * @param lo:数组起始下标
 * @param hi:数组结束下标
 */
public static void mergeSort(int[] A, int lo, int hi){
    //升序方式排列数组
    //如果lo>=hi,说明数组中只有一个元素，应该返回
    if(lo >= hi) return;
    //取中位数
    int mid = lo + (hi-lo)/2;

    //左右递归两遍的数组
    mergeSort(A, lo, mid);
    mergeSort(A, mid+1, hi);

    //递归结束,进行合并
    merge(A, lo, mid, hi);
}

private static void merge(int[] nums, int lo, int mid, int hi){
    //复制原来的数组
    int[] cp = nums.clone();

    //k表示从什么位置修改原来的数组,i是左边开始的起始位置,j是右边开始的起始位置
    int k = lo, i = lo, j = mid+1;
    while (k <= hi){
        //如果左边已经放置完了,就直接放置右边剩下的
        //如果右边已经放置完了,就直接放置左边剩下的
        //如果左边大于右边,则放置右边,否则放置左边.
        if(i > mid) nums[k++] = cp[j++];
        else if(j > hi) nums[k++] = cp[i++];
        else if(cp[i] > cp[j]) nums[k++] = cp[j++];
        else nums[k++] = cp[i++];
    }
}

```

## 快速排序

```java
/**
 * 快速排序
 * 升序排列int数组
 * @param nums:需要排列的数组
 * @param lo:数组起始下标
 * @param hi:数组结束下标
 */
public static void quickSort(int[] nums, int lo, int hi){
    //如果只有一个元素了,则返回
    if(lo >= hi) return ;

    //获取参照值
    int p = partition(nums, lo, hi);

    //把比p小的放到左边,比p大的放到右边
    quickSort(nums, lo, p-1);
    quickSort(nums, p+1, hi);
}

private static int partition(int[] nums, int lo, int hi){
    int tmp = nums[lo];

    while (lo < hi){
        while (lo < hi && nums[hi] > tmp) hi--;
        nums[lo] = nums[hi];
        while (lo < hi && nums[lo] < tmp) lo++;
        nums[hi] = nums[lo];
    }
    nums[lo] = tmp;
    return lo;  //返回中轴位置
}

```


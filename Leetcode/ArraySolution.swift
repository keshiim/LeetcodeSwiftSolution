//
//  ArraySolution.swift
//  Leetcode
//
//  Created by Jason on 2017/12/11.
//  Copyright © 2017年 Jason. All rights reserved.
//

import Foundation

class ArraySolution {
    
//1 /// 题目：Remove Duplicates from Sorted Array(有序数组去重)
    /// Given a sorted array, remove the duplicates in place such that each element appear only once and return the new length.
    /// Do not allocate extra space for another array, you must do this in place with constant memory.
    /// For example, Given input array A = [1,1,2],
    /// Your function should return length = 2, and A is now [1,2].
    ///
    /// - Parameter nums: 待重复数组
    /// - Returns: 去重后的数组的元素个数
    /// 两指针，一开始两指针指向的是数组的第一个元素，如果两指针指向的数字相等，
    /// 则快指针向前走一步，若果不相等，则两个指针都向前走一步，这样当快指针走完整个数组后，慢指针当前的坐标加1就是数组中不同数字的个数
    func removeDuplicates(_ nums: inout [Int]) -> Int {
        //两个指针
        if nums.isEmpty { return 0 }
        var pre = 0, cur = 0
        while cur < nums.count {
            if nums[cur] == nums[pre] { cur += 1 } //相等 cur 指向下一个
            else {
                pre += 1
                nums[pre] = nums[cur]
                cur += 1
            }
        }
        return pre + 1
    }
    
//2 /// 题目：Remove Duplicates from Sorted Array II(在数组中去除重复值，可最大保留连续保留2位)
    /// Follow up for ”Remove Duplicates”: What if duplicates are allowed at most twice? For example, Given sorted array A = [1,1,1,2,2,3],
    /// Your function should return length = 5, and A is now [1,1,2,2,3]
    ///
    /// - Parameter nums: 待重复数组
    /// - Returns: 去重后的数组的元素个数
    func removeDuplicatesII(_ nums: inout [Int]) -> Int {
        //边界情况
        if nums.count <= 2 { return nums.count }
        
        var lastIndex = 1
        for i in 2..<nums.count {
            if nums[lastIndex] != nums[i] || nums[lastIndex] != nums[lastIndex - 1] {
                lastIndex += 1
                nums[lastIndex] = nums[i]
            }
        }
        return lastIndex + 1
    }
    

}

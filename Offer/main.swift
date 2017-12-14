//
//  main.swift
//  Offer
//
//  Created by Jason on 2017/12/14.
//  Copyright © 2017年 Jason. All rights reserved.
//

/*
 * 剑指offer题解
 */
import Foundation

//MARK: 题目1：二维数组中的查找
    /// 描述：在一个二维数组中，每一行都按照从左到右递增的顺序排序，每一列都按照从上到下递增的顺序排序。
    ///       请完成一个函数，输入这样的一个二维数组和一个整数，判断数组中是否含有该整数。
    /// 思路：1. 暴力遍历查找
    ///      2. 分治解法: 右上角、左下角 开始遍历
    ///                  右上角：如果查找的元素比当前位置元素小, 就向左走。如果查找的元素比当前位置元素大, 就向下走
    ///                  左下角：如果查找的元素比当前位置元素小, 就向上走。如果查找的元素比当前位置元素大, 就向右走
func Find(_ nums: [[Int]], _ target: Int) -> Bool {
    //右上角开始
    func findRT(_ nums: [[Int]], _ target: Int) -> Bool {
        let row = nums.count, colmn = nums[0].count
        var i = 0, j = colmn - 1
        while (i >= 0 && i < row) && (j >= 0 && j < colmn) {
            if nums[i][j] == target {
                return true
            } else if nums[i][j] < target {
                i += 1
            } else {
                j -= 1
            }
        }
        return false
    }
    //左下角开始
    func findLB(_ nums: [[Int]], _ target: Int) -> Bool {
        let row = nums.count, colmn = nums[0].count
        var i = row - 1, j = 0
        while (i >= 0 && i < row) && (j >= 0 && j < colmn) {
            if nums[i][j] == target {
                return true
            } else if nums[i][j] < target {
                j += 1
            } else {
                i -= 1
            }
        }
        return false
    }
    return findRT(nums, target)
    //return findLB(nums, target)
}

//MARK: 测试用例
////////////////////////////////////////
///////////Test 测试////////////////////
////////////////////////////////////////
print(Find([[1, 2, 8, 9],
            [2, 4, 9, 12],
            [4, 7, 10, 13],
            [6, 8, 11, 15]], 7))
print(Find([[1, 2, 8, 9],
            [2, 4, 9, 12],
            [4, 7, 10, 13],
            [6, 8, 11, 15]], 3))

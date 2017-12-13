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
    
// 3 /// 题目：Max Consecutive Ones(找出最大联系数字) [Easy]
     /// Input: [1,1,0,1,1,1]
     /// Output: 3
     /// Explanation: The first two digits or the last three digits are consecutive 1s.
     /// The maximum number of consecutive 1s is 3.
    func findMaxConsecutiveOnes(_ nums: [Int]) -> Int {
        var global = 0, local = 0
        for num in nums {
            if num == 1 {
                local += 1
                global = max(global, local)
            } else {
                local = 0
            }
        }
        return global
    }
//4 /// 题目：Heaters(计算加热器覆盖所有房屋的最小半径) [Easy]
    /// Input: [1,2,3,4],[1,4]
    /// Output: 1
    /// Explanation: The two heater was placed in the position 1 and 4. We need to use radius 1 standard, then all the houses can be warmed.
    func findRadius(_ houses: [Int], _ heaters: [Int]) -> Int {
        var radius  = 0, i = 0
        let houses = houses.sorted()
        let heaters = heaters.sorted()
        for house in houses {
            if i < heaters.count - 1 && 2 * house >= heaters[i] + heaters[i + 1] {
                i += 1
            }
            radius = max(radius, abs(heaters[i] - house))
        }
        return radius
    }
//5 /// 题目：Number of Boomerangs (回旋镖的数量)
    /// Example:
    /// Input:
    /// [[0,0],[1,0],[2,0]]
    /// Explanation:
    /// output: 2
    /// The two boomerangs are [[1,0],[0,0],[2,0]] and [[1,0],[2,0],[0,0]]
    /// 求每一个点到A点的距离，然后保存在table[距离，次数]中，最后累加 [次数]*[次数-1]。
    /// 比如  b   c   d , b c d到A的距离都相等 abc acb acd adc abd adb,
    ///      \   |   /
    ///          a
    /// 以a作为中心点，从 b c d 中超出两个点全排列 A(3,2) = 6，然后b c d都轮流作为中心点，以此类推
    func numberOfBoomerangs(_ points: [[Int]]) -> Int {
        var res = 0
        for (i, point) in points.enumerated() {
            //数组中所有点轮流作为中心点
            var dict = [Int: Int]()
            for (j, anotherPoint) in points.enumerated() {
                if i == j { continue }
                let distance = (point[0] - anotherPoint[0]) * (point[0] - anotherPoint[0]) + (point[1] - anotherPoint[1]) * (point[1] - anotherPoint[1])
                if let sameDistance = dict[distance] {
                    dict[distance] = sameDistance + 1
                } else {
                    dict[distance] = 1
                }
            }
            
            for key in dict.keys {
                res += dict[key]! * (dict[key]! - 1)
            }
        }
        return res
    }
//6 /// 题目：Island Perimeter(岛屿周长) [Easy]
    ///这道题给了我们一个格子图，若干连在一起的格子形成了一个小岛，规定了图中只有一个相连的岛，且岛中没有湖，让我们求岛的周长。我们知道一个格子有四条边，但是当两个格子相邻，周围为6，若某个格子四周都有格子，那么这个格子一条边都不算在周长里。那么我们怎么统计出岛的周长呢？第一种方法，我们对于每个格子的四条边分别来处理，首先看左边的边，只有当左边的边处于第一个位置或者当前格子的左面没有岛格子的时候，左边的边计入周长。其他三条边的分析情况都跟左边的边相似
//    if (j == 0 || grid[i][j - 1] == 0) ++res;
//    if (i == 0 || grid[i - 1][j] == 0) ++res;
//    if (j == n - 1 || grid[i][j + 1] == 0) ++res;
//    if (i == m - 1 || grid[i + 1][j] == 0) ++res;
    func islandPerimeter(_ grid: [[Int]]) -> Int {
        guard !grid.isEmpty && !grid[0].isEmpty else {
            return 0
        }
        var res = 0
        for i in 0..<grid.count {
            for j in 0..<grid[0].count {
                if grid[i][j] == 1 {
                    res += 4
                    //右下如果有岛屿减去2
                    if i < grid.count - 1 && grid[i + 1][j] == 1 { res -= 2 } //下
                    if j < grid[0].count - 1 && grid[i][j + 1] == 1 { res -= 2}//右
                }
            }
        }
        return res
    }

//7 /// 题目：Majority Element(求众数) [Easy]
    /// 出现最多的数字
    //位操作
//    func majorityElement(_ nums: [Int]) -> Int {
//        var res = Int32(0)
//        for i in 0..<32 {
//            var ones = 0, zeros = 0
//            for num in nums {
//                //判断当前位
//                if num & (1 << i) != 0 { ones += 1 }
//                else { zeros += 1 }
//            }
//            if ones > zeros {
//                res |= 1 << i
//            }
//        }
//        return Int(res)
//    }
    func majorityElement(_ nums: [Int]) -> Int {
        var res = 0, cnt = 0
        for num in nums {
            if cnt == 0 {
                res = num
                cnt += 1
            } else {
                if res == num {
                    cnt += 1
                } else {
                    cnt -= 1
                }
            }
        }
        return res
    }
//8 /// 题目：Majority Element II (求众数之二) [medium]
    /// 描述：Given an integer array of size n, find all elements that appear more than ⌊ n/3 ⌋ times.
    ///      The algorithm should run in linear time and in O(1) space.
    /// 题解：traverse the array and track the majority element accordingly, do not forget to verify they are valid after first iteration
    func majorityElement(_ nums: [Int]) -> [Int] {
        var m = 0, n = 0, mcnt = 0, ncnt = 0
        var res = [Int]()
        for num in nums {
            if num == m { mcnt += 1 }
            else if num == n { ncnt += 1 }
            else if mcnt == 0 {
                m = num
                mcnt += 1
            } else if ncnt == 0 {
                n = num
                ncnt += 1
            } else {
                mcnt -= 1
                ncnt -= 1
            }
        }
        //verify
        mcnt = 0
        ncnt = 0
        for num in nums {
            if num == m { mcnt += 1 }
            else if num == n { ncnt += 1 }
        }
        if mcnt > nums.count / 3 { res.append(m) }
        if ncnt > nums.count / 3 { res.append(n) }
        return res
    }
}

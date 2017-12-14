//
//  ArraySolution.swift
//  Leetcode
//
//  Created by Jason on 2017/12/11.
//  Copyright © 2017年 Jason. All rights reserved.
//

import Foundation

class ArraySolution {
    
//MARK: 题目1：Remove Duplicates from Sorted Array(有序数组去重)
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
    
//MARK: 题目2：Remove Duplicates from Sorted Array II(在数组中去除重复值，可最大保留连续保留2位)
    /// Follow up for ”Remove Duplicates”: What if duplicates are allowed at most twice? For example, Given sorted array A = [1,1,1,2,2,3],
    /// Your function should return length = 5, and A is now [1,1,2,2,3]
    ///      index-1 index   cur
    ///       /        |      \
    ///      a         a       a
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
    
//MARK: 题目3：Max Consecutive Ones(找出最大连续数字) [Easy]
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
//MARK: 题目4：Heaters(计算加热器覆盖所有房屋的最小半径) [Easy]
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
//MARK: 题目5：Number of Boomerangs (回旋镖的数量)
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
//MARK: 题目6：Island Perimeter(岛屿周长) [Easy]
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

//MARK: 题目7：Majority Element(求众数) [Easy]
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
//MARK: 题目8：Majority Element II (求众数之二) [medium]
    /// 描述：Given an integer array of size n, find all elements that appear more than ⌊ n/3 ⌋ times.
    ///      The algorithm should run in linear time and in O(1) space.
    /// 题解：traverse the array and track the majority element accordingly, do not forget to verify they are valid after first iteration
    func majorityElementII(_ nums: [Int]) -> [Int] {
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
//MARK: 题目9：Intersection of Two Arrays(两个数组交集) [Easy]
    /// 思路：1. 将数组1存入hashmap，遍历数组2在hashmap中找
    ///      2. 两个指针, 现将两个数组排序，遍历，谁小谁后移，相等就加入res中，(判断res最后一个元素是否等于待加入元素)
    ///      3. 一个数组排序，遍历另一个数组，在排序中的数组中进行二分查找，然后找到后添加在Set中
    ///      4. 标准库可以解决
    ///  这里用方法2
    func intersection(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
        var res = [Int]()
        //先排序
        let nums1 = nums1.sorted()
        let nums2 = nums2.sorted()
        var i = 0, j = 0
        while i < nums1.count && j < nums2.count {
            if nums1[i] < nums2[j] {
                i += 1
            } else if nums1[i] > nums2[j] {
                j += 1
            } else {
                //相等
                if res.isEmpty || res.last! != nums1[i] {
                    res.append(nums1[i])
                }
                i += 1
                j += 1
            }
        }
        return res
    }
//MARK: 题目10：Intersection of Two Arrays II (两个数组相交之二) [Easy]
    /// 思路：如上
    func intersect(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
        let nums1 = nums1.sorted()
        let nums2 = nums2.sorted()
        var i = 0, j = 0
        var res = [Int]()
        while (i < nums1.count && j < nums2.count) {
            if nums1[i] > nums2[j] {
                j += 1
            } else if nums1[i] < nums2[j] {
                i += 1
            } else {
                //相等
                res.append(nums1[i])
                i += 1
                j += 1
            }
        }
        return res
    }
//MARK: 题目11：Contains Duplicate (包含重复值) [Easy]
    /// 思路：1. 遍历数组，如果当前元素在hashMap存在则返回true，不存在继续放入哈希表中
    ///      2. 先排序，在找前后元素是否相同
    func containsDuplicate(_ nums: [Int]) -> Bool {
        if nums.isEmpty || nums.count < 2 { return false }
        let nums = nums.sorted()
        for i in 1..<nums.count {
            if nums[i - 1] == nums[i] { return true }
        }
        return false
    }
//MARK: 题目12：Contains Duplicate II (包含重复值之二) [Easy]
    /// 思路：遍历数组，建立一个元素和索引关系的哈希表，找哈希表中存在index，并且i-index<=k，返回ture，否则将i继续覆盖或新放入哈希表中
    func containsNearbyDuplicate(_ nums: [Int], _ k: Int) -> Bool {
        var map = [Int: Int]()
        for (i, num) in nums.enumerated() {
            if let index = map[num], i - index <= k  {
                return true
            } else {
                map[num] = i
            }
        }
        return false
    }
//MARK: 题目13：Move Zeroes(移动零) [Easy]
    /// 思路：两个指针
    func moveZeroes(_ nums: inout [Int]) {
        var i = 0, j = 0
        while i < nums.count {
            if nums[i] != 0 {
                if i != j {
                    nums.swapAt(i, j)
                }
                j += 1
            }
            i += 1
        }
    }
//MARK: 题目14：Remove Element (移除元素) [Easy]
    /// 思路：两指针
    func removeElement(_ nums: inout [Int], _ val: Int) -> Int {
        if nums.isEmpty { return 0 }
        var j = 0
        for i in 0..<nums.count {
            if nums[i] != val {
                nums[j] = nums[i]
                j += 1
            }
        }
        return j
    }
//MARK: 题目15：Two Sum 两数之和
    /// 思路：哈希表
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        var res = [Int: Int]()
        for (i, num) in nums.enumerated() {
            if let idx = res[target - num] {
                return [idx, i]
            }
            res[num] = i
        }
        return []
    }
//MARK: 题目16：3Sum 三数之和
    /// 思路：先排序，在遍历数组，然后假使第一个数字是负数，target = 0-第一个数字，转换求Tow Sum问题
    func threeSum(_ nums: [Int]) -> [[Int]] {
        var res = [[Int]]()
        //sort
        let nums = nums.sorted()
        for k in 0..<nums.count {
            if nums[k] > 0 { break }
            if k > 0 && nums[k] == nums[k - 1] { continue }
            let target = 0 - nums[k]
            var i = k + 1, j = nums.count - 1
            while (i < j) {
                if nums[i] + nums[j] == target {
                    res.append([nums[k], nums[i], nums[j]])
                    while i < j && nums[i] == nums[i + 1] {
                        i += 1
                    }
                    while i < j && nums[j] == nums[j - 1] {
                        j -= 1
                    }
                    i += 1
                    j -= 1
                } else if nums[i] + nums[j] < target {
                    i += 1
                } else {
                    j -= 1
                }
            }
        }
        return res
    }
}


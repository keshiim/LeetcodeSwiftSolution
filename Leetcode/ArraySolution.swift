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
//MARK: 题目16：3Sum 三数之和等于零 [Medium]
    /// 思路：先排序，在遍历数组，然后假使第一个数字是负数，target = 0 - 第一个数字，转换求Tow Sum问题
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
//MARK: 题目17：3Sum Closest 最近三数之和接近指定值 [Medium]
    /// 思路：先排序，在遍历数组，然后left 和 right滑动寻找另连个数字，然后min(diff, newDiff)，更新diff和结果
    func threeSumClosest(_ nums: [Int], _ target: Int) -> Int {
        var res = nums[0] + nums[1] + nums[2], diff = abs(res - target)
        let nums = nums.sorted()
        for i in 0..<nums.count {
            var left = i + 1, right = nums.count - 1
            while left < right {
                let sum = nums[i] + nums[left] + nums[right]
                let newDiff = abs(sum - target)
                if newDiff < diff {
                    diff = newDiff
                    res = sum
                }
                if sum < target {
                    left += 1
                } else {
                    right -= 1
                }
            }
        }
        return res
    }
//MARK: 题目18：4Sum 四数之和等于指定值 [Medium]
    /// 思路：与3Sum类似，不同的是外侧还需要嵌套一层循环
    func fourSum(_ nums: [Int], _ target: Int) -> [[Int]] {
        var res = [[Int]]()
        let nums = nums.sorted()
        guard nums.count >= 4 else {
            return res
        }
        for i in 0..<nums.count - 3 {
            for j in (i + 1)..<nums.count - 2 {
                var left = j + 1, right = nums.count - 1
                while left < right {
                    let sum = nums[i] + nums[j] + nums[left] + nums[right]
                    if sum == target {
                        let cur = [nums[i], nums[j], nums[left], nums[right]]
                        if (!res.contains(where: { (item) -> Bool in
                            let b1 = item[0] == cur[0]
                            let b2 = item[1] == cur[1]
                            let b3 = item[2] == cur[2]
                            let b4 = item[3] == cur[3]
                            return b1 && b2 && b3 && b4
                        })) {
                            res.append(cur)
                        }
                        left += 1
                        right -= 1
                    } else if sum < target {
                        left += 1
                    } else {
                        right -= 1
                    }
                }
            }
        }
        return res
    }
    
//MARK: 题目19：Summary Ranges 总结区间 [Medium]
    /// 思路：具体来说就是让我们找出连续的序列，然后首尾两个数字之间用个“->"来连接。
    ///      那么我只需遍历一遍数组即可，每次检查下一个数是不是递增的，如果是，则继续往下遍历，如果不是了，
    ///      我们还要判断此时是一个数还是一个序列，一个数直接存入结果，序列的话要存入首尾数字和箭头“->"。
    ///      我们需要两个变量i和j，其中i是连续序列起始数字的位置，j是连续数列的长度，当j为1时，说明只有一个数字，若大于1，则是一个连续序列
    func summaryRanges(_ nums: [Int]) -> [String] {
        //eg: [0, 1, 3, 4, 5,7, 8]
        var res = [String]()
        var i = 0, j = 0, n = nums.count
        while i < n {
            j = 1
            while i + j < n && nums[i + j] - nums[i] == j { j += 1 }
            j > 1 ? res.append("\(nums[i])->\(nums[i + j - 1])") : res.append("\(nums[i])")
            i += j
        }
        return res
    }
//MARK: 题目20：Shortest Word Distance 最短单词距离 [Easy]
    /// 思路：我们用两个变量p1,p2初始化为-1，然后我们遍历数组，遇到单词1，就将其位置存在p1里，
    /// 若遇到单词2，就将其位置存在p2里，如果此时p1, p2都不为-1了，那么我们更新结果
    func shortestDistance(_ words: [String], word1: String, word2: String) -> Int {
        var p1 = -1, p2 = -1, res = Int.max
        for (i, word) in words.enumerated() {
            if word == word1 { p1 = i }
            if word == word2 { p2 = i }
            if p1 != -1 && p2 != -1 {
                res = min(res, abs(p1 - p2))
            }
        }
        return res  
    }
///MARK: 题目21：Shortest Word Distance III 最短单词距离之三 [Medium]
    /// 描述：和上道题【Shortest Word Distance】不同在于输入的word1和word2可以重复
    /// 思路：如果w1和w2相同，用t来记录p1上次的值(t - p1)，不同走原来逻辑(p1 - p2)
    func shortestDistanceIII(_ words: [String], word1: String, word2: String) -> Int {
        var p1 = -1, p2 = -1, res = Int.max
        var t = 0
        for (i, word) in words.enumerated() {
            t = p1
            if word == word1 { p1 = i }
            if word == word2 { p2 = i }
            if p1 != -1 && p2 != -1 {
                if word1 == word2 {
                    if t != -1 && p1 != t {
                        res = min(res, abs(t - p1))
                    }
                } else {
                    res = min(res, abs(p1 - p2))
                }
            }
        }
        return res
    }
}


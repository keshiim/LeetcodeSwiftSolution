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
//MARK: 题目21：Shortest Word Distance III 最短单词距离之三 [Medium]
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
//MARK: 题目22：Maximum Size Subarray Sum Equals k 最大子数组之和为k [Easy]
    /// 思路：1. X + k = Sum (区间)
    ///      2. 0 + k = Sum (非区间)
    /// eg: nums: [1, -1, 5, -2, 3], k = 3
    ///     sums: [1,  0, 5,  3, 6] 非区间，res = i + 1, 3 + 1 = 4
    /////////////////
    ///     nums: [-2, -1,  2, 1], k = 1
    ///     sums: [-2, -3, -1, 0] 区间 sum - k = X (-1 - 1) = -2, res = i - (-2的index) = 2 - 0 = 2
    /// 参考链接：http://www.cnblogs.com/grandyang/p/5336668.html
    func maxSubArrayLen(_ nums: [Int], k: Int) -> Int {
        var sum = 0, res = 0
        var m = [Int: Int]()
        for i in 0..<nums.count {
            sum += nums[i] //变量sum累加
            if sum == k { res = i + 1 } //非区间
            else if let fIndex = m[sum - k] {
                res = max(res, i - fIndex) //寻找区间
            }
            guard m[sum] != nil else {
                m[sum] = i //记录累加和sum的第一次出现的index
                continue
            }
        }
        return res
    }
    
//MARK: 题目22：Product of Array Except Self 除自身所有元素的乘积 [Medium]
    /// 思路：对于某一个数字，如果我们知道其前面所有数字的乘积，同时也知道后面所有的数乘积，
    ///      那么二者相乘就是我们要的结果，所以我们只要分别创建出这两个数组即可，分别从数组的两个方向遍历就可以分别创建出乘积累积数组.
    ///      对上面的方法进行空间上的优化，由于最终的结果都是要乘到结果res中，所以我们可以不用单独的数组来保存乘积，而是直接累积到res中，
    ///      我们先从前面遍历一遍，将乘积的累积存入res中，然后从后面开始遍历，用到一个临时变量right，初始化为1，然后每次不断累积，最终得到正确结果
    //   1   2   3   4
    //L: 1   1   2   6  *
    //R: 24  12  4   1  *
    //F: 24  12  8   6
    func productExceptSelf(_ nums: [Int]) -> [Int] {
        var res = [Int](repeating: 1, count: nums.count)
        for i in 1..<nums.count {
            res[i] = res[i - 1] * nums[i - 1]
        }
        var right = 1, j = nums.count - 1
        while j >= 0 {
            res[j] *= right
            right *= nums[j]
            j -= 1
        }
        return res
    }
//MARK: 题目23：Rotate Array 旋转数组 [Easy]
    /// 思路：1. 我们先来看一种O(n)的空间复杂度的方法，我们复制一个和nums一样的数组，然后利用映射关系i -> (i+k)%n来交换数字
    /// 思路：2. 使用类似翻转字符的方法，思路是先把整个数组翻转一下，再把前k个数字翻转一下，最后再把后n-k个数字翻转一下
    /// 思路：3. 这种方法其实还蛮独特的，通过不停的交换某两个数字的位置来实现旋转
    ///          1 2 3 4 5 6 7
    ///          5 2 3 4 1 6 7
    ///          5 6 3 4 1 2 7
    ///          5 6 7 4 1 2 3
    ///          5 6 7 1 4 2 3
    ///          5 6 7 1 2 4 3
    ///          5 6 7 1 2 3 4
    func rotate(_ nums: inout [Int], _ k: Int) {
        /// 帮助方法
        func _reverse(_ nums: inout [Int], startIdx: Int, endIdx: Int) {
            //边界情况
            guard startIdx >= 0, endIdx < nums.count, startIdx < endIdx else {
                return
            }
            var startIdx = startIdx
            var endIdx = endIdx
            while startIdx < endIdx {
                _swap(&nums, startIdx, endIdx)
                startIdx += 1
                endIdx -= 1
            }
        }
        func _swap<T>(_ nums: inout Array<T>, _ p: Int, _ q: Int) {
            (nums[p], nums[q]) = (nums[q], nums[p])
        }
        
        //方法1
        func rotateI(_ nums: inout [Int], _ k: Int) {
            let t = nums
            for i in 0 ..< nums.count {
                nums[(i + k) % nums.count] = t[i]
            }
        }
        
        //方法2
        func rotateII(_ nums: inout [Int], _ k: Int) {
            let k = k % nums.count
            _reverse(&nums, startIdx: 0, endIdx: nums.count - 1)
            _reverse(&nums, startIdx: 0, endIdx: k - 1)
            _reverse(&nums, startIdx: k, endIdx: nums.count - 1)
        }
        
        //方法3
        func rotateIII(_ nums: inout [Int], _ k: Int) {
            guard !nums.isEmpty else {
                return
            }
            var start = 0, n = nums.count
            var k = k % n
            while n != 0 && k != 0 {
                for i in 0 ..< k {
                    nums.swapAt(i + start, n - k + (i + start))
                }
                n -= k
                start += k
                k %= n
            }
        }
        
        //rotateI(&nums, k)
        rotateII(&nums, k)
        //rotateIII(&nums, k)
    }
//MARK: 题目24：Rotate Image 旋转图像 [Medium]
    /// 思路：从外侧 到 内存，一圈一圈的选择
    /// 1  2  3    7  2  1    7  4  1  先是 1 3 7 9 相互替换
    /// 4  5  6 -> 4  5  6 -> 8  5  2  再是 2 6 8 4 相互替换
    /// 7  8  9    9  8  3    9  6  3  下一圈只有一个数字5 不用动了
    func rotate(_ matrix: inout [[Int]]) {
        let n = matrix.count
        for layer in 0..<n / 2 {
            let start = layer, end = n - layer - 1
            for i in start..<end {
                let offset = i - start
                (matrix[start][i], matrix[i][end], matrix[end][end - offset], matrix[end - offset][start]) = (matrix[end - offset][start], matrix[start][i], matrix[i][end], matrix[end][end - offset])
            }
        }
    }
//MARK: 题目25：Spiral Matrix 螺旋矩阵 [Medium]
    /// 思路：这道题让我们将一个矩阵按照螺旋顺序打印出来，我们只能一条边一条边的打印，首先我们要从给定的mxn的矩阵中算出按螺旋顺序有几个环，
    ///      注意最终间的环可以是一个数字，也可以是一行或者一列。环数的计算公式是 min(m, n) / 2，知道了环数，我们可以对每个环的边按顺序打印，
    ///      比如对于题目中给的那个例子，个边生成的顺序是(用颜色标记了数字) Red -> Green -> Blue -> Yellow -> Black
    ///       →
    ///     1　2　3
    ///   ↑ 4　5　6  ↓
    ///     7　8　9
    ///       ←
    ///    我们定义h，w为当前环的高度和宽度，当h或者w为1时，表示最后一个环只有一行或者一列，可以跳出循环
    func spiralOrder(_ matrix: [[Int]]) -> [Int] {
        var res  = [Int]()
        guard matrix.count != 0 else {
            return res
        }
        var h = matrix.count, w = matrix[0].count //宽、高
        let c = (min(h, w) + 1) / 2 //计算圈数
        for i in 0..<c {
            //top
            for col in i..<i + w {
                res.append(matrix[i][col])
            }
            //right
            for row in i + 1..<i + h {
                res.append(matrix[row][i + w - 1])
            }
            if h == 1 || w == 1 {
                break
            }
            //bottom
            var col = i + w - 2
            while col >= i {
                res.append(matrix[i + h - 1][col])
                col -= 1
            }
            //left
            var row = i + h - 2
            while row > i {
                res.append(matrix[row][i])
                row -= 1
            }
            h -= 2
            w -= 2
        }
        return res
    }
//MARK: 题目26：Spiral Matrix II 螺旋矩阵之二-创建矩阵 [Medium]
    /// 思路：同上
    func generateMatrix(_ n: Int) -> [[Int]] {
        var res = [[Int]](repeating: [Int](repeating: 1, count: n), count: n)
        var p = n, val = 1
        for c in 0..<n / 2 { //遍历每一圈
            //top
            for col in c..<c + p {
                res[c][col] = val
                val += 1
            }
            //right
            for row in c + 1..<c + p {
                res[row][c + p - 1] = val
                val += 1
            }
            //bottom
            var col = c + p - 2
            while col >= c {
                res[c + p - 1][col] = val
                val += 1
                col -= 1
            }
            //left
            var row = c + p - 2
            while row > c {
                res[row][c] = val
                val += 1
                row -= 1
            }
            p -= 2
        }
        if n % 2 != 0 { // 赋值，最内层有单独元素
            res[n / 2][n / 2] = val
        }
        return res
    }
//MARK: 题目27：Valid Sudoku 验证数独 [Medium]
    /// 思路：判断标准是看各行各列是否有重复数字，以及每个小的3x3的小方阵里面是否有重复数字，如果都无重复，
    ///      则当前矩阵是数独矩阵，但不代表待数独矩阵有解，只是单纯的判断当前未填完的矩阵是否是数独矩阵。
    ///      那么根据数独矩阵的定义，我们在遍历每个数字的时候，就看看包含当前位置的行和列以及3x3小方阵中是否已经出现该数字，
    ///      那么我们需要三个标志矩阵，分别记录各行，各列，各小方阵是否出现某个数字，其中行和列标志下标很好对应，就是小方阵的下标需要稍稍转换一下
    func isValidSudoku(_ board: [[Character]]) -> Bool {
        if board.isEmpty || board[0].isEmpty { return false }
        let n = board.count
        var rowFlag = [[Bool]](repeating: [Bool](repeating: false, count: n), count: n)
        var colFlag = [[Bool]](repeating: [Bool](repeating: false, count: n), count: n)
        var cellFlag = [[Bool]](repeating: [Bool](repeating: false, count: n), count: n)
        for i in 0..<n {
            for j in 0..<n {
                if var c = Int(String(board[i][j])) {
                    c -= 1
                    //3【每行总数】 * (i / 3【以3划分】)【行数】 + (j / 3)【列数】
                    if rowFlag[i][c] || colFlag[c][j] || cellFlag[3 * (i / 3) + j / 3][c] {
                        return false
                    }
                    rowFlag[i][c] = true
                    colFlag[c][j] = true
                    cellFlag[3 * (i / 3) + j / 3][c] = true
                }
            }
        }
        return true
    }
//MARK: 题目27：Set Matrix Zeroes 矩阵赋零 [Medium]
    /// 思路： 空间复杂度为O(1)的方法：
    ///       先扫描第一行第一列，如果有0，则将各自的flag设置为true
    ///       然后扫描除去第一行第一列的整个数组，如果有0，则将对应的第一行和第一列的数字赋0
    ///       再次遍历除去第一行第一列的整个数组，如果对应的第一行和第一列的数字有一个为0，则将当前值赋0
    ///       最后根据第一行第一列的flag来更新第一行第一列
    func setZeroes(_ matrix: inout [[Int]]) {
        //处理边界
        if matrix.isEmpty || matrix[0].isEmpty {
            return
        }
        let r = matrix.count, c = matrix[0].count
        var rowZero = false, colZero = false
        for i in 0..<r {
            if matrix[i][0] == 0 { colZero = true }
        }
        for i in 0..<c {
            if matrix[0][i] == 0 { rowZero = true }
        }
        for i in 0..<r {
            for j in 0..<c {
                if matrix[i][j] == 0 {
                    matrix[0][j] = 0
                    matrix[i][0] = 0
                }
            }
        }
        for i in 0..<r {
            for j in 0..<c {
                if matrix[0][j] == 0 || matrix[i][0] == 0 {
                    matrix[i][j] = 0
                }
            }
        }
        if rowZero {
            for i in 0..<c {
                matrix[0][i] = 0
            }
        }
        if colZero {
            for i in 0..<r {
                matrix[i][0] = 0
            }
        }
    }
//MARK: 题目28：Next Permutation 下一个排列 [Medium]
    /// 思路：1　　2　　7　　4　　3　　1
    ///      下一个排列为：
    ///      1　　3　　1　　2　　4　　7
    /// 那么是如何得到的呢，我们通过观察原数组可以发现，如果从末尾往前看，数字逐渐变大，到了2时才减小的，然后我们再从后往前找第一个比2大的数字，
    /// 是3，那么我们交换2和3，再把此时3后面的所有数字转置一下即可，步骤如下：
    /// 1　　2　　7　　4　　3　　1
    ///     -
    /// 1　　2　　7　　4　　3　　1
    ///     -            -
    /// 1　　3　　7　　4　　2　　1
    ///     -            -
    /// 1　　3　　1　　2　　4　　7
    ///         -    -   -   -
    func nextPermutation(_ nums: inout [Int]) {
        /// 帮助方法
        func _reverse(_ nums: inout [Int], startIdx: Int, endIdx: Int) {
            //边界情况
            guard startIdx >= 0, endIdx < nums.count, startIdx < endIdx else {
                return
            }
            var startIdx = startIdx
            var endIdx = endIdx
            while startIdx < endIdx {
                _swap(&nums, startIdx, endIdx)
                startIdx += 1
                endIdx -= 1
            }
        }
        func _swap<T>(_ nums: inout Array<T>, _ p: Int, _ q: Int) {
            (nums[p], nums[q]) = (nums[q], nums[p])
        }
        
        guard nums.count > 0 else {
            return
        }
        var violate = -1
        //find violate
        for i in stride(from: nums.count - 1, to: 0, by: -1) {
            if nums[i] > nums[i - 1] {
                violate = i - 1
                break
            }
        }
        if violate != -1 {
            for i in stride(from: nums.count - 1, to: violate, by: -1) {
                if nums[i] > nums[violate] {
                    _swap(&nums, i, violate)
                    break;
                }
            }
        }
        _reverse(&nums, startIdx: violate + 1, endIdx: nums.count - 1)
    }
    
//MARK: 题目28：Gas Station 加油站问题 [Medium]
    /// 原理: 我们首先要知道能走完整个环的前提是gas的总量要大于cost的总量，这样才会有起点的存在。假设开始设置起点start = 0,
    ///      并从这里出发，如果当前的gas值大于cost值，就可以继续前进，此时到下一个站点，剩余的gas加上当前的gas再减去cost，看是否大于0，若大于0，则继续前进。
    ///      当到达某一站点时，若这个值小于0了，则说明从起点到这个点中间的任何一个点都不能作为起点，则把起点设为下一个点，继续遍历。当遍历完整个环时，当前保存的起点即为所求.
    func canCompleteCircuit(_ gas: [Int], _ cost: [Int]) -> Int {
        var totoal = 0, sum = 0, start = 0
        for i in 0..<gas.count {
            totoal += gas[i] - cost[i]
            sum += gas[i] - cost[i]
            if sum < 0 {
                start = i + 1
                sum = 0
            }
        }
        if totoal < 0 {
            return -1
        }
        return start
    }
}


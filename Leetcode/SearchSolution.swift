//
//  SearchSolution.swift
//  Leetcode
//
//  Created by Jason on 2017/12/12.
//  Copyright © 2017年 Jason. All rights reserved.
//

import Foundation

class SearchSolution {
//MARK: 题目1：Search in Rotated Sorted Array(在可滚动的数组中查找值) [Hard]
    ///分析：这道题让在旋转数组中搜索一个给定值，若存在返回坐标，若不存在返回-1。我们还是考虑二分搜索法，但是这道题的难点在于我们不知道原数组在哪旋转了，我们还是用题目中给的例子来分析，对于数组[0 1 2 4 5 6 7] 共有下列七种旋转方法：
    //    0　　1　　2　　 4　　5　　6　　7
    //    7　　0　　1　　 2　　4　　5　　6
    //    6　　7　　0　　 1　　2　　4　　5
    //    5　　6　　7　　 0　　1　　2　　4
    //    4　　5　　6　　7　　0　　1　　2
    //    2　　4　　5　　6　　7　　0　　1
    //    1　　2　　4　　5　　6　　7　　0
    //    二分搜索法的关键在于获得了中间数后，判断下面要搜索左半段还是右半段，我们观察上面红色的数字都是升序的，由此我们可以观察出规律，如果中间的数小于最右边的数，则右半段是有序的，若中间数大于最右边数，则左半段是有序的，我们只要在有序的半段里用首尾两个数组来判断目标值是否在这一区域内，这样就可以确定保留哪半边了，代码如下：
    func search(_ nums: [Int], _ target: Int) -> Int {
        if nums.count == 0 { return -1 }
        var left = 0, right = nums.count - 1, mid = 0
        while (left <= right) {
            mid = (left + right) / 2
            if nums[mid] == target { return mid }
            else if nums[mid] < nums[right] { //说明右半部分有序的(升序)
                if nums[mid] < target && nums[right] >= target {
                    left = mid + 1
                } else {
                    right = mid - 1
                }
            } else {                        //说明左半部分有序的(升序)
                if nums[mid] > target && nums[left] <= target {
                    right = mid - 1
                } else {
                    left = mid + 1
                }
            }
        }
        return -1
    }
//MARK: 题目2：Search in Rotated Sorted ArrayII (如上题目，但是输入数组允许有重复数字) [Medium]
    /// 分析: 这道是之前那道 Search in Rotated Sorted Array 在旋转有序数组中搜索 的延伸，现在数组中允许出现重复数字，这个也会影响我们选择哪半边继续搜索，由于之前那道题不存在相同值，我们在比较中间值和最右值时就完全符合之前所说的规律：如果中间的数小于最右边的数，则右半段是有序的，若中间数大于最右边数，则左半段是有序的。而如果可以有重复值，就会出现来面两种情况，[3 1 1] 和 [1 1 3 1]，对于这两种情况中间值等于最右值时，目标值3既可以在左边又可以在右边，那怎么办么，对于这种情况其实处理非常简单，只要把最右值向左一位即可继续循环，如果还相同则继续移，直到移到不同值为止，然后其他部分还采用 Search in Rotated Sorted Array 在旋转有序数组中搜索 中的方法，可以得到代码如下：
    
    func searchII(_ nums: [Int], _ target: Int) -> Bool {
        //处理边界
        if nums.count == 0 { return false }
        var left = 0, right = nums.count - 1, mid = 0
        while left <= right {
            mid = (left + right) / 2
            if nums[mid] == target { return true }
            else if nums[mid] < nums[right] { //说明右半部分有序的(升序)
                if nums[mid] < target && nums[right] >= target {
                    left = mid + 1
                } else {
                    right = mid - 1
                }
            } else if nums[mid] > nums[right] { // //说明左半部分有序的(升序)
                if nums[mid] > target && nums[left] <= target {
                    right = mid - 1
                } else {
                    left = mid + 1
                }
            } else {
                right -= 1
            }
        }
        return false
    }
//MARK: 题目3：Median of Two Sorted Arrays [Hard]
    /// 分析：这道题让我们求两个有序数组的中位数，而且限制了时间复杂度为O(log (m+n))，看到这个时间复杂度，自然而然的想到了应该使用二分查找法来求解。但是这道题被定义为Hard也是有其原因的，难就难在要在两个未合并的有序数组之间使用二分法，这里我们需要定义一个函数来找到第K个元素，由于两个数组长度之和的奇偶不确定，因此需要分情况来讨论，对于奇数的情况，直接找到最中间的数即可，偶数的话需要求最中间两个数的平均值。下面重点来看如何实现找到第K个元素，首先我们需要让数组1的长度小于或等于数组2的长度，那么我们只需判断如果数组1的长度大于数组2的长度的话，交换两个数组即可，然后我们要判断小的数组是否为空，为空的话，直接在另一个数组找第K个即可。还有一种情况是当K = 1时，表示我们要找第一个元素，只要比较两个数组的第一个元素，返回较小的那个即可。
    func findMedianSortedArrays(_ nums1: [Int], _ nums2: [Int]) -> Double {
        func findKth(_ nums1: [Int], _ nums2: [Int], _ index: Int) -> Double {
            let m = nums1.count
            let n = nums2.count
            
            guard m <= n else {
                return findKth(nums2, nums1, index)
            }
            guard m != 0 else {
                return Double(nums2[index - 1])
            }
            guard index != 1 else {
                return Double(min(nums1[0], nums2[0]))
            }
            
            let i = min(index / 2, m)
            let j = min(index / 2, n)
            
            if nums1[i - 1] < nums2[j - 1] {
                return findKth(Array(nums1[i..<m]), nums2, index - i)
            } else {
                return findKth(nums1, Array(nums2[j..<n]), index - j)
            }
        }
        
        let m = nums1.count, n = nums2.count
        return (findKth(nums1, nums2, (m + n + 1) / 2) + findKth(nums1, nums2, (m + n + 2) / 2)) / 2
    }
    
}

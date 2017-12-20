//
//  main.swift
//  Leetcode
//
//  Created by Jason on 2017/12/11.
//  Copyright © 2017年 Jason. All rights reserved.
//

import Foundation

print("Hello, World!")
//////////////////// Array /////////////////////////
print("//////////////////// Array /////////////////////////")
let array = ArraySolution()
var nums = [1, 2, 2, 3, 5, 5, 6]
print("removeDuplicatsArray: cout = \(array.removeDuplicates(&nums)) and array:\(nums)")

nums = [1, 1, 1, 2, 2, 2, 3, 3, 3]
print("removeDuplicatsArray: cout = \(array.removeDuplicatesII(&nums)) and array:\(nums)")

print("findRadius: \(array.findRadius([1, 2, 3, 4], [1, 4]))")

print("array.numberOfBoomerangs: \(array.numberOfBoomerangs([[0, 0], [1, 0], [2, 0]]))")

print("array.islandPerimeter: \(array.islandPerimeter([[0,1,0,0],[1,1,1,0],[0,1,0,0],[1,1,0,0]]))")

print("array.majorityElement: \(array.majorityElement([-2147483648]))")

print("array.threeSum: \(array.threeSum([-1,0,1,2,-1,-4]))")

nums = [2, 1]
print("\(array.moveZeroes(&nums)) print:\(nums)")
nums = [1]
print("\(array.removeElement(&nums, 1)) print: \(nums)")

print("array.fourSum: \(array.fourSum([-3,-2,-1,0,0,1,2,3], 0))")

print("array.summaryRanges: \(array.summaryRanges([0, 1, 3, 4, 6, 8, 9]))")

print("array.shortestDistance = \(array.shortestDistance(["practice", "makes", "perfect", "coding", "makes"], word1: "practice", word2: "coding"))")

print("array.shortestDistanceIII = \(array.shortestDistanceIII(["practice", "makes", "perfect", "coding", "makes"], word1: "makes", word2: "makes"))")

print("array.maxSubArrayLen = \(array.maxSubArrayLen([1, -1, 5, -2, 3], k: 2))")

print("array.productExceptSelf = \(array.productExceptSelf([1, 2, 3, 4]))")

nums = [1,2]
print("array.rotate = \(array.rotate(&nums, 0)) nums=\(nums)")

var matrix = [[1,2,3,4],
              [5,6,7,8],
              [9,10,11,12],
              [13,14,15,16]]
print("array.rotateImage = \(array.rotate(&matrix)) image = \(matrix)")

matrix = [[1,2,3],
          [4,5,6],
          [7,8,9]]
print("array.spiralOrder = \(array.spiralOrder(matrix))")

print("array.generateMatrix = \(array.generateMatrix(3))")

//////////////////// Search /////////////////////////
print("//////////////////// Search /////////////////////////")
let search = SearchSolution()
print("search.search index: \(search.search([4,5,6,7,0,1,2,3], 6))")

print("search.search Bool: \(search.searchII([1, 1, 3, 1], 3))")

var nums1 = [2, 3, 6]
var nums2 = [1, 2, 3, 4, 5, 6]
nums1 = [1, 3]
nums2 = [2]
print("search.findMedianSortedArrays: \(search.findMedianSortedArrays(nums1, nums2))")

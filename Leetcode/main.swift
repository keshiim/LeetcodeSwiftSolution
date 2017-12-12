//
//  main.swift
//  Leetcode
//
//  Created by Jason on 2017/12/11.
//  Copyright © 2017年 Jason. All rights reserved.
//

import Foundation

print("Hello, World!")

let array = ArraySolution()
var nums = [1, 2, 2, 3, 5, 5, 6]
print("removeDuplicatsArray: cout = \(array.removeDuplicates(&nums)) and array:\(nums)")

nums = [1, 1, 1, 2, 2, 2, 3, 3, 3]
print("removeDuplicatsArray: cout = \(array.removeDuplicatesII(&nums)) and array:\(nums)")

print("array.search index: \(array.search([4,5,6,7,0,1,2,3], 6))")

print("array.search Bool: \(array.searchII([1, 1, 3, 1], 3))")

var nums1 = [2, 3, 6]
var nums2 = [1, 2, 3, 4, 5, 6]
nums1 = [1, 3]
nums2 = [2]
print("array.findMedianSortedArrays: \(array.findMedianSortedArrays(nums1, nums2))")

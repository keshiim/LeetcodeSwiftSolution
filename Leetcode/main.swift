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
let array = ArraySolution()
var nums = [1, 2, 2, 3, 5, 5, 6]
print("removeDuplicatsArray: cout = \(array.removeDuplicates(&nums)) and array:\(nums)")

nums = [1, 1, 1, 2, 2, 2, 3, 3, 3]
print("removeDuplicatsArray: cout = \(array.removeDuplicatesII(&nums)) and array:\(nums)")

print("findRadius: \(array.findRadius([1, 2, 3, 4], [1, 4]))")

print("array.numberOfBoomerangs: \(array.numberOfBoomerangs([[0, 0], [1, 0], [2, 0]]))")

print("array.islandPerimeter: \(array.islandPerimeter([[0,1,0,0],[1,1,1,0],[0,1,0,0],[1,1,0,0]]))")

print("array.majorityElement: \(array.majorityElement([-2147483648]))")

//////////////////// Search /////////////////////////
let search = SearchSolution()
print("search.search index: \(search.search([4,5,6,7,0,1,2,3], 6))")

print("search.search Bool: \(search.searchII([1, 1, 3, 1], 3))")

var nums1 = [2, 3, 6]
var nums2 = [1, 2, 3, 4, 5, 6]
nums1 = [1, 3]
nums2 = [2]
print("search.findMedianSortedArrays: \(search.findMedianSortedArrays(nums1, nums2))")

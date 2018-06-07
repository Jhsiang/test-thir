//
//  Sorting.swift
//  test-thir
//
//  Created by Jim Chuang on 2018/3/8.
//  Copyright © 2018年 nhr. All rights reserved.
//

import Foundation

func quickSorting(oriArray:Array<Int>) -> Array<Int>
{
    var qArray = oriArray
    guard qArray.count > 1 else {return qArray}
    let pivotSelect = qArray.count/2
    let pivot = qArray[pivotSelect]
    let pivotArray = [pivot]
    var lessArray = Array<Int>()
    var greaterArray = Array<Int>()
    let i = qArray.count-1
    for x in 0...i
    {
        if (x != pivotSelect) && (qArray[x] <= pivot)
        {
            lessArray.append(qArray[x])
        }
        if (x != pivotSelect) && (qArray[x] >= pivot)
        {
            greaterArray.append(qArray[x])
        }
    }

    return quickSorting(oriArray:lessArray) + pivotArray + quickSorting(oriArray:greaterArray)
}

func picker(a:Array<Array<Int>>,i1:Int,i2:Int) -> Array<Int>{
    guard i2 < a.count else {return a[i1]}
    return compare(oriArray: a[i1]) > compare(oriArray: a[i2]) ? picker(a:a, i1:i1, i2:i2+1) : picker(a:a, i1:i1+1, i2:i2+1)
}

func autoArrangement(oriArray:Array<Int>) -> Array<Array<Int>>{

    guard oriArray.count == 13 else {return ([[0],[0],[0]])}
    var calArray = oriArray

    //third
    var allset = combinations(source: calArray, takenBy: 5)
    var i = allset.count-1
    var thirdA:Array<Int> = allset[0]
    for x in 0...i{
        if compare(oriArray: allset[x]) >= compare(oriArray: thirdA){
            thirdA = allset[x]
        }
    }

    for y in 0...calArray.count-1{
        for x in 0...thirdA.count-1{
            if calArray[y] == thirdA[x]{
                calArray.remove(at: y)
            }
        }
        if calArray.count <= 8 {break}
    }

    //second
    allset = combinations(source: calArray, takenBy: 5)
    let i2 = allset.count-1
    var secondA = allset[0]
    for x in 0...i2{
        if compare(oriArray: allset[x]) >= compare(oriArray: secondA){
            secondA = allset[x]
        }
    }

    for y in 0...calArray.count-1{
        for x in 0...secondA.count-1{
            if calArray[y] == secondA[x]{
                calArray.remove(at: y)
            }
        }
        if calArray.count <= 3 {break}
    }

    //first
    allset = combinations(source: calArray, takenBy: 3)
    let i3 = allset.count-1
    var firstA = allset[0]
    for x in 0...i3{
        if compare(oriArray: allset[x]) >= compare(oriArray: firstA){
            firstA = allset[x]
        }
    }
    
    return [firstA,secondA,thirdA]
}

func combos<T>(elements: ArraySlice<T>, k: Int) -> [[T]] {
    if k == 0 {
        return [[]]
    }

    guard let first = elements.first else {
        return []
    }

    let head = [first]
    let subcombos = combos(elements: elements, k: k - 1)
    var ret = subcombos.map { head + $0 }
    ret += combos(elements: elements.dropFirst(), k: k)

    return ret
}

func combos2<T>(elements: Array<T>, k: Int) -> [[T]] {
    return combos(elements: ArraySlice(elements), k: k)
}

// Cn取m
func combinations<T>(source: [T], takenBy : Int) -> [[T]] {
    if(source.count == takenBy) {
        return [source]
    }

    if(source.isEmpty) {
        return []
    }

    if(takenBy == 0) {
        return []
    }

    if(takenBy == 1) {
        return source.map { [$0] }
    }

    var result : [[T]] = []

    let rest = Array(source.suffix(from: 1))
    let sub_combos = combinations(source: rest, takenBy: takenBy - 1)
    result += sub_combos.map { [source[0]] + $0 }
    result += combinations(source: rest, takenBy: takenBy)
    return result
}

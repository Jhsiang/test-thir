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

func quickSortingByNum(oriArr:Array<PKCard>) -> Array<PKCard>
{
    var qArray = oriArr
    guard qArray.count > 1 else {return qArray}
    let pivotSelect = qArray.count/2
    let pivot = qArray[pivotSelect]
    let pivotArray = [pivot]
    var lessArray = Array<PKCard>()
    var greaterArray = Array<PKCard>()
    for x in 0...qArray.count-1
    {
        if (x != pivotSelect) && (qArray[x].num <  pivot.num)
        {
            lessArray.append(qArray[x])
        }
        if (x != pivotSelect) && (qArray[x].num >= pivot.num)
        {
            greaterArray.append(qArray[x])
        }
    }

    return quickSortingByNum(oriArr:lessArray) + pivotArray + quickSortingByNum(oriArr:greaterArray)
}

func quickSortingByColor(oriArr:Array<PKCard>) -> Array<PKCard>
{
    var resultArr = quickSortingByNum(oriArr: oriArr)
    let oneArr = resultArr.filter{$0.color == 1}
    let twoArr = resultArr.filter{$0.color == 2}
    let thrArr = resultArr.filter{$0.color == 3}
    let fthArr = resultArr.filter{$0.color == 4}
    resultArr = oneArr + twoArr + thrArr + fthArr

    return resultArr
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

func autoArrangement(arr:Array<PKCard>) -> Array<Array<PKCard>>{

    guard arr.count == 13 else {return ([[PKCard()],[PKCard()],[PKCard()]])}
    var calArray = arr

    // Handle third set
    var allSet = combinations(source: calArray, takenBy: 5)
    var thirdA:Array<PKCard> = allSet[0]

    // Pick largest
    for everySet in allSet{
        if compare(oriArr: everySet).compare >= compare(oriArr: thirdA).compare{
            thirdA = everySet
        }
    }

    // Remove picked
    for removeCard in thirdA{
        calArray = calArray.filter{($0.color != removeCard.color || $0.num != removeCard.num)}
    }

    // Handle second set
    allSet = combinations(source: calArray, takenBy: 5)
    var secondA = allSet[0]

    // Pick largest
    for everySet in allSet{
        if compare(oriArr: everySet).compare >= compare(oriArr: secondA).compare{
            secondA = everySet
        }
    }

    // Remove picked
    for removeCard in secondA{
        calArray = calArray.filter{$0.color != removeCard.color || $0.num != removeCard.num}
    }

    // Handle first set
    allSet = combinations(source: calArray, takenBy: 3)
    var firstA = allSet[0]
    for everySet in allSet{
        if compare(oriArr: everySet).compare >= compare(oriArr: firstA).compare{
            firstA = everySet
        }
    }

    return [firstA,secondA,thirdA]
}


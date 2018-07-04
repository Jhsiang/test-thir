//
//  Compare.swift
//  test-thir
//
//  Created by Jim Chuang on 2018/3/8.
//  Copyright © 2018年 nhr. All rights reserved.
//

import Foundation

func compare(oriArr:Array<PKCard>) -> PKPower
{
    if oriArr.count != 5 && oriArr.count != 3 {
        return PKPower()
    }
    let result = PKPower()

    // Sorting large to small by Num
    let sortedArr = oriArr.sorted(by: {$0.num > $1.num})

    // Card power
    result.power = cardType(arr: sortedArr)

    // Card order
    var orderStr:String = ""

    // Same card count
    var countArr = Array(repeating: 0, count: 14)
    for i in sortedArr{
        countArr[i.num] += 1
    }
    let fth = countArr.filter{$0 == 4}.count
    let thr = countArr.filter{$0 == 3}.count
    let pair = countArr.filter{$0 == 2}.count
    let single = countArr.filter{$0 == 1}.count

    if single == 5 || (sortedArr.count == 3 && single == 3){
        for i in 0...sortedArr.count-1{
            orderStr += numToPkCardOrderStr(num: sortedArr[i].num)
        }
    }else{
        if fth == 1
        {
            let fthNum = countArr.index(of: 4)!
            let singleNum = countArr.index(of: 1)!
            orderStr = numToPkCardOrderStr(num: fthNum) + numToPkCardOrderStr(num: singleNum)
        }
        else if thr == 1 && pair == 1
        {
            let thrNum = countArr.index(of: 3)!
            let pairNum = countArr.index(of: 2)!
            orderStr = numToPkCardOrderStr(num: thrNum) + numToPkCardOrderStr(num: pairNum)
        }
        else if thr == 1
        {
            if sortedArr.count == 5{
                let thrNum = countArr.index(of: 3)!
                let singlePkArr = sortedArr.filter{$0.num != thrNum}
                let singleNumBig = singlePkArr[0].num
                let singleNumSmall = singlePkArr[1].num
                orderStr = numToPkCardOrderStr(num: thrNum) + numToPkCardOrderStr(num: singleNumBig) + numToPkCardOrderStr(num: singleNumSmall)
            }else{
                let thrNum = countArr.index(of: 3)!
                orderStr = numToPkCardOrderStr(num: thrNum)
            }
        }
        else if pair == 2
        {
            let singleNum = countArr.index(of: 1)!
            let pairPKarr = sortedArr.filter{$0.num != singleNum}
            let pairNumBig = pairPKarr[0].num
            let pairNumSmall = pairPKarr[1].num
            orderStr = numToPkCardOrderStr(num: pairNumBig) + numToPkCardOrderStr(num: pairNumSmall) + numToPkCardOrderStr(num: singleNum)
        }
        else if pair == 1
        {
            if sortedArr.count == 5{
            let pairNum = countArr.index(after: 2)
            let singlePKArr = sortedArr.filter{$0.num != pairNum}
            let singleNumBig = singlePKArr[0].num
            let singleNumMid = singlePKArr[1].num
            let singleNumSmall = singlePKArr[2].num
            orderStr = numToPkCardOrderStr(num: pairNum) + numToPkCardOrderStr(num: singleNumBig) + numToPkCardOrderStr(num: singleNumMid) + numToPkCardOrderStr(num: singleNumSmall)
            }else{
                let pairNum = countArr.index(of: 2)!
                let singleNum = countArr.index(of: 1)!
                orderStr = numToPkCardOrderStr(num: pairNum) + numToPkCardOrderStr(num: singleNum)
            }
        }
    }

    result.order = orderStr
    result.compare = result.power + result.order

    return result
}

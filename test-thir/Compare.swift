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

func compare2PkArr(a:Array<PKCard>,b:Array<PKCard>) -> Int {
//0.22
    var aPower = ""
    var bPower = ""
    var aNumArr = Array<Int>()
    var bNumArr = Array<Int>()
    var aCountArr = Array<Int>()
    var bCountArr = Array<Int>()

    (aPower,aNumArr,aCountArr) = txCardTypeAndOrder(arr: a)
    (bPower,bNumArr,bCountArr) = txCardTypeAndOrder(arr: b)

//2.5s
    if aPower != bPower{
        return aPower > bPower ? 0 : 1
    }

//end 3.0s
    if aNumArr == bNumArr{
        return 2
    }

    if aPower == TYPE_ORDER || aPower == TYPE_FLOWER || aPower == TYPE_HC || aPower == TYPE_ORDER_FLOWER{
        for i in 0...aNumArr.count - 1{
            if aNumArr[i] != bNumArr[i]{
                return aNumArr[i] > bNumArr[i] ? 0 : 1
            }
        }
        return 2
    }

    if aPower == TYPE_FOUR
    {
        let aFthNum = aCountArr.index(of: 4)!
        let bFthNum = bCountArr.index(of: 4)!

        if aFthNum != bFthNum{
            return aFthNum > bFthNum ? 0 : 1
        }else{
            let aSingleNum = aCountArr.index(of: 1)!
            let bSingleNum = bCountArr.index(of: 1)!
            if aSingleNum != bSingleNum{
                return aSingleNum > bSingleNum ? 0 : 1
            }else{
                return 2
            }
        }
    }
    else if aPower == TYPE_FH
    {
        let aThrNum = aCountArr.index(of: 3)!
        let bThrNum = bCountArr.index(of: 3)!
        if aThrNum != bThrNum{
            return aThrNum > bThrNum ? 0 : 1
        }else{
            let aPairNum = aCountArr.index(of: 2)!
            let bPairNum = bCountArr.index(of: 2)!
            if aPairNum != bPairNum{
                return aPairNum > bPairNum ? 0 : 1
            }else{
                return 2
            }
        }
    }
    else if aPower == TYPE_THREE
    {
        let aThrNum = aCountArr.index(of: 3)!
        let bThrNum = bCountArr.index(of: 3)!

        if aThrNum != bThrNum{
            return aThrNum > bThrNum ? 0 : 1
        }else{
            var aSingleArr = Array<Int>()
            var bSingleArr = Array<Int>()
            for i in aCountArr{
                if i == 1{
                    aSingleArr.append(i)
                }
            }
            for i in bCountArr{
                if i == 1{
                    bSingleArr.append(i)
                }
            }
            aSingleArr.sort()
            bSingleArr.sort()
            let aSingleBigNum = aSingleArr[1]
            let bSingleBigNum = bSingleArr[1]
            if aSingleBigNum != bSingleBigNum{
                return aSingleBigNum > bSingleBigNum ? 0 : 1
            }else{
                let aSingleSmallNum = aSingleArr[0]
                let bSingleSmallNum = bSingleArr[0]
                if aSingleSmallNum != bSingleSmallNum{
                    return aSingleSmallNum > bSingleSmallNum ? 0 : 1
                }else{
                    return 2
                }
            }
        }
    }
    else if aPower == TYPE_TP
    {
        let aBigPairNum = aCountArr.lastIndex(of: 2)!
        let bBigPairNum = bCountArr.lastIndex(of: 2)!
        if aBigPairNum != bBigPairNum{
            return aBigPairNum > bBigPairNum ? 0 : 1
        }else {
            let aSmallPairNum = aCountArr.index(of: 2)!
            let bSmallPairNum = bCountArr.index(of: 2)!
            if aSmallPairNum != bSmallPairNum{
                return aSmallPairNum > bSmallPairNum ? 0 : 1
            }else {
                let aSingleNum = aCountArr.index(of: 1)!
                let bSingleNum = bCountArr.index(of: 1)!
                if aSingleNum != bSingleNum{
                    return aSingleNum > bSingleNum ? 0 : 1
                }else {
                    return 2
                }
            }
        }
    }
    else if aPower == TYPE_OP
    {
        let aPairNum = aCountArr.firstIndex(of: 2)!
        let bPairNum = bCountArr.firstIndex(of: 2)!
        if aPairNum != bPairNum{
            return aPairNum > bPairNum ? 0 : 1
        }else{
            let aBigSinagleNum = aCountArr.lastIndex(of: 1)!
            let bBigSinagleNum = bCountArr.lastIndex(of: 1)!
            if aBigSinagleNum != bBigSinagleNum{
                return aBigSinagleNum > bBigSinagleNum ? 0 : 1
            }else{
                aCountArr[aBigSinagleNum] = 0
                bCountArr[bBigSinagleNum] = 0
                let aMidSinagleNum = aCountArr.lastIndex(of: 1)!
                let bMidSinagleNum = bCountArr.lastIndex(of: 1)!
                if aMidSinagleNum != bMidSinagleNum{
                    return aMidSinagleNum > bMidSinagleNum ? 0 : 1
                }else{
                    let aSmallSinagleNum = aCountArr.firstIndex(of: 1)!
                    let bSmallSinagleNum = bCountArr.firstIndex(of: 1)!
                    if aSmallSinagleNum != bSmallSinagleNum{
                        return aSmallSinagleNum > bSmallSinagleNum ? 0 : 1
                    }else{
                        return 2
                    }
                }
            }
        }
    }
    return 2
}

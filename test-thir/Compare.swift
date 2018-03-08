//
//  Compare.swift
//  test-thir
//
//  Created by Jim Chuang on 2018/3/8.
//  Copyright © 2018年 nhr. All rights reserved.
//

import Foundation

func compare(oriArray:Array<Int>) -> (Int,Int,Int,Int,Int,Int)
{
    var compareA = [0,0,0,0,0,0]
    guard oriArray.count == 3 || oriArray.count == 5 else {
        return (compareA[0],compareA[1],compareA[2],compareA[3],compareA[4],compareA[5])
    }

    if isFlower(oriArray: oriArray) && isOrder(oriArray: oriArray){
        compareA[0] = 9
        compareA[1] = subCompareNoP(oriArray: oriArray,index: 1)
        compareA[2] = subCompareNoP(oriArray: oriArray,index: 2)
        compareA[3] = subCompareNoP(oriArray: oriArray,index: 3)
        compareA[4] = subCompareNoP(oriArray: oriArray,index: 4)
        compareA[5] = subCompareNoP(oriArray: oriArray,index: 5)
    }else if isFour(oriArray: oriArray){
        compareA[0] = 8
        compareA[1] = subCompareHasP(oriArray: oriArray,index: 1)
        compareA[2] = subCompareHasP(oriArray: oriArray,index: 2)
    }else if isFH(oriArray: oriArray){
        compareA[0] = 7
        compareA[1] = subCompareHasP(oriArray: oriArray,index: 1)
        compareA[2] = subCompareHasP(oriArray: oriArray,index: 2)
    }else if isFlower(oriArray: oriArray){
        compareA[0] = 6
        compareA[1] = subCompareNoP(oriArray: oriArray,index: 1)
        compareA[2] = subCompareNoP(oriArray: oriArray,index: 2)
        compareA[3] = subCompareNoP(oriArray: oriArray,index: 3)
        compareA[4] = subCompareNoP(oriArray: oriArray,index: 4)
        compareA[5] = subCompareNoP(oriArray: oriArray,index: 5)
    }else if isOrder(oriArray: oriArray){
        compareA[0] = 5
        compareA[1] = subCompareNoP(oriArray: oriArray,index: 1)
        compareA[2] = subCompareNoP(oriArray: oriArray,index: 2)
        compareA[3] = subCompareNoP(oriArray: oriArray,index: 3)
        compareA[4] = subCompareNoP(oriArray: oriArray,index: 4)
        compareA[5] = subCompareNoP(oriArray: oriArray,index: 5)
    }else if isThree(oriArray: oriArray){
        compareA[0] = 4
        compareA[1] = subCompareHasP(oriArray: oriArray,index: 1)
        compareA[2] = subCompareHasP(oriArray: oriArray,index: 2)
        compareA[3] = subCompareHasP(oriArray: oriArray,index: 3)
    }else if isTP(oriArray: oriArray){
        compareA[0] = 3
        compareA[1] = subCompareHasP(oriArray: oriArray,index: 1)
        compareA[2] = subCompareHasP(oriArray: oriArray,index: 2)
        compareA[3] = subCompareHasP(oriArray: oriArray,index: 3)
    }else if isOP(oriArray: oriArray){
        compareA[0] = 2
        compareA[1] = subCompareHasP(oriArray: oriArray,index: 1)
        compareA[2] = subCompareHasP(oriArray: oriArray,index: 2)
        compareA[3] = subCompareHasP(oriArray: oriArray,index: 3)
        compareA[4] = subCompareHasP(oriArray: oriArray,index: 4)
    }else{
        compareA[0] = 1
        compareA[1] = subCompareNoP(oriArray: oriArray,index: 1)
        compareA[2] = subCompareNoP(oriArray: oriArray,index: 2)
        compareA[3] = subCompareNoP(oriArray: oriArray,index: 3)
        compareA[4] = subCompareNoP(oriArray: oriArray,index: 4)
        compareA[5] = subCompareNoP(oriArray: oriArray,index: 5)
    }
    return (compareA[0],compareA[1],compareA[2],compareA[3],compareA[4],compareA[5])
}

func subCompareNoP(oriArray:Array<Int>,index:Int) -> Int
{
    var setA = Array(repeatElement(0, count: 13))
    for x in 0...12{
        for y in 0...oriArray.count-1{
            if oriArray[y]%13 == x{
                setA[x] += 1
            }
        }
    }
    let selectChoice = 6 - index
    var choiceIndex = 0
    var result = 0
    for x in 0...12{
        if setA[x] == 1 {
            result = x + 1
            choiceIndex += 1
        }
        if choiceIndex == selectChoice{
            return result
        }
    }
    return result
}

func subCompareHasP(oriArray:Array<Int>,index:Int) -> Int
{
    var setA = Array(repeatElement(0, count: 13))
    for x in 0...12{
        for y in 0...oriArray.count-1{
            if oriArray[y]%13 == x{
                setA[x] += 1
            }
        }
    }
    var result = 0
    var fth = 0
    var thr = 0
    var par = 0
    var single = 0
    for x in 0...12{
        switch setA[x]{
        case 1:
            single += 1
        case 2:
            par += 1
        case 3:
            thr += 1
        case 4:
            fth += 1
        default:
            break
        }
    }

    if fth == 1{
        switch index{
        case 1:
            for x in 0...12{
                if setA[x] == 4 {return x+1}
            }
        case 2:
            for x in 0...12{
                if setA[x] == 1 {return x+1}
            }
        default:
            break
        }
    }else if thr==1 && par==1{
        switch index{
        case 1:
            for x in 0...12{
                if setA[x] == 3 {return x+1}
            }
        case 2:
            for x in 0...12{
                if setA[x] == 2 {return x+1}
            }
        default:
            break
        }
    }else if thr==1 && par==0{
        switch index{
        case 1:
            for x in 0...12{
                if setA[x] == 3 {return x+1}
            }
        case 2:
            for x in 0...12{
                if setA[x] == 1 {result = x+1}
            }
        case 3:
            for x in 0...12{
                if setA[x] == 1 {return x+1}
            }
        default:
            break
        }
        return result
    }else if par==2{
        switch index{
        case 1:
            for x in 0...12{
                if setA[x] == 2 {result = x+1}
            }
        case 2:
            for x in 0...12{
                if setA[x] == 2 {return x+1}
            }
        case 3:
            for x in 0...12{
                if setA[x] == 1 {return x+1}
            }
        default:
            break
        }
        return result
    }else if par==1{
        var pass = false
        switch index{
        case 1:
            for x in 0...12{
                if setA[x] == 2 {return x+1}
            }
        case 2:
            for x in 0...12{
                if setA[x] == 1 {result = x+1}
            }
        case 3:
            for x in 0...12{
                if setA[x] == 1 && pass == true {return x+1}
                if setA[x] == 1 {pass = true}
            }
        case 4:
            for x in 0...12{
                if setA[x] == 1 {return x+1}
            }
        default:
            break
        }
        return result
    }

    return 0
}

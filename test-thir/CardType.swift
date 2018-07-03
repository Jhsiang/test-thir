//
//  CardType.swift
//  test-thir
//
//  Created by Jim Chuang on 2018/3/8.
//  Copyright © 2018年 nhr. All rights reserved.
//

import Foundation

func isFlower(oriArray:Array<Int>) -> Bool
{
    guard oriArray.count == 5 else {return false}
    for x in 0...3
    {
        if oriArray[x]/13 != oriArray[x+1]/13 {return false}
    }
    return true
}

func isFour(oriArray:Array<Int>) -> Bool
{
    guard oriArray.count == 5 || oriArray.count == 3 else {return false}
    var coutA = Array(repeatElement(0, count: 13))
    let i = oriArray.count - 1
    for x in 0...12{
        for y in 0...i{
            if oriArray[y]%13 == x{
                coutA[x] += 1
            }
        }
    }
    var four = 0
    for x in 0...12{
        if coutA[x] == 4 {four+=1}
    }
    return four==1
}

func isThree(oriArray:Array<Int>) -> Bool
{
    guard oriArray.count == 5 || oriArray.count == 3 else {return false}
    var coutA = Array(repeatElement(0, count: 13))
    let i = oriArray.count - 1
    for x in 0...12{
        for y in 0...i{
            if oriArray[y]%13 == x{
                coutA[x] += 1
            }
        }
    }
    var thr = 0
    for x in 0...12{
        if coutA[x] == 3 {thr+=1}
    }
    return thr==1
}

func isOrder(oriArray:Array<Int>) -> Bool
{
    guard oriArray.count == 5 else {return false}
    var orderA = Array<Int>()
    for x in 0...4
    {
        orderA.append(oriArray[x]%13)
    }
    orderA = quickSorting(oriArray: orderA)
    for x in 0...3
    {
        guard (orderA[x]+1 == orderA[x+1]) || (orderA[x] == 0 && orderA[x]+9 == orderA[x+1]) else {return false}
    }
    return true
}

func isFH(oriArray:Array<Int>) -> Bool{
    guard oriArray.count == 5 else {return false}
    var coutA = Array(repeatElement(0, count: 13))
    let i = oriArray.count - 1
    for x in 0...12{
        for y in 0...i{
            if oriArray[y]%13 == x{
                coutA[x] += 1
            }
        }
    }
    var par = 0
    var thr = 0
    for x in 0...12{
        if coutA[x] == 2 {par+=1}
        if coutA[x] == 3 {thr+=1}
    }
    return par==1 && thr==1
}

func isTP(oriArray:Array<Int>) -> Bool
{
    guard oriArray.count == 5 else {return false}
    var coutA = Array(repeatElement(0, count: 13))
    let i = oriArray.count - 1
    for x in 0...12{
        for y in 0...i{
            if oriArray[y]%13 == x{
                coutA[x] += 1
            }
        }
    }
    var par = 0
    for x in 0...12{
        if coutA[x] == 2 {par+=1}
    }
    return par==2
}

func isOP(oriArray:Array<Int>) -> Bool
{
    guard oriArray.count == 5 || oriArray.count == 3 else {return false}
    var coutA = Array(repeatElement(0, count: 13))
    let i = oriArray.count - 1
    for x in 0...12{
        for y in 0...i{
            if oriArray[y]%13 == x{
                coutA[x] += 1
            }
        }
    }
    var par = 0
    for x in 0...12{
        if coutA[x] == 2 {par+=1}
    }
    return par==1
}

func isHC(arr:Array<Int>) -> Bool
{
    switch true {
    case isOP(oriArray: arr):
        break
    case isTP(oriArray: arr):
        break
    case isThree(oriArray: arr):
        break
    case isOrder(oriArray: arr):
        break
    case isFlower(oriArray: arr):
        break
    case isFH(oriArray: arr):
        break
    case isFour(oriArray: arr):
        break
    default:
        return true
    }
    return false
}


func cardType(arr:Array<PKCard>) -> String
{
    guard arr.count == 5 else {return "0"}

    var numCountArr = Array(repeating: 0, count: 14)
    for i in 0...arr.count-1{
        let num = arr[i].num
        numCountArr[num] += 1
    }
    let single = numCountArr.filter{$0 == 1}.count
    let pair = numCountArr.filter{$0 == 2}.count
    let thr = numCountArr.filter{$0 == 3}.count
    let four = numCountArr.filter{$0 == 4}.count

    if single == 5{

        var isFlower3 = true
        var isOrder3 = true
        var orderArr = Array<Int>()

        // Order
        for i in 0...arr.count-1{
            orderArr.append(arr[i].num)
        }
        orderArr = quickSorting(oriArray: orderArr)
        for i in 0...orderArr.count - 2{
            if orderArr[i]+1 == orderArr[i+1] || (orderArr[i] == 1 && orderArr[i+1] == 10){
            }else{
                isOrder3 = false
            }
        }

        // Flower
        for i in 1...arr.count-1 {
            if arr[0].color != arr[i].color{
                isFlower3 = false
            }
        }
        if isFlower3 && isOrder3{
            return TYPE_ORDER_FLOWER
        }else if isFlower3{
            return TYPE_FLOWER
        }else if isOrder3{
            return TYPE_ORDER
        }
    }

    if four == 1{
        return TYPE_FOUR
    }else if thr == 1 && pair == 1{
        return TYPE_FH
    }else if thr == 1{
        return TYPE_THREE
    }else if pair == 2{
        return TYPE_TP
    }else if pair == 1{
        return TYPE_OP
    }

    return TYPE_HC
}



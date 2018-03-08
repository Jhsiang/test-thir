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



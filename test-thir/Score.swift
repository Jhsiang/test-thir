//
//  Score.swift
//  test-thir
//
//  Created by Jim Chuang on 2018/3/8.
//  Copyright © 2018年 nhr. All rights reserved.
//

import Foundation

func calResult(oriArray:Array<Any>) -> Array<Int>{

    guard oriArray.count == 4 else {return [0,0,0,0]}
    var resultA = [0,0,0,0]
    let shot = 10

    for x in 0...3{
        for y in 0...3{
            let a = oriArray[x] as! [Array<PKCard>]
            let b = oriArray[y] as! [Array<PKCard>]
            if x != y{
                for z in 0...2{
                    var addValue = 0
                    switch z{
                    case 0:
                        addValue = cardType(arr: a[0]) == TYPE_THREE ? 3 : 0
                    case 1:
                        addValue = cardType(arr: a[1]) == TYPE_FOUR ? 4 : 0
                        addValue = cardType(arr: a[1]) == TYPE_ORDER_FLOWER ? 5 : 0
                    case 2:
                        addValue = cardType(arr: a[2]) == TYPE_FOUR ? 4 : 0
                        addValue = cardType(arr: a[2]) == TYPE_ORDER_FLOWER ? 5 : 0
                    default:
                        break
                    }
                    // 只計算贏的部份
                    resultA[x] += compare(oriArr: a[z]).compare > compare(oriArr: b[z]).compare ? 1 + addValue : 0
                    resultA[y] -= compare(oriArr: a[z]).compare > compare(oriArr: b[z]).compare ? (1 + addValue) : 0
                }
                resultA[x] += isShot(a: a, b: b) ? (shot-3) : 0
                resultA[y] -= isShot(a: a, b: b) ? (shot-3) : 0
            }
        }
    }

    return resultA
}

func isShot(a:Array<Array<PKCard>>,b:Array<Array<PKCard>>) -> Bool{
    guard a.count == 3 && b.count == 3 else {return false}

    var count = 0
    for x in 0...2{
        count = compare(oriArr: a[x]).compare > compare(oriArr: b[x]).compare ? count + 1 : count
    }
    return count == 3
}

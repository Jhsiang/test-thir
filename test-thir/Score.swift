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
            let a = oriArray[x] as! [Array<Int>]
            let b = oriArray[y] as! [Array<Int>]
            if x != y{
                for z in 0...2{
                    let addValue = (z == 0) ? isThree(oriArray: a[z]) ? 3 : 0 : isFour(oriArray: a[z]) ? 4 : (isFlower(oriArray: a[z]) && isOrder(oriArray: a[z])) ? 5 : 0
                    resultA[x] += compare(oriArray: a[z]) > compare(oriArray: b[z]) ? 1 + addValue : 0
                    resultA[y] -= compare(oriArray: a[z]) > compare(oriArray: b[z]) ? (1 + addValue) : 0
                }
                resultA[x] += isShot(a: a, b: b) ? (shot-3) : 0
                resultA[y] -= isShot(a: a, b: b) ? (shot-3) : 0
            }
        }
    }

    return resultA
}

func isShot(a:Array<Array<Int>>,b:Array<Array<Int>>) -> Bool{
    guard a.count == 3 && b.count == 3 else {return false}

    var count = 0
    for x in 0...2{
        count = compare(oriArray: a[x]) > compare(oriArray: b[x]) ? count + 1 : count
    }
    return count == 3
}

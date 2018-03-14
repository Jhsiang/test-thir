//
//  CardHandle.swift
//  test-thir
//
//  Created by Jim Chuang on 2018/3/8.
//  Copyright © 2018年 nhr. All rights reserved.
//

import Foundation

func wash(pkA:Array<Int>) -> Array<Int>
{
    //UserDefaults.standard.removeObject(forKey: "SaveCard")

    var washA = pkA
    if washA.count != 52
    {
        if UserDefaults.standard.array(forKey: "SaveCard") != nil && UserDefaults.standard.array(forKey: "SaveCard")?.count == 52
        {
            washA = UserDefaults.standard.array(forKey: "SaveCard") as! [Int]
        }
        else
        {
            for x in 0...51
            {
                washA.append(x)
            }
            UserDefaults.standard.set(washA, forKey: "SaveCard")
        }
    }
    for _ in 0...3
    {
        let rand = Int(arc4random_uniform(45) + 3) //3~47
        let a1 = Array(washA[0...rand])
        let a2 = Array(washA[rand+1...washA.count-1])
        washA = a2 + a1
    }

    for _ in 0...3
    {
        let rand = Int(arc4random_uniform(8) + 22) // 22~29
        var a1 = Array(washA[0...rand])
        var a2 = Array(washA[rand+1...washA.count-1])
        var sum = Array<Int>()
        while sum.count < 52
        {
            let r1Uint32 = UInt32(a1.count)
            let r2Uint32 = UInt32(a2.count)
            let rand1 = Int(arc4random_uniform(r1Uint32))
            let rand2 = Int(arc4random_uniform(r2Uint32))
            if a1.count != 0
            {
                sum += Array(a1[0...rand1])
                a1.removeFirst(rand1+1)
            }
            if a2.count != 0
            {
                sum += Array(a2[0...rand2])
                a2.removeFirst(rand2+1)
            }
        }
        //print("sum = \(sum) sum.count = \(sum.count)")
        if sum.count > 52
        {
            print("fail")
        }
        else
        {
            washA = sum
        }
    }
    for _ in 0...3
    {
        let rand = Int(arc4random_uniform(45) + 3) //3~47
        let a1 = Array(washA[0...rand])
        let a2 = Array(washA[rand+1...washA.count-1])
        washA = a2 + a1
    }
    UserDefaults.standard.set(washA, forKey: "SaveCard")

    return washA
}

func deal(pk:Array<Int>) -> (Array<Int>,Array<Int>,Array<Int>,Array<Int>)
{
    var dealPK = pk
    if dealPK.count != 52 {dealPK = wash(pkA: dealPK)}

    var one = Array<Int>()
    var two = Array<Int>()
    var three = Array<Int>()
    var four = Array<Int>()
    for x in 0...pk.count-1
    {
        switch x % 4
        {
        case 0:
            one.append(pk[x])
        case 1:
            two.append(pk[x])
        case 2:
            three.append(pk[x])
        case 3:
            four.append(pk[x])
        default:
            print("switch fail")
        }
    }

    return (one,two,three,four)
}

func deleteArrEle(array:Array<Int>,element: Int) -> Array<Int> {
    // 刪除指定元素
    return array.filter() { $0 != element }
}

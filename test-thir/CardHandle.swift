//
//  CardHandle.swift
//  test-thir
//
//  Created by Jim Chuang on 2018/3/8.
//  Copyright © 2018年 nhr. All rights reserved.
//

import Foundation

func TXdeal(pkArr:Array<PKCard>) -> (Array<PKCard>,Array<PKCard>)
{
    var one = Array<PKCard>()
    var two = Array<PKCard>()
    

    return (one,two)
}

func deal(pkArr:Array<PKCard>) -> (Array<PKCard>,Array<PKCard>,Array<PKCard>,Array<PKCard>)
{
    var dealArr = pkArr
    if dealArr.count != 52{
        dealArr = pkReset()
        dealArr = wash(arr: dealArr)
    }
    var one = Array<PKCard>()
    var two = Array<PKCard>()
    var three = Array<PKCard>()
    var four = Array<PKCard>()
    for i in 0...dealArr.count-1{
        switch i % 4
        {
        case 0:
            one.append(dealArr[i])
        case 1:
            two.append(dealArr[i])
        case 2:
            three.append(dealArr[i])
        case 3:
            four.append(dealArr[i])
        default:
            DLog(message: "switch fail")
        }
    }
    return (one,two,three,four)
}

func pkReset() -> Array<PKCard>
{
    var result = Array<PKCard>()
    for color in 1...4{
        for num in 1...13{
            let myPK = PKCard()
            myPK.color = color
            myPK.num = num
            result.append(myPK)
        }
    }
    return result
}

func wash(arr:Array<PKCard>) -> Array<PKCard>
{
    var washArr = arr
    if washArr.count != 52{
        washArr = pkReset()
    }

    for _ in 0...3{

        do{
            let a1 = Array(washArr[0...11])
            let a2 = Array(washArr[12...40])
            let a3 = Array(washArr[41...51])
            washArr = a2 + a1 + a3
        }

        do{
            let rand = Int(arc4random_uniform(45) + 3) //3~47
            let a1 = Array(washArr[0...rand])
            let a2 = Array(washArr[rand+1...washArr.count-1])
            washArr = a2 + a1
        }

        do{
            let rand = Int(arc4random_uniform(5) + 24) // 24~28
            var a1 = Array(washArr[0...rand])
            var a2 = Array(washArr[rand+1...washArr.count-1])
            var sum = Array<PKCard>()
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

            if sum.count > 52{
                print("fail")
            }else{
                washArr = sum
            }
        }

        do{
            let a1 = Array(washArr[0...11])
            let a2 = Array(washArr[12...40])
            let a3 = Array(washArr[41...51])
            washArr = a2 + a1 + a3
        }

        do{
            let rand = Int(arc4random_uniform(45) + 3) //3~47
            let a1 = Array(washArr[0...rand])
            let a2 = Array(washArr[rand+1...washArr.count-1])
            washArr = a2 + a1
        }
    }

    return washArr
}

func deleteArrEle(array:Array<Int>,element: Int) -> Array<Int> {
    // 刪除指定元素
    return array.filter() { $0 != element }
}

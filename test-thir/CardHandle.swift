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

func washAnyNum(arr:Array<PKCard>) -> Array<PKCard>{
    var washArr = arr
    guard washArr.count > 1 else{
        return washArr
    }

    do{
        var newCard = Array<PKCard>()
        for i in stride(from: washArr.count - 1, through: 0, by: -1){
            let myRand = Int(arc4random_uniform(UInt32(i)))
            newCard.append(washArr[myRand])
            washArr.remove(at: myRand)
        }
        washArr = newCard
    }
    return washArr
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
            var newCard = Array<PKCard>()
            let a1 = Array(washArr[0...25])
            let a2 = Array(washArr[26...51])
            for i in 0...25{
                newCard.append(a1[i])
                newCard.append(a2[i])
            }
            if newCard.count == 52{
                washArr = newCard
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

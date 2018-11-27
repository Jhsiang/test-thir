//
//  CardType.swift
//  test-thir
//
//  Created by Jim Chuang on 2018/3/8.
//  Copyright © 2018年 nhr. All rights reserved.
//

import Foundation

func cardType(arr:Array<PKCard>) -> String
{//0
    //switch end 2.5s
    if arr.count != 5 && arr.count != 3{
        return "0"
    }

    var single = 0
    var pair = 0
    var thr = 0
    var four = 0

    var numCountArr = Array(repeating: 0, count: 14)
    for i in 0...arr.count-1{
        let num = arr[i].num
        numCountArr[num] += 1
    }
// 0.5s
    for i in numCountArr{
        switch i{
        case 1:
            single += 1
        case 2:
            pair += 1
        case 3:
            thr += 1
        case 4:
            four += 1
        default:
            break
        }
    }
//1.5s -1.0
    if single == 5{
//1.65 -0.15
        var isFlower = true
        var isOrder = false
        var orderArr = Array<Int>()
//1.75s -0.1
        // Order
        for i in 0...arr.count-1{
            orderArr.append(arr[i].num)
        }
//2.0s -0.25
        orderArr.sort(by: <)
        let range = orderArr.last! - orderArr.first!
//2.3s -0.3
        if range == 4{
            isOrder = true
        }else if range == 12{
            if orderArr[1] == 10 && orderArr[2] == 11 && orderArr[3] == 12{
                isOrder = true
            }
        }

        // Flower
        for i in arr{
            if i.color != arr[0].color{
                isFlower = false
                break
            }
        }

        if isFlower && isOrder{
            return TYPE_ORDER_FLOWER
        }else if isFlower{
            return TYPE_FLOWER
        }else if isOrder{
            return TYPE_ORDER
        }else{
            return TYPE_HC
        }
    }
    if four == 1{
        return TYPE_FOUR
    }
    if thr == 1 && pair == 1{
        return TYPE_FH
    }
    if thr == 1{
        return TYPE_THREE
    }
    if pair == 2{
        return TYPE_TP
    }
    if pair == 1{
        return TYPE_OP
    }

    return TYPE_HC
}


func txCardTypeAndOrder(arr:Array<PKCard>) -> (String,Array<Int>,Array<Int>){

    var orderArr = Array<Int>()

    var single = 0
    var pair = 0
    var thr = 0
    var four = 0

    var numCountArr = Array(repeating: 0, count: 14)
    for i in arr{
        numCountArr[i.num] += 1
        orderArr.append(i.num)
    }

    orderArr.sort(by: >)

    for i in numCountArr{
        switch i{
        case 1:
            single += 1
        case 2:
            pair += 1
        case 3:
            thr += 1
        case 4:
            four += 1
        default:
            break
        }
    }

    if single == 5{

        var isFlower = true
        var isOrder = false

        let range = orderArr.first! - orderArr.last!

        if range == 4{
            isOrder = true
        }else if range == 12{
            if orderArr[1] == 12 && orderArr[2] == 11 && orderArr[3] == 10{
                isOrder = true
            }
        }

        // Flower
        for i in arr{
            if i.color != arr[0].color{
                isFlower = false
                break
            }
        }

        if isFlower && isOrder{
            return (TYPE_ORDER_FLOWER,orderArr,numCountArr)
        }else if isFlower{
            return (TYPE_FLOWER,orderArr,numCountArr)
        }else if isOrder{
            return (TYPE_ORDER,orderArr,numCountArr)
        }else{
            return (TYPE_HC,orderArr,numCountArr)
        }
    }
    else if four == 1{
        return (TYPE_FOUR,orderArr,numCountArr)
    }
    else if thr == 1 && pair == 1{
        return (TYPE_FH,orderArr,numCountArr)
    }
    else if thr == 1{
        return (TYPE_THREE,orderArr,numCountArr)
    }
    else if pair == 2{
        return (TYPE_TP,orderArr,numCountArr)
    }
    else if pair == 1{
        return (TYPE_OP,orderArr,numCountArr)
    }
    else{
        return (TYPE_HC,orderArr,numCountArr)
    }
}

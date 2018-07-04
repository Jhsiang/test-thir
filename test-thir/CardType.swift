//
//  CardType.swift
//  test-thir
//
//  Created by Jim Chuang on 2018/3/8.
//  Copyright © 2018年 nhr. All rights reserved.
//

import Foundation

func cardType(arr:Array<PKCard>) -> String
{
    if arr.count != 5 && arr.count != 3{
        return "0"
    }

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

        var isFlower = true
        var isOrder = true
        var orderArr = Array<Int>()

        // Order
        for i in 0...arr.count-1{
            orderArr.append(arr[i].num)
        }
        orderArr = quickSorting(oriArray: orderArr)
        for i in 0...orderArr.count - 2{
            if orderArr[i]+1 == orderArr[i+1] || (orderArr[i] == 1 && orderArr[i+1] == 10){
            }else{
                isOrder = false
            }
        }

        // Flower
        for i in 1...arr.count-1 {
            if arr[0].color != arr[i].color{
                isFlower = false
            }
        }
        if isFlower && isOrder{
            return TYPE_ORDER_FLOWER
        }else if isFlower{
            return TYPE_FLOWER
        }else if isOrder{
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



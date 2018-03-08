//
//  Conversion.swift
//  test-thir
//
//  Created by Jim Chuang on 2018/3/8.
//  Copyright © 2018年 nhr. All rights reserved.
//

import Foundation

func numberToString(oriArray:Array<Int>) -> Array<String>
{
    var strArray = Array<String>()
    for x in 0...oriArray.count-1
    {
        var first = String()
        var second = String()
        switch (oriArray[x])/13
        {
        case 0:
            first = "♠"
        case 1:
            first = "♥"
        case 2:
            first = "♦"
        case 3:
            first = "♣"
        default:
            print("fail")
        }

        switch (oriArray[x])%13+1
        {
        case 13:
            second = "K"
        case 12:
            second = "Q"
        case 11:
            second = "J"
        default:
            second = String(oriArray[x]%13+1)
        }

        strArray.append(first+second)
    }
    return strArray
}

func numberToString2(number:Int) -> String
{
    var str = ""

    var first = String()
    var second = String()
    switch number/13
    {
    case 0:
        first = "♠"
    case 1:
        first = "♥"
    case 2:
        first = "♦"
    case 3:
        first = "♣"
    default:
        print("fail")
    }

    switch (number)%13+1
    {
    case 13:
        second = "K"
    case 12:
        second = "Q"
    case 11:
        second = "J"
    default:
        second = String(number%13+1)
    }

    str = first + second

    return str
}

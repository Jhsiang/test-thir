//
//  Conversion.swift
//  test-thir
//
//  Created by Jim Chuang on 2018/3/8.
//  Copyright © 2018年 nhr. All rights reserved.
//

import Foundation

func numToPkCardOrderStr(num:Int) -> String {

    switch num{
    case 1...9:
        return String(num)
    case 10:
        return "a"
    case 11:
        return "b"
    case 12:
        return "c"
    case 13:
        return "d"
    default:
        return "0"
    }

}

func pkCardArrToShowStr(oriArr:Array<PKCard>) -> Array<String>
{
    var strArr = Array<String>()
    for x in oriArr{
        var first = String()
        var second = String()
        switch x.color{
        case 1:
            first = SHOW_LABEL_SPADE
        case 2:
            first = SHOW_LABEL_HEART
        case 3:
            first = SHOW_LABEL_DIAMOND
        case 4:
            first = SHOW_LABEL_CLUB
        default:
            print("fail")
        }
        switch x.num{
        case 1...10:
            second = String(x.num)
        case 11:
            second = "J"
        case 12:
            second = "Q"
        case 13:
            second = "K"
        default:
            second = "fail"
        }
        strArr.append(first+second)
    }

    return strArr
}

func pkCardToShowStr(card:PKCard) -> String
{
    var str = ""

    var first = String()
    var second = String()
    switch card.color{
    case 1:
        first = SHOW_LABEL_SPADE
    case 2:
        first = SHOW_LABEL_HEART
    case 3:
        first = SHOW_LABEL_DIAMOND
    case 4:
        first = SHOW_LABEL_CLUB
    default:
        print("fail")
    }
    switch card.num{
    case 1...10:
        second = String(card.num)
    case 11:
        second = "J"
    case 12:
        second = "Q"
    case 13:
        second = "K"
    default:
        second = "fail"
    }
    str = first + second
    return str
}



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
            first = "❤"
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
        first = "❤"
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

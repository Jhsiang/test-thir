//
//  PKPowerClass.swift
//  test-thir
//
//  Created by Jim Chuang on 2018/6/28.
//  Copyright © 2018年 nhr. All rights reserved.
//

import Foundation

class PKPower{
    var power:String = "0" //1~9
    var order:String = ""
    var compare:String = ""
}

class PKCard/*: NSObject, NSCoding*/{

    var color:Int = 0 //1~4
    var num:Int = 0 //1~13
/*
    func encode(with aCoder: NSCoder) {
        aCoder.encode(color, forKey: "color")
        aCoder.encode(num, forKey: "num")
    }

    init(initColor: Int = 0, initNum: Int = 0) {
        self.color = initColor
        self.num = initNum
    }

    required convenience init(coder aDecoder: NSCoder) {
        let myColor = aDecoder.decodeInteger(forKey: "color")
        let myNum = aDecoder.decodeInteger(forKey: "num")
        self.init(initColor: myColor, initNum: myNum)
    }
*/
}

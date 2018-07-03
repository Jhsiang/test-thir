//
//  Definition.swift
//  test-thir
//
//  Created by Jim Chuang on 2018/6/29.
//  Copyright © 2018年 nhr. All rights reserved.
//

import Foundation

func DLog<T> (message: T, fileName: String = #file, funcName: String = #function, lineNum: Int = #line) {

    #if DEBUG

    let file = (fileName as NSString).lastPathComponent

    print("-\(file) \(funcName)-[\(lineNum)]: \(message)")

    #endif

}



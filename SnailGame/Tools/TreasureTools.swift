//
//  TreasureTools.swift
//  SnailGame
//
//  Created by Edison on 2019/11/18.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

/// 计算a加b
func calculateAJiaB(a:String,b:String) -> String {
    let num1 = NSDecimalNumber.init(string: a)
    let num2 = NSDecimalNumber.init(string: b)
    let resultNum = num1.adding(num2)
    return resultNum.stringValue
}

/// 计算a减b
func calculateAJianB(a:String,b:String) -> String {
    let num1 = NSDecimalNumber.init(string: a)
    let num2 = NSDecimalNumber.init(string: b)
    let resultNum = num1.subtracting(num2)
    return resultNum.stringValue
}

/// 计算a乘以b
func calculateAChengyiB(a:String,b:String) -> String {
    let num1 = NSDecimalNumber.init(string: a)
    let num2 = NSDecimalNumber.init(string: b)
    let resultNum = num1.multiplying(by: num2)
    return resultNum.stringValue
}

/// 计算a除以b
func calculateAChuyiB(a:String,b:String) -> String {
    let num1 = NSDecimalNumber.init(string: a)
    let num2 = NSDecimalNumber.init(string: b)
    let resultNum = num1.dividing(by: num2)
    return resultNum.stringValue
}

/// 计算a大于b
func calculateADayuB(a:String,b:String) -> Bool {
    let num1 = NSDecimalNumber.init(string: a)
    let num2 = NSDecimalNumber.init(string: b)
    let result = num1.compare(num2)
    if result == .orderedDescending {
        return true
    }
    return false
}

/// 保留小数不四舍五入
func KeepSomeDecimal(num:String,decimal:Int) -> String {
    let formatter = NumberFormatter.init()
    formatter.roundingMode = .floor
    formatter.maximumFractionDigits = decimal
    let number = formatter.number(from: num)
    return formatter.string(from: number!)!
}



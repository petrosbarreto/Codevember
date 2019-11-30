//
//  Key.swift
//  Polinomial
//
//  Created by Renan Germano on 30/11/19.
//  Copyright © 2019 Renan Germano. All rights reserved.
//

import Foundation

enum Key: String {
    case _0 = "0"
    case _1 = "1"
    case _2 = "2"
    case _3 = "3"
    case _4 = "4"
    case _5 = "5"
    case _6 = "6"
    case _7 = "7"
    case _8 = "8"
    case _9 = "9"
    
    case comma = ","
    case dot = "."
    
    case sum = "+"
    case sub = "-"
    case mult = "*"
    case div = "/"
    
    case x = "x"
    case xpow2 = "x^2"
    case xpow3 = "x^3"
    case xpown = "x^n"
    
    case undo = "undo"
    case leftParenthesis = "("
    case rightParenthesis = ")"
    case equals = "="
    case pow = "pow"
    case finish = "finish"
    case enter = "enter"
    
    var unknown: String? {
        let components = rawValue.components(separatedBy: "^")
        return components.count == 2 ? components.first : nil
    }
    
    var degree: String? {
        let components = rawValue.components(separatedBy: "^")
        return components.count == 2 ? components.last : nil
    }
    
    var isControlKey: Bool {
        return self == .undo || self == .finish || self == .enter || self == .pow
    }
    
    var writableValue: String {
        if self == .pow { return "^"}
        if self == .sum || self == .sub || self == .mult || self == .div || self == .equals { return " \(rawValue) "}
        return rawValue
    }

}

//
//  Int.swift
//  
//
//  Created by user on 26.04.2024.
//

import Foundation

extension Int: DecimalConvertible {
    public static func convertFrom(decimal: Decimal) -> Int {
        return NSDecimalNumber(decimal: decimal).intValue
    }
}

public extension Int {
     func toString() -> String {
        return String(self)
    }
}

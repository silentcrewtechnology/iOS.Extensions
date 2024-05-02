//
//  File.swift
//  
//
//  Created by user on 26.04.2024.
//

import Foundation

extension Int: DecimalConvertible {
    static func convertFrom(decimal: Decimal) -> Int {
        return NSDecimalNumber(decimal: decimal).intValue
    }
    
    func toString() -> String {
        return String(self)
    }
}

import Foundation

protocol DecimalConvertible {
    static func convertFrom(decimal: Decimal) -> Self
}

extension Decimal {
    
    func rounded(scale: Int, roundingMode: NSDecimalNumber.RoundingMode) -> Decimal {
        var result: Decimal = 0
        var original = self
        NSDecimalRound(&result, &original, scale, roundingMode)
        return result
    }

    func map<T: DecimalConvertible>() -> T {
        return T.convertFrom(decimal: self)
    }
    
    var intValue: Int {
       return NSDecimalNumber(decimal: self).intValue
    }
    
    var doubleValue: Double {
       return NSDecimalNumber(decimal: self).doubleValue
    }
    
    var stringValue: String {
       return NSDecimalNumber(decimal: self).stringValue
    }
}

extension Decimal: LosslessStringConvertible {
    public init?(_ description: String) {
        guard let decimal = Decimal(string: description) else {
            return nil
        }
        self = decimal
    }
}

import Foundation

public protocol DecimalConvertible {
    static func convertFrom(decimal: Decimal) -> Self
}

public extension Decimal {
    
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

extension Decimal {
    
    /// Строковое представление целой суммы / суммы с 2-мя знаками после запятой
    var formattedAmount: String {
        let formatter: NumberFormatter = self.rounded(scale: 0, roundingMode: .plain) == self
        ? .integerFormatter
        : .fractionSumFormatter
        return formatter.string(from: self as NSDecimalNumber) ?? "\(self)"
    }
    
    /// Строковое представление числа с 2-мя знаками после запятой
    var formattedFractionAmount: String {
        return NumberFormatter.fractionSumFormatter.string(from: self as NSDecimalNumber) ?? "\(self)"
    }
    
    /// Строковое представление курса валюты с 2-6 знаками после запятой
    var formattedRate: String {
        return NumberFormatter.exchangeRateFormatter.string(from: self as NSDecimalNumber) ?? "\(self)"
    }
}

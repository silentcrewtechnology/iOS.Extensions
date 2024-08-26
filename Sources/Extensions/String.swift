import UIKit
import CryptoKit

public extension String {
    
    func fullRange() -> NSRange {
        let range = (self as NSString).range(of: self)
        return range
    }
    
    var attributed: NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: self)
        return attributedString
    }
}

public extension String {
    
    func localizeReplacing(key: LocalizedValue = .value, string: String) -> String {
        var result = self.localized
        assert(result.contains(key.rawValue), "\(self.localized) not contains key '\(key)'")
        result = result.replacingOccurrences(of: key.rawValue, with: string)
        return result
    }
    
    func localizeReplacing(_ replaceDictionary: [LocalizedValue: String]) -> String {
        var result = self.localized
        for (key, value) in replaceDictionary {
            assert(result.contains(key.rawValue), "\(self.localized) not contains key '\(key.rawValue)'")
            result = result.replacingOccurrences(of: key.rawValue, with: value)
        }
        return result
    }

    func localizeReplacing(
        _ replaceDictionary: [LocalizedValue: (text: String, attributes: [NSAttributedString.Key: Any])]
    ) -> NSAttributedString {
        let result = NSMutableAttributedString(string: self.localized)
        
        for (key, value) in replaceDictionary {
            if let range = result.string.range(of: key.rawValue) {
                var nsRange = NSRange(range, in: result.string)
                result.replaceCharacters(in: nsRange, with: value.text)
                
                nsRange.length = value.text.count
                result.addAttributes(value.attributes, range: nsRange)
            } else {
                assertionFailure("\(self.localized) not contains key '\(key.rawValue)'")
            }
        }
        return result
    }
    
    enum LocalizedValue: String {
        case value = "{value}"
        case value1 = "{value1}"
        case value2 = "{value2}"
        case value3 = "{value3}"
        case value4 = "{value4}"
        case value5 = "{value5}"
        case value6 = "{value6}"
        case value7 = "{value7}"
        case value8 = "{value8}"
        case value9 = "{value9}"
        case value10 = "{value10}"
    }
}

public extension StringProtocol {
    
    static var nonBreakingSpace: Self { "\u{00a0}" }
}

public extension String {

    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    func lowercasedWithoutSpaces() -> String {
        return self.lowercased().filter({ $0 != " " })
    }
    
    func localizeReplacing(
        _ replaceDictionary: [String: String]
    ) -> String {
        var result = self.localized
        for (key, value) in replaceDictionary {
            assert(result.contains(key), "\(self.localized) not contains key '\(key)'")
            result = result.replacingOccurrences(of: key, with: value)
        }
        return result
    }
    
    func localizeReplacing(
        _ replaceDictionary: [String: (text: String, attributes: [NSAttributedString.Key: Any])]
    ) -> NSAttributedString {
        let result = NSMutableAttributedString(string: self.localized)
        
        for (key, value) in replaceDictionary {
            if let range = result.string.range(of: key) {
                var nsRange = NSRange(range, in: result.string)
                result.replaceCharacters(in: nsRange, with: value.text)
                
                nsRange.length = value.text.count
                result.addAttributes(value.attributes, range: nsRange)
            } else {
                assertionFailure("\(self.localized) not contains key '\(key)'")
            }
        }
        
        return result
    }
    
    func boolValue() -> Bool {
        
        let lowerSelf = self.lowercased()
        
        switch lowerSelf {
        case "true", "yes", "on", "1":
            return true
        case "false", "no", "off", "0":
            return false
        default:
            return false
        }
    }
    
    func attributedStringWithLineSpacing(
        _ lineSpacing: CGFloat,
        alignment: NSTextAlignment = .left
    ) -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.lineHeightMultiple = 1
        paragraphStyle.alignment = alignment
        let attributedString = NSMutableAttributedString(string: self)
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle,
                                      value: paragraphStyle,
                                      range: NSRange(location: 0, length: attributedString.length))
        
        return attributedString
    }
    
    func decimalValue() -> Decimal? {
        let decimal = NumberFormatter.fractionSumFormatter.number(from: self)
        return decimal?.decimalValue
    }
}


public extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
}

public extension String {
    func trimLeftToLast(element: Character) -> String {
        var string = self
        if let lastIndex = string.lastIndex(of: element) {
            string.removeSubrange(string.startIndex...lastIndex)
            return string
        }
        return self
    }
}

public extension String {
    
    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self) else {
            return nil
        }
        
        return String(data: data, encoding: .utf8)
    }
    
    func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }
}

public extension String {
    
    func width(height: CGFloat, font: UIFont) -> CGRect {
        let constraintRect = CGSize(
            width: .greatestFiniteMagnitude,
            height: height
        )
        let rect = self.boundingRect(
            with: constraintRect,
            options: .usesLineFragmentOrigin,
            attributes: [NSAttributedString.Key.font: font],
            context: nil
        )
        return rect
    }
}

public extension String {
    /// Возвращает номер телефона в формате +7(000)0000000 при условии,
    /// что передается номер из 11 цифр(где первое число 8 или 7)
    /// или номер из 10 цифр(с отсутствующим кодом страны)
    func formatedRuPhone() -> String? {
        let defaultMask = "+X(XXX)XXXXXXX"
        var numbers = self.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        if numbers.first == "8" || numbers.first == "7" {
            numbers = "7" + numbers.suffix(max(numbers.count - 1, 0))
        } else if numbers.count == 10 {
            numbers = "7" + numbers
        } else {
            return nil
        }
        var result = ""
        var index = numbers.startIndex
        for ch in defaultMask where index < numbers.endIndex {
            if ch == "X" {
                result.append(numbers[index])
                index = numbers.index(after: index)
            } else {
                result.append(ch)
            }
        }
        return result
    }
    
    /// Возвращает номер телефона в формате +7 (000) 000-00-00 при условии,
    /// что передается номер из 11 цифр(где первое число 8 или 7)
    /// или номер из 10 цифр(с отсутствующим кодом страны)
    func formatedRuPhoneNumber() -> String? {
        let defaultMask = "+X (XXX) XXX-XX-XX"
        var numbers = self.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        if numbers.first == "8" || numbers.first == "7" {
            numbers = "7" + numbers.suffix(max(numbers.count - 1, 0))
        } else if numbers.count == 10 {
            numbers = "7" + numbers
        } else {
            return nil
        }
        var result = ""
        var index = numbers.startIndex
        for ch in defaultMask where index < numbers.endIndex {
            if ch == "X" {
                result.append(numbers[index])
                index = numbers.index(after: index)
            } else {
                result.append(ch)
            }
        }
        return result
    }
    
    /// Возвращает номер телефона в формате +7 000 000-00-00 при условии,
    /// что передается номер из 11 цифр(где первое число 8 или 7)
    /// или номер из 10 цифр(с отсутствующим кодом страны)
    func formatedRuPhoneNumberWithoutBrackets() -> String? {
        let defaultMask = "+X XXX XXX-XX-XX"
        var numbers = self.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        if numbers.first == "8" || numbers.first == "7" {
            numbers = "7" + numbers.suffix(max(numbers.count - 1, 0))
        } else if numbers.count == 10 {
            numbers = "7" + numbers
        } else {
            return nil
        }
        var result = ""
        var index = numbers.startIndex
        for ch in defaultMask where index < numbers.endIndex {
            if ch == "X" {
                result.append(numbers[index])
                index = numbers.index(after: index)
            } else {
                result.append(ch)
            }
        }
        return result
    }
}

public extension String {
    
    func htmlAttributed(fontSizeForHTML: CGFloat,
                        fontSizeForTag: CGFloat,
                        color: String,
                        lineHeight: CGFloat = 20) -> NSAttributedString? {
        do {
            let htmlCSString = "<style>" +
            "html * {" +
            "color: \(color);" +
            "font-family: -apple-system;" +
            "font-size: \(fontSizeForHTML)px;" +
            "line-height: \(lineHeight)px;" +
            "}" +
            "b {" +
            "font-size: \(fontSizeForTag)px;" +
            "}</style> \(self)"
            
            guard let data = htmlCSString.data(using: String.Encoding.utf8) else {
                return nil
            }
            
            return try NSAttributedString(data: data,
                                          options: [.documentType: NSAttributedString.DocumentType.html,
                                                    .characterEncoding: String.Encoding.utf8.rawValue],
                                          documentAttributes: nil)
        } catch {
            return nil
        }
    }
}

public extension String {
    
    var sha1Base64: String {
        guard let data = data(using: .utf8) else { return "" }
        return Data(Insecure.SHA1.hash(data: data)).base64EncodedString()
    }
    
    var sha256Base64: String {
        guard let data = data(using: .utf8) else { return "" }
        return Data(SHA256.hash(data: data)).base64EncodedString()
    }
}

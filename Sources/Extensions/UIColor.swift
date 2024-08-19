import UIKit

@available(*, deprecated, message: "Переходим на новые функции getHexWithAlpha и getRGBA")
public extension UIColor {
    
    convenience init(hexString: String) {
        let trimmedHexString = hexString.trimmingCharacters(
            in: CharacterSet.alphanumerics.inverted)
        let hex = UInt(trimmedHexString, radix: 16) ?? 0x00000000
        let r, g, b, a: UInt
        switch trimmedHexString.count {
        case 6: // #RRGGBB
            (r, g, b, a) = (hex >> 16 & 0xFF, hex >> 8 & 0xFF, hex & 0xFF, 0xFF)
        case 8: // #RRGGBBAA
            (r, g, b, a) = (hex >> 24 & 0xFF, hex >> 16 & 0xFF, hex >> 8 & 0xFF, hex & 0xFF)
        default:
            (r, g, b, a) = (0, 0, 0, 0)
        }
        self.init(
            red: CGFloat(r) / 0xFF,
            green: CGFloat(g) / 0xFF,
            blue: CGFloat(b) / 0xFF,
            alpha: CGFloat(a) / 0xFF)
    }
}

//
//  File.swift
//  
//
//  Created by user on 26.04.2024.
//

import Foundation
import UIKit

public extension NSDictionary {
    
    @objc func utf8Description() -> String {
        guard let data = try? JSONSerialization.data(withJSONObject: self, options: []) else { return "" }
        return String(data: data, encoding: .utf8) ?? ""
    }
}

public extension Dictionary where Key == NSAttributedString.Key, Value == Any {
    
    static func foregroundColor(_ color: UIColor) -> Self {
        let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: color]
        return attributes
    }
    
    static func font(_ font: UIFont) -> Self {
        let attributes: [NSAttributedString.Key: Any] = [.font: font]
        return attributes
    }
    
    static func lineHeight(_ lineHeight: CGFloat) -> Self {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = lineHeight
        paragraphStyle.maximumLineHeight = lineHeight
        let attributes: [NSAttributedString.Key: Any] = [.paragraphStyle: paragraphStyle]
        return attributes
    }
}


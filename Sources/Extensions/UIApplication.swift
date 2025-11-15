//
//  UIApplication.swift
//
//
//  Created by user on 24.09.2024.
//

import UIKit

public extension UIApplication {
    
    enum SafeAreaDirection {
        case top
        case bottom
        case left
        case right
    }
    
    static func safeArea(_ inset: SafeAreaDirection) -> CGFloat {
        switch inset {
        case .top:
            return currentWindow??.safeAreaInsets.top ?? 0.0
        case .bottom:
            return currentWindow??.safeAreaInsets.bottom ?? 0.0
        case .left:
            return currentWindow??.safeAreaInsets.left ?? 0.0
        case .right:
            return currentWindow??.safeAreaInsets.right ?? 0.0
        }
    }
    
    static var currentWindow: UIWindow?? {
        if let window = UIApplication.shared.delegate?.window {
            return window
        } else if let window = UIApplication.shared.windows.first {
            return window
        } else {
            return nil
        }
    }
}

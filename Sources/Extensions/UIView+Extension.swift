//
//  UIView+Extension.swift
//  
//
//  Created by firdavs on 24.05.2024.
//
import Objects
import UIKit

public extension UIView {
    
    func addTapGesture(_ didTap: @escaping () -> Void) {
        let tapGestureRecognizer = TapGestureRecognizer(didTap: didTap)
        self.addGestureRecognizer(tapGestureRecognizer)
    }
}

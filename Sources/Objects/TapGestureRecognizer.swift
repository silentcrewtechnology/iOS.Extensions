//
//  TapGestureRecognizer.swift
//
//
//  Created by firdavs on 24.05.2024.
//

import UIKit

public final class TapGestureRecognizer: UITapGestureRecognizer {
    
    final public class Action: NSObject {
        @objc
        private func selectorAction() { didTap() }
        private let didTap: () -> Void
        
        public var selector: Selector {
            #selector(selectorAction)
        }
        
        public init(didTap: @escaping () -> Void) {
            self.didTap = didTap
            super.init()
        }
    }
    
    private let action: Action
    
    public init(didTap: @escaping () -> Void) {
        self.action = .init(didTap: didTap)
        super.init(
            target: self.action,
            action: self.action.selector
        )
    }
}

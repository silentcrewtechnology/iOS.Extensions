//
//  TapGestureRecognizer.swift
//
//
//  Created by firdavs on 24.05.2024.
//

import UIKit

public final class TapGestureRecognizer: UITapGestureRecognizer {
    private let action: SelectorAction
    
    public init(didTap: @escaping () -> Void) {
        self.action = .init(didTap: didTap)
        
        super.init(
            target: self.action,
            action: self.action.selector
        )
    }
}

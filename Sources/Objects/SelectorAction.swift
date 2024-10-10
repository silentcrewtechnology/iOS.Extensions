//
//  SelectorAction.swift
//
//
//  Created by user on 10.10.2024.
//

import Foundation

public final class SelectorAction: NSObject {
    public var selector: Selector {
        #selector(selectorAction)
    }
    
    public var didTap: (() -> Void)?
    
    public override init() { super.init() }
    
    public convenience init(didTap: @escaping () -> Void) {
        self.init()

        self.didTap = didTap
    }
    
    @objc private func selectorAction() {
        didTap?()
    }
}

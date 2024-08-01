//
//  Encodable.swift
//
//
//  Created by firdavs on 01.08.2024.
//

import Foundation

public extension Encodable {
    
    var dictionary: [String: Any]? {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(self)
            let parameters = try JSONSerialization.jsonObject(
                with: data,
                options: []) as? [String: Any]
            return parameters
        } catch {
            return nil
        }
    }
}

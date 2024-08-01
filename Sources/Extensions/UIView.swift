//
//  UIView.swift
//  
//
//  Created by firdavs on 01.08.2024.
//

import UIKit

public extension UIView {
    
    static func dequeueReusableCell(
        with tableView: UITableView,
        with indexPath: IndexPath
    ) -> Self {
        tableView.register(Self.self, forCellReuseIdentifier: String(describing: Self.self))
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: Self.self), for: indexPath)
        return cell as! Self
    }
}


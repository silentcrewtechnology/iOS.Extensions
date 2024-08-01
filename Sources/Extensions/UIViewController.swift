//
//  UIViewController.swift
//  
//
//  Created by firdavs on 01.08.2024.
//
import UIKit

public extension UIViewController {

    func setTabBarTitle(with title: String?){
        tabBarItem.title = title
    }
    
    func setTabBarImage(with image: UIImage){
        tabBarItem.image = image
    }
    
    func setTitle(with title: NSAttributedString){
        let navLabel = UILabel()
        navLabel.attributedText = title
        navigationItem.titleView = navLabel
    }
}


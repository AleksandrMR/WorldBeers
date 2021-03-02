//
//  UIViewExtension.swift
//  WorldBeersAM
//
//  Created by Aleksandr Milashevski on 28/02/21.
//

import UIKit

extension UIView {
    
    func myShadowTopBar() {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 0, height: 3)
        layer.shadowRadius = 2
    }

    func myShadowBottomBar() {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        //        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 2
    }
    
    func myShadow() {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 3, height: 3)
        layer.shadowRadius = 2
        
    }
    
    func myShadowOne() {
        layer.masksToBounds = false
        
        if #available(iOS 13.0, *) {
            layer.shadowColor = UIColor.systemGray4.cgColor
        } else {
            layer.shadowColor = UIColor.gray.cgColor
        }
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.shadowRadius = 3
    }
}

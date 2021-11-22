//
//  Font+Extension.swift
//  Messenger
//
//  Created by Alexander on 12.11.2021.
//

import UIKit

extension UIFont {
    
    static var logoFont: UIFont? {
        return UIFont.init(name: "Noteworthy", size: 40) ?? .systemFont(ofSize: 40)
    }
   
    static var headerFont: UIFont? {
        return UIFont.init(name: "Noteworthy", size: 30) ?? .systemFont(ofSize: 30)
    }
   
    static var mainFont: UIFont? {
        return UIFont.init(name: "Noteworthy", size: 24) ?? .systemFont(ofSize: 24)
    }
    
    static var secondaryFont: UIFont? {
        return UIFont.init(name: "Noteworthy", size: 18) ?? .systemFont(ofSize: 18)
    }
    
    static var searchFont: UIFont? {
        return UIFont.init(name: "Noteworthy", size: 16) ?? .systemFont(ofSize: 16)
    }
    
    static var tabBarItemFont: UIFont? {
        return UIFont.init(name: "Noteworthy", size: 12) ?? .systemFont(ofSize: 12)
    }
}

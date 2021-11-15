//
//  Font+Extension.swift
//  Messenger
//
//  Created by Alexander on 12.11.2021.
//

import UIKit

extension UIFont {
    
    static var mainFont24: UIFont? {
        return UIFont.init(name: "Noteworthy", size: 24) ?? .systemFont(ofSize: 24)
    }
    
    static var secondaryFont18: UIFont? {
        return UIFont.init(name: "Noteworthy", size: 18) ?? .systemFont(ofSize: 18)
    }
    
    static var headerFont30: UIFont? {
        return UIFont.init(name: "Noteworthy", size: 30) ?? .systemFont(ofSize: 30)
    }
    
    static var logoFont40: UIFont? {
        return UIFont.init(name: "Noteworthy", size: 40) ?? .systemFont(ofSize: 40)
    }
}

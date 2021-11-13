//
//  Font+Extension.swift
//  Messenger
//
//  Created by Alexander on 12.11.2021.
//

import UIKit

extension UIFont {
    
    static var mainFont25: UIFont {
        return UIFont.init(name: "Noteworthy", size: 25) ?? .systemFont(ofSize: 25)
    }
    
    static var secondaryFont18: UIFont {
        return UIFont.init(name: "Noteworthy", size: 18) ?? .systemFont(ofSize: 18)
    }
    
    static var logoFont40: UIFont {
        return UIFont.init(name: "Noteworthy", size: 40) ?? .systemFont(ofSize: 40)
    }
}

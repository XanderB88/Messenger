//
//  UINavigationItem+Extension.swift
//  Messenger
//
//  Created by Alexander on 13.12.2021.
//

import UIKit

extension UINavigationItem {
    
   func setAppearance(font: UIFont, color: UIColor) {
        
       let appearance = UINavigationBarAppearance()
      
       appearance.titleTextAttributes = [.font: font, .foregroundColor: color]
       self.standardAppearance = appearance
    }
}

//
//  UILabel+Extension.swift
//  Messenger
//
//  Created by Alexander on 13.11.2021.
//

import Foundation
import UIKit

extension UILabel {
   
    convenience init(text: String,
                     textColor: UIColor,
                     font: UIFont? = .mainFont) {
        self.init()
       
        self.text = text
        self.textColor = textColor
        self.font = font
    }
}

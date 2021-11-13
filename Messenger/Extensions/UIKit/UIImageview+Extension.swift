//
//  UIImage+Extension.swift
//  Messenger
//
//  Created by Alexander on 13.11.2021.
//

import Foundation
import UIKit

extension UIImageView {
    
    convenience init(image: UIImage?, contentMode: UIView.ContentMode) {
        self.init()
        
        self.image = image
        self.contentMode = contentMode
    }
}

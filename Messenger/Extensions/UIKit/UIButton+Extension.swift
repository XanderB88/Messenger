//
//  Button+Extension.swift
//  Messenger
//
//  Created by Alexander on 12.11.2021.
//

import UIKit

extension UIButton {
    
    convenience init(title: String,
                     titleColor: UIColor? = .mainWhite,
                     backgroundColor: UIColor,
                     backgroundColorAlfa: CGFloat = 1,
                     font: UIFont? = .mainFont24,
                     cornerRadius: CGFloat = 5,
                     icon: UIImage) {
        
        self.init(type: .system)
        
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.backgroundColor = backgroundColor.withAlphaComponent(backgroundColorAlfa)
        self.titleLabel?.font = font
        self.layer.cornerRadius = cornerRadius
        
        self.setImage(icon.withRenderingMode(.alwaysOriginal), for: .normal)
        self.imageView?.contentMode = .scaleToFill
        
        self.titleEdgeInsets = UIEdgeInsets(
                    top: 0,
                    left: 15,
                    bottom: 0,
                    right: -15
                )
    }
}

//
//  Button+Exension.swift
//  Messenger
//
//  Created by Alexander on 12.11.2021.
//

import UIKit

extension UIButton {
    
    convenience init(title: String,
                     titleColor: UIColor = .mainWhite,
                     backgroundColor: UIColor,
                     backgroundColorAlfa: CGFloat,
                     font: UIFont = .mainFont25,
                     cornerRadius: CGFloat = 5,
                     icon: UIImage) {
        
        self.init(configuration: .plain())
        self.configuration?.imagePadding = 20
    
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.backgroundColor = backgroundColor.withAlphaComponent(backgroundColorAlfa)
        self.titleLabel?.font = font
        self.layer.cornerRadius = cornerRadius
        
        self.setImage(icon.withRenderingMode(.alwaysOriginal), for: .normal)
        self.imageView?.contentMode = .scaleToFill
    }
}

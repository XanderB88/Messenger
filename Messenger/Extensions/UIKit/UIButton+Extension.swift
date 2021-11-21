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
                     font: UIFont? = .mainFont,
                     cornerRadius: CGFloat = 5) {
        
        self.init(type: .system)
        
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.backgroundColor = backgroundColor.withAlphaComponent(backgroundColorAlfa)
        self.titleLabel?.font = font
        self.layer.cornerRadius = cornerRadius
    }
    
    func setupIconForButton(icon: UIImage) {
        let setupIcon = UIImageView(image: icon, contentMode: .scaleAspectFit)
        setupIcon.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(setupIcon)
        
        NSLayoutConstraint.activate([
            setupIcon.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 80),
            setupIcon.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}

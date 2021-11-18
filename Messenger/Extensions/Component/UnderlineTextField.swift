//
//  UnderlineTextField.swift
//  Messenger
//
//  Created by Alexander on 15.11.2021.
//

import UIKit

class UnderlineTextField: UITextField {
    
    convenience init(font: UIFont? = .secondaryFont18, placeholder: String = "", isSecured: Bool = false) {
        self.init()
        
        self.font = font
        self.textColor = .mainWhite
        self.isSecureTextEntry = isSecured
        self.borderStyle = .none
        self.placeholder = placeholder
        self.translatesAutoresizingMaskIntoConstraints = false
        
        var bottomLine = UIView()
        bottomLine = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0))
        bottomLine.backgroundColor = .secondaryWhite

        bottomLine.translatesAutoresizingMaskIntoConstraints = false

        self.addSubview(bottomLine)

        NSLayoutConstraint.activate([
            bottomLine.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            bottomLine.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            bottomLine.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            bottomLine.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
}

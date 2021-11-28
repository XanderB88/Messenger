//
//  MessageFromProfileTextField.swift
//  Messenger
//
//  Created by Alexander on 28.11.2021.
//

import UIKit

class MessageFromProfileTextField: UnderlineTextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        clearButtonMode = .whileEditing
        self.attributedPlaceholder = NSAttributedString(
            string: super.placeholder ?? "Write me something here",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.secondaryWhite.withAlphaComponent(0.4)]
        )
        
        let image = UIImage(systemName: "message")
        let imageView = UIImageView(image: image)
       
        leftView = imageView
        leftView?.frame = CGRect(x: 0, y: 0, width: 19, height: 19)
        leftViewMode = .always
        leftView?.tintColor = .secondaryWhite
        
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "arrowshape.turn.up.forward.circle"), for: .normal)
        button.tintColor = .mainBlue
        
        rightView = button
        rightView?.frame = CGRect(x: 0, y: 0, width: 19, height: 19)
        rightViewMode = .always
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 40, dy: 0)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 40, dy: 0)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 40, dy: 0)
    }

    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var rectangle = super.leftViewRect(forBounds: bounds)
        rectangle.origin.x += 10
        return rectangle
    }

    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var rectangle = super.rightViewRect(forBounds: bounds)
        rectangle.origin.x += -10
        return rectangle
    }
}

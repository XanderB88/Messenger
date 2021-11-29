//
//  UIView+Extension.swift
//  Messenger
//
//  Created by Alexander on 29.11.2021.
//

import UIKit

extension UIView {
    
    func addGradient(cornerRadius: CGFloat) {
        
        self.backgroundColor = nil
        self.layoutIfNeeded()
        
        let gradientView = GradientView(from: .topTrailing, to: .bottomLeading, startColor: UIColor.mainBlue, endColor: UIColor.secondaryBlue)
        
        if let gradientLayer = gradientView.layer.sublayers?.first as? CAGradientLayer {
            
            gradientLayer.frame = self.bounds
            gradientLayer.cornerRadius = cornerRadius
            
            self.layer.insertSublayer(gradientLayer, at: 0)
        }
    }
}

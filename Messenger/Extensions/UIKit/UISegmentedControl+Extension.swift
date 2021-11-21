//
//  GenderControl.swift
//  Messenger
//
//  Created by Alexander on 19.11.2021.
//

import UIKit

extension UISegmentedControl {
    
    convenience init(first: String, second: String) {
        self.init()
    
        self.insertSegment(withTitle: first, at: 0, animated: true)
        self.insertSegment(withTitle: second, at: 1, animated: true)
        self.selectedSegmentIndex = 0
        
        let attributes : [NSAttributedString.Key: Any] = [.font: UIFont.secondaryFont!, .foregroundColor: UIColor.mainWhite]
        self.selectedSegmentTintColor = UIColor.mainWhite.withAlphaComponent(0.2)
        self.setTitleTextAttributes(attributes, for: .normal)
    }
}


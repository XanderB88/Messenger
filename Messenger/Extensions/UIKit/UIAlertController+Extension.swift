//
//  UIAlertController+Extension.swift
//  Messenger
//
//  Created by Alexander on 05.12.2021.
//

import UIKit

extension UIAlertController {
    
    func setBackgroundColor(color: UIColor) {
       
        if let backgroundView = self.view.subviews.first,
           let groupView = backgroundView.subviews.first,
           let contentView = groupView.subviews.first {
            contentView.backgroundColor = color
        }
    }

     func setTitleAttributes(font: UIFont?, color: UIColor?) {
        
         guard let title = self.title else { return }
        
         let attributedString = NSMutableAttributedString(string: title)
         
         if let titleFont = font {
           
             attributedString.addAttributes([NSAttributedString.Key.font : titleFont],
                                           range: NSMakeRange(0, title.utf8.count))
         }

         if let titleColor = color {
             
             attributedString.addAttributes([NSAttributedString.Key.foregroundColor : titleColor],
                                           range: NSMakeRange(0, title.utf8.count))
         }
        
         self.setValue(attributedString, forKey: "attributedTitle")
     }

     func setMessageAttributes(font: UIFont?, color: UIColor?) {
        
         guard let message = self.message else { return }
        
         let attributedString = NSMutableAttributedString(string: message)
        
         if let messageFont = font {
            
             attributedString.addAttributes([NSAttributedString.Key.font : messageFont],
                                           range: NSMakeRange(0, message.utf8.count))
         }

         if let messageColor = color {
           
             attributedString.addAttributes([NSAttributedString.Key.foregroundColor : messageColor],
                                           range: NSMakeRange(0, message.utf8.count))
         }
        
         self.setValue(attributedString, forKey: "attributedMessage")
     }

     func setTint(color: UIColor) {
        
         self.view.tintColor = color
     }
}

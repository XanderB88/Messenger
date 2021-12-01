//
//  Validator.swift
//  Messenger
//
//  Created by Alexander on 01.12.2021.
//

import Foundation


protocol ValidatorProtocol {
    
    func isFilled(email: String?, password: String?, confirmPassword: String?) -> Bool
    func isValidEmail(email: String) -> Bool
    func isPasswordHasNumberAndCharacter(password: String) -> Bool
    func check(text: String, regEx: String) -> Bool
    
}

class Validator: ValidatorProtocol {
   
    func isFilled(email: String?, password: String?, confirmPassword: String?) -> Bool {
        
        guard let email = email,
              let password = password,
              let confirmPassword = confirmPassword,
              email != "",
              password != "",
              confirmPassword != ""
        else { return false }
       
        return true
    }
    
    func isValidEmail(email: String) -> Bool {
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        return check(text: email, regEx: emailRegEx)
    }
    
    func isPasswordHasNumberAndCharacter(password: String) -> Bool {
        
        let passwordRegEx = "(?=[^a-z]*[a-z])[^0-9]*[0-9].*"
        
        return check(text: password, regEx: passwordRegEx)
    }
    
    func check(text: String, regEx: String) -> Bool {
        
        let predicate = NSPredicate(format: "SELF MATCHES %@", regEx)
        
        return predicate.evaluate(with: text)
    }
}

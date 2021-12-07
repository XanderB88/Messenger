//
//  AuthenticationError.swift
//  Messenger
//
//  Created by Alexander on 01.12.2021.
//

import Foundation

enum AuthenticationError {
    case fieldsIsNotFilled
    case invalidEmail
    case invalidPassword
    case passwordsIsNotMatched
    case serverError
    case unknownError
}

extension AuthenticationError: LocalizedError {
    
    var errorDescription: String? {
       
        switch self {
            case .fieldsIsNotFilled:
                return NSLocalizedString("Please fill out all fields", comment: "")
            case .invalidEmail:
                return NSLocalizedString("The email address is badly formatted", comment: "Email must be formatted user@mailbox.com")
            case .invalidPassword:
                return NSLocalizedString("The password is badly formatted", comment: "Password must contain uppercase and lowercase letters and numbers")
            case .passwordsIsNotMatched:
                return NSLocalizedString("Passwords is not matched", comment: "")
            case .serverError:
                return NSLocalizedString("Server error", comment: "")
            case .unknownError:
                return NSLocalizedString("Unknown error", comment: "")
        }
    }
}

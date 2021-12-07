//
//  UserError.swift
//  Messenger
//
//  Created by Alexander on 07.12.2021.
//

import Foundation

enum UserError {
    case fieldsIsNotFilled
    case userImageIsNotExist
}

extension UserError: LocalizedError {
    
    var errorDescription: String? {
       
        switch self {
            case .fieldsIsNotFilled:
                return NSLocalizedString("Please fill out all fields", comment: "")
            case .userImageIsNotExist:
                return NSLocalizedString("Please add an image for your account", comment: "")
        }
    }
}

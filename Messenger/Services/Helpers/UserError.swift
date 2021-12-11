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
    case cannotGetUserInfo
    case cannotUnwrapToUserModel
}

extension UserError: LocalizedError {
    
    var errorDescription: String? {
       
        switch self {
            case .fieldsIsNotFilled:
                return NSLocalizedString("Please fill out all fields", comment: "")
            case .userImageIsNotExist:
                return NSLocalizedString("Please add an image for your account", comment: "")
            case .cannotGetUserInfo:
                return NSLocalizedString("An information about the user can't be loaded from Firebase", comment: "")
            case .cannotUnwrapToUserModel:
                return NSLocalizedString("The user can't be loaded from Firebase", comment: "")
        }
    }
}

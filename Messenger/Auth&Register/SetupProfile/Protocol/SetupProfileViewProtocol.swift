//
//  SetupProfileViewProtocol.swift
//  Messenger
//
//  Created by Alexander on 07.12.2021.
//

import Foundation

protocol SetupProfileViewProtocol: AnyObject {
    
    func success(user: UserModel)
    func failure(error: Error)
}

//
//  ConfigProfileViewProtocol.swift
//  Messenger
//
//  Created by Alexander on 14.12.2021.
//

import Foundation

protocol ConfigurationProfileViewProtocol: AnyObject {
    
    func success()
    func updateView(user: UserModel)
    func failure(error: Error)
}

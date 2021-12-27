//
//  ProfileViewPresenterProtocol.swift
//  Messenger
//
//  Created by Alexander on 26.12.2021.
//

import Foundation
import UIKit

protocol ProfileViewPresenterProtocol: AnyObject {
    
    init(view: ProfileViewProtocol, fireStoreService: FireStoreServiceProtocol, router: RouterAuthenticationProtocol)
    func sendMessage(message: String, receiver: UserModel, currentUser: UserModel)
}

//
//  SetupProfileViewPresenterProtocol.swift
//  Messenger
//
//  Created by Alexander on 05.12.2021.
//

import Foundation

protocol SetupProfileViewPresenterProtocol: AnyObject {
    
    init(view: SetupProfileViewProtocol, fireStoreService: FirestoreServiceProtocol, authenticationService: AuthenticationServiceProtocol, router: RouterAuthenticationProtocol)
    func saveUserProfile(username: String?, userImageString: String?, description: String?, gender: String?)
    func toChatScreen()
}

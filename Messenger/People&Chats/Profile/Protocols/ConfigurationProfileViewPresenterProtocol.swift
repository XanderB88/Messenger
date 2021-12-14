//
//  ConfigProfileViewPresenterProtocol.swift
//  Messenger
//
//  Created by Alexander on 14.12.2021.
//

import Foundation

protocol ConfigurationProfileViewPresenterProtocol: AnyObject {
    
    init(view: ConfigurationProfileViewProtocol, fireStoreService: FireStoreServiceProtocol, authenticationService: AuthenticationServiceProtocol, router: RouterAuthenticationProtocol)
    func saveUserProfile(username: String?, userImageString: String?, description: String?, gender: String?)
    func getUserInfo()
    func logOutButtonPressed()
    func popToRoot()
}

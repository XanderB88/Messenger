//
//  LoginViewPresenterProtocol.swift
//  Messenger
//
//  Created by Alexander on 04.12.2021.
//

import Foundation

protocol LoginViewPresenterProtocol: AnyObject {
    
    init(view: LoginViewProtocol, authenticationService: AuthenticationServiceProtocol)
    func login(email: String?, password: String?)
}

//
//  EmailRegistrationPresenterProtocol.swift
//  Messenger
//
//  Created by Alexander on 03.12.2021.
//

import Foundation

protocol EmailRegistrationViewPresenterProtocol: AnyObject {
    
    init(view: EmailRegistrationViewProtocol, authenticationService: AuthenticationServiceProtocol, router: RouterAuthenticationProtocol)
    
    func register(email: String?, password: String?, confirmPassword: String?)
}

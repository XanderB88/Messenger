//
//  EmailRegistrationPresenterProtocol.swift
//  Messenger
//
//  Created by Alexander on 03.12.2021.
//

import Foundation

protocol EmailRegistrationPresenterProtocol: AnyObject {
    
    init(view: EmailRegistrationViewProtocol, authenticationService: AuthenticationServiceProtocol)
    
    func register(email: String?, password: String?, confirmPassword: String?)
}

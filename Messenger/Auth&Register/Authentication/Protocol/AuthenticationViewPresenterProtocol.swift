//
//  AuthenticationViewPresenterProtocol.swift
//  Messenger
//
//  Created by Alexander on 04.12.2021.
//

import Foundation

protocol AuthenticationViewPresenterProtocol: AnyObject {
    
    init(router: RouterAuthenticationProtocol)
    func pressedToLoginButton()
    func pressedToEmailRegistrationButton()
}

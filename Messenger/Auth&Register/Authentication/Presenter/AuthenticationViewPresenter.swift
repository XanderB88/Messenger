//
//  AuthenticationViewPresenter.swift
//  Messenger
//
//  Created by Alexander on 04.12.2021.
//

import Foundation

class AuthenticationViewPresenter: AuthenticationViewPresenterProtocol {
    
    let router: RouterAuthenticationProtocol?
    
    required init(router: RouterAuthenticationProtocol) {
        
        self.router = router
    }
    
    func pressedToLoginButton() {
        router?.toLoginScreen()
    }
}

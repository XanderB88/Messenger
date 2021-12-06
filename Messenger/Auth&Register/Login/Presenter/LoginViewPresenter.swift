//
//  LoginViewPresenter.swift
//  Messenger
//
//  Created by Alexander on 04.12.2021.
//

import Foundation

class LoginViewPresenter: LoginViewPresenterProtocol {
    
    weak var view: LoginViewProtocol?
    let authenticationService: AuthenticationServiceProtocol!
    let router: RouterAuthenticationProtocol?
    
    required init(view: LoginViewProtocol, authenticationService: AuthenticationServiceProtocol, router: RouterAuthenticationProtocol) {
        
        self.view = view
        self.authenticationService = authenticationService
        self.router = router
    }
    
    func login(email: String?, password: String?) {
        
        authenticationService.login(email: email, password: password) { [weak self] result in
            
            guard let self = self else { return }
            
            switch result {
                case .success(_):
                    self.view?.success()
                case .failure(let error):
                    self.view?.failure(error: error)
            }
        }
    }
   
    func pressedToSignUpButton() {
        
        router?.toEmailRegistrationScreen()
    }
    
    func toPeopleAndChatTabBarController() {
        
        router?.toPeopleAndChatsTabBarController()
    }
}

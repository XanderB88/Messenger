//
//  EmailRegistrationPresenter.swift
//  Messenger
//
//  Created by Alexander on 03.12.2021.
//

import Foundation

class EmailRegistrationViewPresenter: EmailRegistrationViewPresenterProtocol {
    
    
    weak var view: EmailRegistrationViewProtocol?
    let authenticationService: AuthenticationServiceProtocol!
    let router: RouterAuthenticationProtocol?
   
    required init(view: EmailRegistrationViewProtocol, authenticationService: AuthenticationServiceProtocol, router: RouterAuthenticationProtocol) {
        
        self.view = view
        self.authenticationService = authenticationService
        self.router = router
    }
    
    func register(email: String?, password: String?, confirmPassword: String?) {
        
        authenticationService.register(email: email,
                                       password: password,
                                       confirmPassword: confirmPassword) { [weak self] result in
            
            guard let self = self else { return }
            
            switch result {
                case .success(_):
                    self.view?.success()
                case .failure(let error):
                    self.view?.failure(error: error)
            }
        }
    }
    
    func pressedToLoginButton() {
        
        router?.toLoginScreen()
    }
   
    func toSetupProfileScreen() {
       
        router?.toSetupProfileScreen()
    }
}

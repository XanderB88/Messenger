//
//  EmailRegistrationPresenter.swift
//  Messenger
//
//  Created by Alexander on 03.12.2021.
//

import Foundation

class EmailRegistrationPresenter: EmailRegistrationPresenterProtocol {
    
    weak var view: EmailRegistrationViewProtocol?
    let authenticationService: AuthenticationServiceProtocol!
   
    required init(view: EmailRegistrationViewProtocol, authenticationService: AuthenticationServiceProtocol) {
        
        self.view = view
        self.authenticationService = authenticationService
    }
    
    func register(email: String?, password: String?, confirmPassword: String?) {
        
        authenticationService.register(email: email, password: password, confirmPassword: confirmPassword) { [weak self] result in
            
            guard let self = self else { return }
            
            switch result {

                case .success(_):
                    self.view?.success()
                case .failure(let error):
                    self.view?.failure(error: error)
            }
        }
    }
}

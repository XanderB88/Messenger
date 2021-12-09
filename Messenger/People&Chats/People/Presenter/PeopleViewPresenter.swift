//
//  PeopleViewPresenter.swift
//  Messenger
//
//  Created by Alexander on 09.12.2021.
//

import Foundation

class PeopleViewPresenter: PeopleViewPresenterProtocol {
    
    let view: PeopleViewProtocol?
    let authenticationService: AuthenticationServiceProtocol!
    let router: RouterAuthenticationProtocol!
    
    required init(view: PeopleViewProtocol, authenticationService: AuthenticationServiceProtocol, router: RouterAuthenticationProtocol) {
        
        self.view = view
        self.authenticationService = authenticationService
        self.router = router
    }
    
    func logOutButtonPressed() {
        
        authenticationService.logout { [weak self] in
            
            guard let self = self else { return }
            
            self.view?.success()
        }
    }
    
    func popToRoot() {
        
        router.initialAuthenticationScreen()
    }
}

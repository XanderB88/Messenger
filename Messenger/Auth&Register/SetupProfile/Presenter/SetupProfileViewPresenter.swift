//
//  SetupProfileViewPresenter.swift
//  Messenger
//
//  Created by Alexander on 05.12.2021.
//

import Foundation

class SetupProfileViewPresenter: SetupProfileViewPresenterProtocol {
    
    let view: SetupProfileViewProtocol?
    let fireStoreService: FireStoreServiceProtocol!
    let authenticationService: AuthenticationServiceProtocol!
    let router: RouterAuthenticationProtocol?
    
    required init(view: SetupProfileViewProtocol, fireStoreService: FireStoreServiceProtocol, authenticationService: AuthenticationServiceProtocol,  router: RouterAuthenticationProtocol) {
       
        self.view = view
        self.fireStoreService = fireStoreService
        self.authenticationService = authenticationService
        self.router = router
    }
    
    func saveUserProfile(username: String?, userImageString: String?, description: String?, gender: String?) {
        
        guard let currentUser = authenticationService.getCurrentUser() else { return }

        fireStoreService.saveProfileWith(id: currentUser.uid,
                                         email: currentUser.email!,
                                         username: username,
                                         userImageString: userImageString,
                                         description: description,
                                         gender: gender) { [weak self] result in
            
            guard let self = self else { return }
            
            switch result {
                case .success(_):
                    self.view?.success()
                case .failure(let error):
                    self.view?.failure(error: error)
            }
        }
    }
    
    func toChatScreen() {
       
        router?.toPeopleAndChatsTabBarController()
    }
}

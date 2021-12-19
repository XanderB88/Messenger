//
//  ConfigProfileViewPresenter.swift
//  Messenger
//
//  Created by Alexander on 14.12.2021.
//

import Foundation

class ConfigurationProfileViewPresenter: ConfigurationProfileViewPresenterProtocol {
    
    let view: ConfigurationProfileViewProtocol?
    let fireStoreService: FireStoreServiceProtocol!
    let authenticationService: AuthenticationServiceProtocol!
    let router: RouterAuthenticationProtocol?
    
    required init(view: ConfigurationProfileViewProtocol, fireStoreService: FireStoreServiceProtocol, authenticationService: AuthenticationServiceProtocol,  router: RouterAuthenticationProtocol) {
       
        self.view = view
        self.fireStoreService = fireStoreService
        self.authenticationService = authenticationService
        self.router = router
    }
    
    func saveUserProfile(username: String?, userImageData: Data?, description: String?, gender: String?) {
        
        guard let currentUser = authenticationService.getCurrentUser() else { return }

        fireStoreService.saveProfileWith(id: currentUser.uid,
                                         email: currentUser.email!,
                                         username: username,
                                         userImageData: userImageData,
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
    
    func getUserInfo() {
        
        guard let currentUser = authenticationService.getCurrentUser() else { return }
        
        fireStoreService.getUserData(user: currentUser) { result in
            
            switch result {
                case .success(let modelUser):
                    self.view?.updateView(user: modelUser)
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
    
    func logOutButtonPressed() {
        
        self.view?.logOut()
    }
    
    func popToRoot() {
        
        authenticationService.logout {

            self.router?.initialAuthenticationScreen()
        }
    }
}


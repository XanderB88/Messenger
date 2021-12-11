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
    let fireStoreService: FireStoreServiceProtocol!
    
    required init(view: PeopleViewProtocol, authenticationService: AuthenticationServiceProtocol, router: RouterAuthenticationProtocol, fireStoreService: FireStoreServiceProtocol) {
        
        self.view = view
        self.authenticationService = authenticationService
        self.router = router
        self.fireStoreService = fireStoreService
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
    
    func getUsername(completion: @escaping (UserModel) -> Void) {
        
        guard let currentUser = authenticationService.getCurrentUser() else { return }
        
        fireStoreService.getUserData(user: currentUser) { result in
            
            switch result {
                case .success(let modelUser):
                    completion(modelUser)
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
}

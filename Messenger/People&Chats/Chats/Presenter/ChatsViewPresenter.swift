//
//  ChatsViewPresenter.swift
//  Messenger
//
//  Created by Alexander on 13.12.2021.
//

import Foundation

class ChatsViewPresenter: ChatsViewPresenterProtocol {
    
    let view: ChatsViewProtocol?
    let authenticationService: AuthenticationServiceProtocol!
    let fireStoreService: FireStoreServiceProtocol!
    let router: RouterAuthenticationProtocol!
    
    required init(view: ChatsViewProtocol, authenticationService: AuthenticationServiceProtocol, fireStoreService: FireStoreServiceProtocol, router: RouterAuthenticationProtocol) {
      
        self.view = view
        self.authenticationService = authenticationService
        self.fireStoreService = fireStoreService
        self.router = router
    }
    
    func getUsername() {
        
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
    
    
}

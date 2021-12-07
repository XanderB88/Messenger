//
//  SetupProfileViewPresenter.swift
//  Messenger
//
//  Created by Alexander on 05.12.2021.
//

import Foundation
import FirebaseAuth

class SetupProfileViewPresenter: SetupProfileViewPresenterProtocol {
    
    let view: SetupProfileViewProtocol?
    let fireStoreService: FirestoreServiceProtocol!
    let authenticationService: AuthenticationServiceProtocol!
    let router: RouterAuthenticationProtocol?
    
    required init(view: SetupProfileViewProtocol, fireStoreService: FirestoreServiceProtocol, authenticationService: AuthenticationServiceProtocol,  router: RouterAuthenticationProtocol) {
       
        self.view = view
        self.fireStoreService = fireStoreService
        self.authenticationService = authenticationService
        self.router = router
    }
    
    func saveUserProfile(username: String?, userImageString: String?, description: String?, gender: String?) {
        
        let currentUser = authenticationService.getCurrentUser()
        
        print(currentUser.uid)
        print(currentUser.email ?? "Nothing")
        
        fireStoreService.saveProfileWith(id: currentUser.uid,
                                         email: currentUser.email!,
                                         username: username,
                                         userImageString: userImageString,
                                         description: description,
                                         gender: gender) { [weak self] result in
            
            guard let self = self else { return }
            
            switch result {
                case .success(let user):
                    self.view?.success(user: user)
                case .failure(let error):
                    self.view?.failure(error: error)
            }
        }
    }
    
    func toChatScreen() {
       
        router?.toPeopleAndChatsTabBarController()
    }
}

//
//  PeopleViewPresenter.swift
//  Messenger
//
//  Created by Alexander on 09.12.2021.
//

import Foundation
import FirebaseFirestore

class PeopleViewPresenter: PeopleViewPresenterProtocol {
   
    var users = [UserModel]()
    var currentUser: UserModel?
    
    var userListener: ListenerRegistration? {
        
        return listenerService.usersObserve(users: self.users) { result in
            
            switch result {
                case .success(let users):
                    self.view?.updateUsers(users: users)
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
    
    let view: PeopleViewProtocol?
    let authenticationService: AuthenticationServiceProtocol!
    let router: RouterAuthenticationProtocol!
    let fireStoreService: FireStoreServiceProtocol!
    let listenerService: ListenerServiceProtocol!
    
    required init(view: PeopleViewProtocol, authenticationService: AuthenticationServiceProtocol, router: RouterAuthenticationProtocol, fireStoreService: FireStoreServiceProtocol, listenerService: ListenerServiceProtocol) {
        
        self.view = view
        self.authenticationService = authenticationService
        self.router = router
        self.fireStoreService = fireStoreService
        self.listenerService = listenerService
    }
    
    func getUserInfo() {
        
        guard let currentUser = authenticationService.getCurrentUser() else { return }
        
        fireStoreService.getUserData(user: currentUser) { result in
            
            switch result {
                case .success(let modelUser):
                    self.view?.updateView(currentUser: modelUser)
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
   
    func toProfileScreen(user: UserModel, currentUser: UserModel) {
        
        router.toProfileScreen(user: user, currentUser: currentUser)
    }
}

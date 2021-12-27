//
//  ProfileViewPresenter.swift
//  Messenger
//
//  Created by Alexander on 26.12.2021.
//

import Foundation

class ProfileViewPresenter: ProfileViewPresenterProtocol {
  
    let view: ProfileViewProtocol?
    let fireStoreService: FireStoreServiceProtocol!
    let router: RouterAuthenticationProtocol!

    required init(view: ProfileViewProtocol, fireStoreService: FireStoreServiceProtocol, router: RouterAuthenticationProtocol) {
        
        self.view = view
        self.fireStoreService = fireStoreService
        self.router = router
    }
    
    func sendMessage(message: String, receiver: UserModel, currentUser: UserModel) {
        
        fireStoreService.createWaitingChat(message: message, receiver: receiver, currentUser: currentUser) { result in
            
            switch result {
                    
                case .success():
                    self.view?.requestForChatIsSuccess()
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
}

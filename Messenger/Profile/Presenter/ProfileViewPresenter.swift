//
//  ProfileViewPresenter.swift
//  Messenger
//
//  Created by Alexander on 26.12.2021.
//

import Foundation

class ProfileViewPresenter: ProfileViewPresenterProtocol {
    
    let fireStoreService: FireStoreServiceProtocol!
    let router: RouterAuthenticationProtocol!

    required init(fireStoreService: FireStoreServiceProtocol, router: RouterAuthenticationProtocol) {
        
        self.fireStoreService = fireStoreService
        self.router = router
    }
    
    func sendMessage(message: String, receiver: UserModel) {
        
        fireStoreService.createWaitingChat(message: message, receiver: receiver) { result in
            
            switch result {
                    
                case .success():
                    print("Success")
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
}

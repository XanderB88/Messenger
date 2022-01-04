//
//  ChatRequestPresenter.swift
//  Messenger
//
//  Created by Alexander on 31.12.2021.
//

import Foundation


class ChatRequestPresenter: ChatRequestPresenterProtocol {
   
    let authenticationService: AuthenticationServiceProtocol!
    let fireStoreService: FireStoreServiceProtocol!
    
    required init(authenticationService: AuthenticationServiceProtocol, fireStoreService: FireStoreServiceProtocol) {
        
        self.authenticationService = authenticationService
        self.fireStoreService = fireStoreService
    }
    
    
    func removeWaitingChats(chat: ChatModel) {
        
        guard let currentUser = authenticationService.getCurrentUser() else { return }
        
        fireStoreService.removeWaitingChat(chat: chat, currentUser: currentUser) { result in
            
            switch result {
                case .success():
                    print("Success")
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
    
    func createActiveChat(chat: ChatModel) {
        
        guard let currentUser = authenticationService.getCurrentUser() else { return }
        
        fireStoreService.changeToActive(chat: chat, currentUser: currentUser) { result in
            
            switch result {
                case .success():
                    print("Success")
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
}

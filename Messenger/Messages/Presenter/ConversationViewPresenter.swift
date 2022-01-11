//
//  ConversationViewPresenter.swift
//  Messenger
//
//  Created by Alexander on 11.01.2022.
//

import Foundation

class ConversationViewPresenter: ConversationViewPresenterProtocol {
    
    let view: ConversationViewProtocol?
    let firebaseFirestore: FireStoreServiceProtocol!
        
    required init(view: ConversationViewProtocol, firebaseFirestore: FireStoreServiceProtocol) {
        
        self.view = view
        self.firebaseFirestore = firebaseFirestore
    }
    
    func sendMessage(chat: ChatModel, message: MessageModel, currentUser: UserModel) {
        
        firebaseFirestore.sendMessage(chat: chat, message: message, currentUser: currentUser) { result in
            
            switch result {
                case .success():
                    self.view?.updateView()
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
    
    
}

//
//  ConversationViewPresenter.swift
//  Messenger
//
//  Created by Alexander on 11.01.2022.
//

import Foundation
import FirebaseFirestore

class ConversationViewPresenter: ConversationViewPresenterProtocol {
    
    
    let view: ConversationViewProtocol?
    let firebaseFirestore: FireStoreServiceProtocol!
    let listenerService: ListenerServiceProtocol!

    func getMessageListener(chat: ChatModel) -> ListenerRegistration? {
        
        listenerService.messagesObserve(chat: chat) { result in
            
            switch result {
                    
                case .success(let message):
                    self.view?.updateMessages(message: message)
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
   
    required init(view: ConversationViewProtocol, firebaseFirestore: FireStoreServiceProtocol, listenerService: ListenerServiceProtocol) {
        
        self.view = view
        self.firebaseFirestore = firebaseFirestore
        self.listenerService = listenerService
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

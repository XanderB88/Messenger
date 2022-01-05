//
//  ChatsViewPresenter.swift
//  Messenger
//
//  Created by Alexander on 13.12.2021.
//

import Foundation
import FirebaseFirestore
import SwiftUI

class ChatsViewPresenter: ChatsViewPresenterProtocol {
    
    var waitingChats = [ChatModel]()
    var activeChats = [ChatModel]()
    
    var waitingChatListener: ListenerRegistration? {
        
        return listenerService.waitingChatsObserve(chats: waitingChats) { result in
          
            switch result {
                case .success(let chats):
                    self.view?.updateWaitingChats(waitingChats: chats)
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
    
    var activeChatListener: ListenerRegistration? {
        
        return listenerService.activeChatsObserve(chats: activeChats) { result in
          
            switch result {
                case .success(let chats):
                    self.view?.updateActiveChats(activeChats: chats)
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
    
    let view: ChatsViewProtocol?
    let authenticationService: AuthenticationServiceProtocol!
    let fireStoreService: FireStoreServiceProtocol!
    let router: RouterAuthenticationProtocol!
    let listenerService: ListenerServiceProtocol!
    
    required init(view: ChatsViewProtocol, authenticationService: AuthenticationServiceProtocol, fireStoreService: FireStoreServiceProtocol, router: RouterAuthenticationProtocol, listenerService: ListenerServiceProtocol) {
      
        self.view = view
        self.authenticationService = authenticationService
        self.fireStoreService = fireStoreService
        self.router = router
        self.listenerService = listenerService
    }
    
    func getUsername() {
        
        guard let currentUser = authenticationService.getCurrentUser() else { return }
        
        fireStoreService.getUserData(user: currentUser) { result in
            
            switch result {
                case .success(let modelUser):
                    self.view?.updateView(username: modelUser.username)
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
    
    func toRequestChat(chat: ChatModel) {
        
        router.toRequestChat(chat: chat)
    }
    
    func toConversationScreen(chat: ChatModel, user: UserModel) {
        
        router.toConversationScreen(chat: chat, user: user)
    }
}

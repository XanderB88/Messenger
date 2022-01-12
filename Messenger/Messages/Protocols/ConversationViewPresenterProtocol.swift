//
//  ConversationViewPresenterProtocol.swift
//  Messenger
//
//  Created by Alexander on 11.01.2022.
//

import Foundation
import FirebaseFirestore

protocol ConversationViewPresenterProtocol: AnyObject {
    
    init(view: ConversationViewProtocol,firebaseFirestore: FireStoreServiceProtocol, listenerService: ListenerServiceProtocol)
    func getMessageListener(chat: ChatModel) -> ListenerRegistration? 
    func sendMessage(chat: ChatModel, message: MessageModel, currentUser: UserModel)
}

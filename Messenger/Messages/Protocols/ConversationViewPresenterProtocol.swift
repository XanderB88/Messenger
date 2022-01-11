//
//  ConversationViewPresenterProtocol.swift
//  Messenger
//
//  Created by Alexander on 11.01.2022.
//

import Foundation

protocol ConversationViewPresenterProtocol: AnyObject {
    
    init(view: ConversationViewProtocol,firebaseFirestore: FireStoreServiceProtocol)
    func sendMessage(chat: ChatModel, message: MessageModel, currentUser: UserModel)
}

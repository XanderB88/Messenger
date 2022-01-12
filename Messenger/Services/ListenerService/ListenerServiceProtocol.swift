//
//  ListenerServiceProtocol.swift
//  Messenger
//
//  Created by Alexander on 19.12.2021.
//

import Foundation
import FirebaseFirestore

protocol ListenerServiceProtocol {
    
    func usersObserve(users: [UserModel], completion: @escaping (Result<[UserModel], Error>) -> Void) -> ListenerRegistration?
    func waitingChatsObserve(chats: [ChatModel], completion: @escaping (Result<[ChatModel], Error>) -> Void) -> ListenerRegistration?
    func activeChatsObserve(chats: [ChatModel], completion: @escaping (Result<[ChatModel], Error>) -> Void) -> ListenerRegistration?
    func messagesObserve(chat: ChatModel, completion: @escaping (Result<MessageModel, Error>) -> Void) -> ListenerRegistration?
}

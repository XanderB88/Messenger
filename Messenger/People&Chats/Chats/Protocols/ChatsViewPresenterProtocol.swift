//
//  ChatsViewPresenterProtocol.swift
//  Messenger
//
//  Created by Alexander on 13.12.2021.
//

import Foundation
import FirebaseFirestore

protocol ChatsViewPresenterProtocol: AnyObject {
    
    init(view: ChatsViewProtocol, authenticationService: AuthenticationServiceProtocol, fireStoreService: FireStoreServiceProtocol, router: RouterAuthenticationProtocol, listenerService: ListenerServiceProtocol)
    var chatListener: ListenerRegistration? { get }
    func getUsername()
    func toRequestChat(chat: ChatModel)
}

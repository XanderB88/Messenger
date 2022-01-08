//
//  ChatsViewPresenterProtocol.swift
//  Messenger
//
//  Created by Alexander on 13.12.2021.
//

import Foundation
import FirebaseFirestore
import UIKit

protocol ChatsViewPresenterProtocol: AnyObject {
    
    init(view: ChatsViewProtocol, authenticationService: AuthenticationServiceProtocol, fireStoreService: FireStoreServiceProtocol, router: RouterAuthenticationProtocol, listenerService: ListenerServiceProtocol)
    var waitingChatListener: ListenerRegistration? { get }
    var activeChatListener: ListenerRegistration? { get }
    func getUsername()
    func toRequestChat(chat: ChatModel)
    func toConversationScreen(navigationController: UINavigationController, chat: ChatModel, user: UserModel)
}

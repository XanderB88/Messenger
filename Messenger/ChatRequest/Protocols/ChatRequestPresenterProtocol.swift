//
//  ChatRequestPresenterProtocol.swift
//  Messenger
//
//  Created by Alexander on 31.12.2021.
//

import Foundation

protocol ChatRequestPresenterProtocol: AnyObject {
    
    init(authenticationService: AuthenticationServiceProtocol, fireStoreService: FireStoreServiceProtocol)
    func removeWaitingChats(chat: ChatModel)
}

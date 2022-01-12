//
//  ConversationViewProtocol.swift
//  Messenger
//
//  Created by Alexander on 11.01.2022.
//

import Foundation

protocol ConversationViewProtocol: AnyObject {
    
    func updateView()
    func updateMessages(message: MessageModel)
}

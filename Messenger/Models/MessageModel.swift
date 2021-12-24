//
//  MessageModel.swift
//  Messenger
//
//  Created by Alexander on 24.12.2021.
//

import Foundation

struct MessageModel: Hashable {
    
    let content: String
    let senderId: String
    let senderUsername: String
    var date: Date
    let id: String?
    
    var representation: [String: Any] {
       
        let represent: [String: Any] = [
        
            "content": content,
            "senderId": senderId,
            "senderUsername": senderUsername,
            "created": date
        ]
       
        return represent
    }
    
    init(user: UserModel, content: String) {
        
        self.content = content
        
        senderId = user.id
        senderUsername = user.username
        date = Date()
        id = nil
    }
}

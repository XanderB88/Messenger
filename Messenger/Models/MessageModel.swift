//
//  MessageModel.swift
//  Messenger
//
//  Created by Alexander on 24.12.2021.
//

import Foundation
import FirebaseFirestore

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
   
    init?(document: QueryDocumentSnapshot) {
        
        let data = document.data()
        
        guard let content = data["content"] as? String,
              let date = data["created"] as? Timestamp,
              let senderId = data["senderId"] as? String,
              let senderUsername = data["senderUsername"] as? String
        else { return nil }
        
        self.id = document.documentID
        self.content = content
        self.senderId = senderId
        self.senderUsername = senderUsername
        self.date = date.dateValue()
    }
}

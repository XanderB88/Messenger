//
//  MessageModel.swift
//  Messenger
//
//  Created by Alexander on 24.12.2021.
//

import Foundation
import FirebaseFirestore
import MessageKit

struct MessageModel: Hashable, MessageType {
    
    let content: String
    let id: String?
    var sender: SenderType
    var kind: MessageKind {
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.secondaryFont!
                ]
                let attributedContent = NSAttributedString.init(string: content, attributes: attributes)
        return .attributedText(attributedContent)
    }
    var sentDate: Date
    var messageId: String {
        return id ?? UUID().uuidString
    }

    var representation: [String: Any] {
       
        let represent: [String: Any] = [
        
            "content": content,
            "senderId": sender.senderId,
            "senderUsername": sender.displayName,
            "created": sentDate
        ]
       
        return represent
    }
    
    init(user: UserModel, content: String) {
        
        self.content = content
        sender = Sender(senderId: user.id, displayName: user.username)
        sentDate = Date()
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
        sender = Sender(senderId: senderId, displayName: senderUsername)
        self.sentDate = date.dateValue()
    }
  
    func hash(into hasher: inout Hasher) {
        hasher.combine(messageId)
    }
    
    static func == (lhs: MessageModel, rhs: MessageModel) -> Bool {
        return lhs.messageId == rhs.messageId
    }
}

extension MessageModel: Comparable {
   
    static func < (lhs: MessageModel, rhs: MessageModel) -> Bool {
        
        return lhs.sentDate < rhs.sentDate
    }
}

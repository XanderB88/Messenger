//
//  ChatModel.swift
//  Messenger
//
//  Created by Alexander on 22.11.2021.
//

import Foundation
import FirebaseFirestore

struct ChatModel: Hashable, Decodable {
    
    var friendUsername: String
    var friendUserImageUrl: String
    var friendLastMessage: String
    var friendUserId: String
    
    
    var representation: [String: Any] {
        
        var represent = ["friendUsername": friendUsername]
        represent["friendUserImageUrl"] = friendUserImageUrl
        represent["lastMessage"] = friendLastMessage
        represent["friendUserId"] = friendUserId
        
        return represent
    }
    
    init(friendUsername: String, friendUserImageUrl: String, friendLastMessage: String, friendUserId: String) {
        
        self.friendUsername = friendUsername
        self.friendUserImageUrl = friendUserImageUrl
        self.friendLastMessage = friendLastMessage
        self.friendUserId = friendUserId
    }
    
    init?(document: QueryDocumentSnapshot) {
        
        let data = document.data()
        
        guard let friendUsername = data["friendUsername"] as? String,
              let friendUserImageUrl = data["friendUserImageUrl"] as? String,
              let friendLastMessage = data["lastMessage"] as? String,
              let friendUserId = data["friendUserId"] as? String
        else { return nil }
        
        self.friendUsername = friendUsername
        self.friendUserImageUrl = friendUserImageUrl
        self.friendLastMessage = friendLastMessage
        self.friendUserId = friendUserId
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(friendUserId)
    }
    
    static func == (lhs: ChatModel, rhs: ChatModel) -> Bool {
        return lhs.friendUserId == rhs.friendUserId
    }
    
    func containsChatWithUser(filter: String?) -> Bool {
        
        guard let filter = filter else { return true }
        
        if filter.isEmpty { return true }
        
        return friendUsername.lowercased().contains(filter.lowercased())
    }
}

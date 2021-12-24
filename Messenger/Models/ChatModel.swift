//
//  ChatModel.swift
//  Messenger
//
//  Created by Alexander on 22.11.2021.
//

import Foundation

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

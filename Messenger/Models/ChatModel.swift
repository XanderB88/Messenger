//
//  ChatModel.swift
//  Messenger
//
//  Created by Alexander on 22.11.2021.
//

import Foundation

struct ChatModel: Hashable, Decodable {
    
    var username: String
    var userImageString: String
    var lastMessage: String
    var id: Int
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: ChatModel, rhs: ChatModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    func containsChatWithUser(filter: String?) -> Bool {
        
        guard let filter = filter else { return true }
        
        if filter.isEmpty { return true }
        
        return username.lowercased().contains(filter.lowercased())
    }
}

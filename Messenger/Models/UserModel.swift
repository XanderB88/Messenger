//
//  UserModel.swift
//  Messenger
//
//  Created by Alexander on 27.11.2021.
//

import Foundation

struct UserModel: Hashable, Decodable {
    
    var username: String
    var userImageString: String
    var id: Int
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: UserModel, rhs: UserModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    func containsUser(filter: String?) -> Bool {
        
        guard let filter = filter else { return true }
        
        if filter.isEmpty { return true }
        
        return username.lowercased().contains(filter.lowercased())
    }
}

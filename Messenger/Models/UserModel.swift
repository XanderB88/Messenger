//
//  UserModel.swift
//  Messenger
//
//  Created by Alexander on 27.11.2021.
//

import Foundation
import FirebaseFirestore

struct UserModel: Hashable, Decodable {
    
    var username: String
    var email: String
    var description: String
    var gender: String
    var userImageString: String
    var id: String
    
    var representation: [String: Any] {
       
        var represent = ["username": username]
        represent["email"] = email
        represent["description"] = description
        represent["gender"] = gender
        represent["userImage"] = userImageString
        represent["uid"] = id
        
        return represent
    }
    
    init(username: String, email: String, description: String, gender: String, userImageString: String, id: String) {
        
        self.username = username
        self.email = email
        self.description = description
        self.gender = gender
        self.userImageString = userImageString
        self.id = id
    }
    
    init?(document: DocumentSnapshot) {
        
        guard let data = document.data() else { return nil }
        
        guard let username = data["username"] as? String,
              let email = data["email"] as? String,
              let description = data["description"] as? String,
              let gender = data["gender"] as? String,
              let userImageString = data["userImage"] as? String,
              let id = data["uid"] as? String else { return nil }
        
        self.username = username
        self.email = email
        self.description = description
        self.gender = gender
        self.userImageString = userImageString
        self.id = id
    }
    
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

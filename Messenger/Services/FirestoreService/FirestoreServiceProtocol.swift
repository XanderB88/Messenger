//
//  FirestoreServiceProtocol.swift
//  Messenger
//
//  Created by Alexander on 07.12.2021.
//

import Foundation

protocol FireStoreServiceProtocol: AnyObject {
    
    func saveProfileWith(id: String, email: String, username: String?, userImageString: String?, description: String?, gender: String?, completion: @escaping (Result<UserModel, Error>) -> Void)
}

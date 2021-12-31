//
//  FirestoreServiceProtocol.swift
//  Messenger
//
//  Created by Alexander on 07.12.2021.
//

import Foundation
import Firebase
import SwiftUI

protocol FireStoreServiceProtocol: AnyObject {
    
    func saveProfileWith(id: String, email: String, username: String?, userImageData: Data?, description: String?, gender: String?, completion: @escaping (Result<UserModel, Error>) -> Void)
    func getUserData(user: User, completion: @escaping (Result<UserModel, Error>) -> Void)
    func createWaitingChat(message: String, receiver: UserModel, currentUser: UserModel, completion: @escaping (Result<Void, Error>) -> Void)
    func removeWaitingChat(chat: ChatModel, currentUser: User, completion: @escaping (Result<Void, Error>) -> Void)
}

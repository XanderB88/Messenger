//
//  FirestoreService.swift
//  Messenger
//
//  Created by Alexander on 07.12.2021.
//

import Foundation
import Firebase
import FirebaseFirestore
import SwiftUI

class FirestoreService: FireStoreServiceProtocol {
    
    private let db = Firestore.firestore()
    private let validator: ValidatorProtocol!
    private let storageService: StorageServiceProtocol!
    
    var currentUser: UserModel!
    
    private var userRef: CollectionReference {
       
        return db.collection("users")
    }
    
    required init(validator: ValidatorProtocol, storageService: StorageServiceProtocol) {
        
        self.validator = validator
        self.storageService = storageService
    }
    
    func saveProfileWith(id: String, email: String, username: String?, userImageData: Data?, description: String?, gender: String?, completion: @escaping (Result<UserModel, Error>) -> Void) {
        
        guard validator.isFilledUser(username: username, description: description, gender: gender) else {
            
            completion(.failure(UserError.fieldsIsNotFilled))
           
            return
        }
        
        
        var user = UserModel(username: username!,
                             email: email,
                             description: description!,
                             gender: gender!,
                             userImageUrl: "",
                             id: id)
        
        storageService.upload(imageData: userImageData) { result in
            
            switch result {
                    
                case .success(let url):
                    
                    user.userImageUrl = url.absoluteString
                    
                    self.userRef.document(user.id).setData(user.representation) { error in
                        
                        if let error = error {
                            
                            completion(.failure(error))
                        } else {
                            
                            completion(.success(user))
                        }
                    }
                
                case .failure(let error):
                    
                    completion(.failure(error))
            }
        }
    }
 
    func getUserData(user: User, completion: @escaping (Result<UserModel, Error>) -> Void) {
        
        let docRef = userRef.document(user.uid)
        docRef.getDocument { document, error in
            
            if let document = document, document.exists {
                
                guard let user = UserModel(document: document) else {
                    
                    completion(.failure(UserError.cannotUnwrapToUserModel))
                    return
                }
                self.currentUser = user
                completion(.success(user))
            } else {
                
                completion(.failure(UserError.cannotGetUserInfo))
            }
        }
    }
    
    func createWaitingChat(message: String, receiver: UserModel, completion: @escaping (Result<Void, Error>) -> Void) {
        
        let reference = db.collection(["users", receiver.id, "waitingChats"].joined(separator: "/"))
        let messageRef = reference.document(self.currentUser.id).collection("messages")
        
        let message = MessageModel(user: currentUser, content: message)
        let chat = ChatModel(friendUsername: currentUser.username,
                             friendUserImageUrl: currentUser.userImageUrl,
                             friendLastMessage: message.content,
                             friendUserId: currentUser.id)
        
        reference.document(currentUser.id).setData(chat.representation) { error in
            
            if let error = error {
                
                completion(.failure(error))
                return
            }
            
            messageRef.addDocument(data: message.representation) { error in
                
                if let error = error {
                    
                    completion(.failure(error))
                    return
                }
                completion(.success(Void()))
            }
        }
    }
}

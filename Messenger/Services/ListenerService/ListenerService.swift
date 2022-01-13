//
//  ListenerService.swift
//  Messenger
//
//  Created by Alexander on 19.12.2021.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class ListenerService: ListenerServiceProtocol {
    
    
    private let db = Firestore.firestore()
    
    private var userRef: CollectionReference {
        
        return db.collection("users")
    }
    
    private var currentUserId: String {
        return Auth.auth().currentUser!.uid
    }
    
    private var waitingChatRef: CollectionReference {
        
        return db.collection(["users", currentUserId, "waitingChats"].joined(separator: "/"))
    }
    
    private var activeChatRef: CollectionReference {
        
        return db.collection(["users", currentUserId, "activeChats"].joined(separator: "/"))
    }
    
    func usersObserve(users: [UserModel], completion: @escaping (Result<[UserModel], Error>) -> Void) -> ListenerRegistration? {
        
        var users = users
        
        let userListener = userRef.addSnapshotListener { querySnapshot, error in
            
            guard let snapshot = querySnapshot else {
                
                completion(.failure(error!))
                return
            }
            
            snapshot.documentChanges.forEach { diff in
                
                guard let modelUser = UserModel(document: diff.document) else { return }
                
                switch diff.type {
                    case .added:
                        guard !users.contains(modelUser) else { return }
                        guard  modelUser.id != self.currentUserId else { return }
                        users.append(modelUser)
                        
                    case .modified:
                        guard let index = users.firstIndex(of: modelUser) else { return }
                        users[index] = modelUser
                    case .removed:
                        guard let index = users.firstIndex(of: modelUser) else { return }
                        users.remove(at: index)
                }
            }
            
            completion(.success(users))
        }
        
        return userListener
    }
    
    func waitingChatsObserve(chats: [ChatModel], completion: @escaping (Result<[ChatModel], Error>) -> Void) -> ListenerRegistration? {
        
        var chats = chats
        
        let waitingChatListener = waitingChatRef.addSnapshotListener { querySnapshot, error in
            
            guard let snapshot = querySnapshot else {
                
                completion(.failure(error!))
                return
            }
            
            snapshot.documentChanges.forEach { diff in
                
                guard let modelChat = ChatModel(document: diff.document) else { return }
                
                switch diff.type {
                    case .added:
                        guard !chats.contains(modelChat) else { return }
                        chats.append(modelChat)
                    case .modified:
                        guard let index = chats.firstIndex(of: modelChat) else { return }
                        chats[index] = modelChat
                    case .removed:
                        guard let index = chats.firstIndex(of: modelChat) else { return }
                        chats.remove(at: index)
                }
            }
            
            completion(.success(chats))
        }
        
        return waitingChatListener
    }
    
    func activeChatsObserve(chats: [ChatModel], completion: @escaping (Result<[ChatModel], Error>) -> Void) -> ListenerRegistration? {
        
        var chats = chats
        
        let activeChatListener = activeChatRef.addSnapshotListener { querySnapshot, error in
            
            guard let snapshot = querySnapshot else {
                
                completion(.failure(error!))
                return
            }
            
            snapshot.documentChanges.forEach { diff in
                
                guard let modelChat = ChatModel(document: diff.document) else { return }
                
                switch diff.type {
                    case .added:
                        guard !chats.contains(modelChat) else { return }
                        chats.append(modelChat)
                    case .modified:
                        guard let index = chats.firstIndex(of: modelChat) else { return }
                        chats[index] = modelChat
                    case .removed:
                        guard let index = chats.firstIndex(of: modelChat) else { return }
                        chats.remove(at: index)
                }
            }
            
            completion(.success(chats))
        }
        
        return activeChatListener
    }
    
    func messagesObserve(chat: ChatModel, completion: @escaping (Result<MessageModel, Error>) -> Void) -> ListenerRegistration? {
        
        let messagesRef = userRef.document(currentUserId).collection("activeChats").document(chat.friendUserId).collection("messages")
        
        let messagesListener = messagesRef.addSnapshotListener { querySnapshot, error in
            
            guard let snapshot = querySnapshot else {
                
                completion(.failure(error!))
                return
            }
            
            snapshot.documentChanges.forEach { diff in
                
                guard let modalMessage = MessageModel(document: diff.document) else { return }
                
                switch diff.type {
                    case .added:
                        completion(.success(modalMessage))
                    case .modified:
                        break
                    case .removed:
                        break
                }
            }
        }
        
        return messagesListener
    }
}

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
}

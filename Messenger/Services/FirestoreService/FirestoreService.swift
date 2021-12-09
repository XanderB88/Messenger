//
//  FirestoreService.swift
//  Messenger
//
//  Created by Alexander on 07.12.2021.
//

import Foundation
import Firebase
import FirebaseFirestore

class FirestoreService: FireStoreServiceProtocol {
   
    private let db = Firestore.firestore()
    private let validator: ValidatorProtocol
    
    private var userRef: CollectionReference {
        return db.collection("users")
    }
    
    required init(validator: ValidatorProtocol) {
        self.validator = validator
    }
    
    func saveProfileWith(id: String, email: String, username: String?, userImageString: String?, description: String?, gender: String?, completion: @escaping (Result<UserModel, Error>) -> Void) {
        
        guard validator.isFilledUser(username: username, description: description, gender: gender) else {
            
            completion(.failure(UserError.fieldsIsNotFilled))
           
            return
        }
        
        let user = UserModel(username: username!,
                             email: email,
                             description: description!,
                             gender: gender!,
                             userImageString: "doesn't exist",
                             id: id)
        
        self.userRef.document(user.id).setData(user.representation) { error in
            
            if let error = error {
                
                completion(.failure(error))
            } else {
                
                completion(.success(user))
            }
        }
    }
}

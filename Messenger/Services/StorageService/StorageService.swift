//
//  StorageService.swift
//  Messenger
//
//  Created by Alexander on 16.12.2021.
//

import Foundation
import FirebaseAuth
import FirebaseStorage

class StorageService: StorageServiceProtocol {
    
    private let storageRef = Storage.storage().reference()
    private let authentication = Auth.auth()
    
    private var avatarRef: StorageReference {
        
        return storageRef.child("avatars")
    }
    
    private var currentUserId: String {
       
        return authentication.currentUser!.uid
    }
    
    func upload(imageData: Data?, completion: @escaping (Result<URL, Error>) -> Void) {
        
        guard let imageData = imageData else { return }
        
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpeg"
        
        avatarRef.child(currentUserId).putData(imageData, metadata: metaData) { metaData, error in
            
            guard let _ = metaData else {
               
                completion(.failure(error!))
                return
            }
            
            self.avatarRef.child(self.currentUserId).downloadURL { url, error in
                guard let url = url else {
                 
                    completion(.failure(error!))
                    return
                }
                
                completion(.success(url))
            }
        }
    }
}

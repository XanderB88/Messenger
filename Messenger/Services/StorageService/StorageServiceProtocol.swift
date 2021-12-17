//
//  StorageServiceProtocol.swift
//  Messenger
//
//  Created by Alexander on 16.12.2021.
//

import Foundation
import FirebaseAuth
import FirebaseStorage

protocol StorageServiceProtocol: AnyObject {
    
    func upload(imageData: Data?, completion: @escaping (Result<URL, Error>) -> Void)
}

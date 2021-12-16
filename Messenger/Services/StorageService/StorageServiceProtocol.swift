//
//  StorageServiceProtocol.swift
//  Messenger
//
//  Created by Alexander on 16.12.2021.
//

import UIKit
import FirebaseAuth
import FirebaseStorage

protocol StorageServiceProtocol: AnyObject {
    
    func upload(image: UIImage, completion: @escaping (Result<URL, Error>) -> Void)
}

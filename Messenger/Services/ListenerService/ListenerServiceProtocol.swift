//
//  ListenerServiceProtocol.swift
//  Messenger
//
//  Created by Alexander on 19.12.2021.
//

import Foundation
import FirebaseFirestore

protocol ListenerServiceProtocol {
    
    func usersObserve(users: [UserModel], completion: @escaping (Result<[UserModel], Error>) -> Void) -> ListenerRegistration?
}

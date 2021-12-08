//
//  AuthenticationServiceProtocol.swift
//  Messenger
//
//  Created by Alexander on 02.12.2021.
//

import Foundation
import Firebase
import FirebaseAuth

protocol AuthenticationServiceProtocol: AnyObject {
    
    func getCurrentUser() -> User?
    func register(email: String?, password: String?, confirmPassword: String?, completion: @escaping (Result<User, Error>) -> Void)
    func login(email: String?, password: String?, completion: @escaping (Result<User, Error>) -> Void)
}

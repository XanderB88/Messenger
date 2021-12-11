//
//  AuthenticationService.swift
//  Messenger
//
//  Created by Alexander on 02.12.2021.
//

import Foundation
import Firebase
import FirebaseAuth

class AuthenticationService: AuthenticationServiceProtocol {
    
    private let authentication = Auth.auth()
    private let validator: ValidatorProtocol
    
    init (validator: ValidatorProtocol) {
        self.validator = validator
    }
    
    func getCurrentUser() -> User? {
        
        return Auth.auth().currentUser
    }
    
    func register(email: String?, password: String?, confirmPassword: String?, completion: @escaping (Result<User, Error>) -> Void) {
        
        guard validator.isFilled(email: email, password: password, confirmPassword: confirmPassword) else {
            
            completion(.failure(AuthenticationError.fieldsIsNotFilled))
            return
        }
        
        guard validator.isValidEmail(email: email!) else {
           
            completion(.failure(AuthenticationError.invalidEmail))
            return
        }
        
        guard validator.isPasswordHasNumberAndCharacter(password: password!) else {
           
            completion(.failure(AuthenticationError.invalidPassword))
            return
        }
        
        guard password! == confirmPassword! else {
           
            completion(.failure(AuthenticationError.passwordsIsNotMatched))
            return
        }
        
        authentication.createUser(withEmail: email!, password: password!) { result, error in
            
            guard let result = result else {
               
                completion(.failure(error!))
                return
            }
            
            completion(.success(result.user))
        }
    }
    
    func login(email: String?, password: String?, completion: @escaping (Result<User, Error>) -> Void) {
        
        guard let email = email,
              let password = password
        else {
            completion(.failure(AuthenticationError.fieldsIsNotFilled))
            return
        }
        
        authentication.signIn(withEmail: email, password: password) { result, error in
            
            guard let result = result else {
                
                completion(.failure(error!))
                return
            }
            
            completion(.success(result.user))
        }
    }
    
    func logout(completion: @escaping () -> Void) {
        
        do {
            try authentication.signOut()
            completion()
        } catch {
            print(error.localizedDescription)
        }
    }
}

//
//  ChatsViewPresenterProtocol.swift
//  Messenger
//
//  Created by Alexander on 13.12.2021.
//

import Foundation

protocol ChatsViewPresenterProtocol: AnyObject {
    
    init(view: ChatsViewProtocol, authenticationService: AuthenticationServiceProtocol, fireStoreService: FireStoreServiceProtocol, router: RouterAuthenticationProtocol)
    func getUsername()
}

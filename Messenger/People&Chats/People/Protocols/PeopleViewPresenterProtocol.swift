//
//  PeopleViewPresenterProtocol.swift
//  Messenger
//
//  Created by Alexander on 09.12.2021.
//

import Foundation
import FirebaseFirestore

protocol PeopleViewPresenterProtocol: AnyObject {
    
    init (view: PeopleViewProtocol, authenticationService: AuthenticationServiceProtocol, router: RouterAuthenticationProtocol, fireStoreService: FireStoreServiceProtocol, listenerService: ListenerServiceProtocol)
    var userListener: ListenerRegistration? { get }
    func getUsername()
    func toProfileScreen(user: UserModel)
}

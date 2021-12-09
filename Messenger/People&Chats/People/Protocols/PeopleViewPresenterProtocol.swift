//
//  PeopleViewPresenterProtocol.swift
//  Messenger
//
//  Created by Alexander on 09.12.2021.
//

import Foundation

protocol PeopleViewPresenterProtocol: AnyObject {
    
    init (view: PeopleViewProtocol, authenticationService: AuthenticationServiceProtocol, router: RouterAuthenticationProtocol)
    func logOutButtonPressed()
    func popToRoot()
}

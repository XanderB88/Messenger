//
//  PeopleViewProtocol.swift
//  Messenger
//
//  Created by Alexander on 09.12.2021.
//

import Foundation

protocol PeopleViewProtocol: AnyObject {
    
    func updateView(username: String)
    func updateUsers(users: [UserModel])
}

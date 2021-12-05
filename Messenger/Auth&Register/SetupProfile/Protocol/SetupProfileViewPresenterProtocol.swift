//
//  SetupProfileViewPresenterProtocol.swift
//  Messenger
//
//  Created by Alexander on 05.12.2021.
//

import Foundation

protocol SetupProfileViewPresenterProtocol: AnyObject {
    
    init(router: RouterAuthenticationProtocol)
    func pressedGoToChatButton()
}

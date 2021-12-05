//
//  SetupProfileViewPresenter.swift
//  Messenger
//
//  Created by Alexander on 05.12.2021.
//

import Foundation

class SetupProfileViewPresenter: SetupProfileViewPresenterProtocol {
   
    let router: RouterAuthenticationProtocol?
    
    required init(router: RouterAuthenticationProtocol) {
       
        self.router = router
    }
    
    func pressedGoToChatButton() {
       
    }
}

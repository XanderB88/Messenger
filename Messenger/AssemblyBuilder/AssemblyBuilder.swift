//
//  AssemblyBuilder.swift
//  Messenger
//
//  Created by Alexander on 03.12.2021.
//

import UIKit

class AssemblyBuilder: AssemblyBuilderProtocol {
   
    func createAuthenticationScreen(router: RouterAuthenticationProtocol) -> UIViewController {
        
        let view = AuthenticationViewController()
    
        let presenter = AuthenticationViewPresenter(router: router)
        view.presenter = presenter
     
        return view
    }
    
    
    func createEmailRegistrationScreen(router: RouterAuthenticationProtocol) -> UIViewController {
        
        let view = EmailRegistrationViewController()
        let validator = Validator()
        let authenticationService = AuthenticationService(validator: validator)
       
        let presenter = EmailRegistrationViewPresenter(view: view, authenticationService: authenticationService, router: router)
        view.presenter = presenter
       
        return view
    }
    
    func createLoginScreen(router: RouterAuthenticationProtocol) -> UIViewController {
        
        let view = LoginViewController()
        let validator = Validator()
        let authenticationService = AuthenticationService(validator: validator)
        
        let presenter = LoginViewPresenter(view: view, authenticationService: authenticationService, router: router)
        view.presenter = presenter
        
        return view
    }
}

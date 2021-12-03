//
//  AssemblyBuilder.swift
//  Messenger
//
//  Created by Alexander on 03.12.2021.
//

import UIKit

class AssemblyBuilder: AssemblyBuilderProtocol {
  
    func createEmailRegistrationScreen() -> UIViewController {
        
        let view = EmailRegistrationViewController()
        let validator = Validator()
        let authenticationService = AuthenticationService(validator: validator)
       
        let presenter = EmailRegistrationPresenter(view: view, authenticationService: authenticationService)
        view.presenter = presenter
       
        return view
    }
}

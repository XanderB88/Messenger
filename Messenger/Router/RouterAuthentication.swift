//
//  RouterAuthentication.swift
//  Messenger
//
//  Created by Alexander on 04.12.2021.
//

import UIKit
import FirebaseAuth

class RouterAuthentication: RouterAuthenticationProtocol {

    var window: UIWindow?
    var assemblyBuilder: AssemblyBuilderProtocol?
    var authenticationService: AuthenticationService!
    
    required init(window: UIWindow?, assemblyBuilder: AssemblyBuilderProtocol, authenticationService: AuthenticationService) {
       
        self.window = window
        self.assemblyBuilder = assemblyBuilder
        self.authenticationService = authenticationService
    }
    
    func initialAuthenticationScreen() {
        
        if let window = self.window {
            
            if (authenticationService.getCurrentUser() != nil) {
                
                guard let peopleAndChatsTabBarController = self.assemblyBuilder?.createPeopleAndChatsTabBarController(router: self) else { return }
                
                window.rootViewController = peopleAndChatsTabBarController
            } else {
                
                guard let authenticationScreen = assemblyBuilder?.createAuthenticationScreen(router: self) else { return }
                
                window.rootViewController = authenticationScreen
            }
        }
    }
    
    func toLoginScreen() {
       
        if let window = window {
            
        guard let loginScreen = assemblyBuilder?.createLoginScreen(router: self) else { return }
        
        window.rootViewController?.present(loginScreen, animated: true, completion: nil)
        }
    }
    
    func toEmailRegistrationScreen() {
        
        if let window = window {
            
        guard let emailRegistrationScreen = assemblyBuilder?.createEmailRegistrationScreen(router: self) else { return }
        
        window.rootViewController?.present(emailRegistrationScreen, animated: true, completion: nil)
        }
    }
    
    func toSetupProfileScreen() {
        
        if let window = window {
            
        guard let setupProfileScreen = assemblyBuilder?.createSetupProfileScreen(router: self) else { return }
        
        window.rootViewController?.present(setupProfileScreen, animated: true, completion: nil)
        }
    }
    
    func toPeopleAndChatsTabBarController() {
        
        if let window = window {
            
            guard let peopleAndChatsTabBarController = assemblyBuilder?.createPeopleAndChatsTabBarController(router: self) else { return }
        
        window.rootViewController?.present(peopleAndChatsTabBarController, animated: true, completion: nil)
        }
    }
}

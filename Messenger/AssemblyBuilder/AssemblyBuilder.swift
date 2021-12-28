//
//  AssemblyBuilder.swift
//  Messenger
//
//  Created by Alexander on 03.12.2021.
//

import UIKit
import FirebaseAuth

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
    
    func createSetupProfileScreen(router: RouterAuthenticationProtocol) -> UIViewController {
        
        let view = SetupProfileViewController()
        let validator = Validator()
        let storageService = StorageService()
        let fireStoreService = FirestoreService(validator: validator, storageService: storageService)
        let authenticationService = AuthenticationService(validator: validator)
        
        let presenter = SetupProfileViewPresenter(view: view, fireStoreService: fireStoreService, authenticationService: authenticationService, router: router)
        
        view.presenter = presenter

        return view
    }
    
    func createPeopleAndChatsTabBarController(router: RouterAuthenticationProtocol) -> UIViewController {
        
        let view = PeopleAndChatsTabBarController()
        let peopleView = PeopleViewController()
        let chatsView = ChatsViewController()
        let configProfileView = ConfigurationProfileViewController()
        
        let peopleIcon = UIImage(systemName: "person.3", withConfiguration: UIImage.SymbolConfiguration(weight: .medium))!
        let chatsIcon = UIImage(systemName: "captions.bubble", withConfiguration: UIImage.SymbolConfiguration(weight: .medium))!
        let profileIcon = UIImage(systemName: "person.crop.circle", withConfiguration: UIImage.SymbolConfiguration(weight: .medium))!

        view.viewControllers = [
            view.generateNavigationControllers(rootViewController: peopleView, title: "People", image: peopleIcon),
            view.generateNavigationControllers(rootViewController: chatsView, title: "Chats", image: chatsIcon),
            view.generateNavigationControllers(rootViewController: configProfileView, title: "Profile", image: profileIcon)
        ]
        
        view.selectedIndex = 1
       
        let validator = Validator()
        let storageService = StorageService()
        let authenticationService = AuthenticationService(validator: validator)
        let fireStoreService = FirestoreService(validator: validator, storageService: storageService)
        let listenerService = ListenerService()
       
        let peopleViewPresenter = PeopleViewPresenter(view: peopleView, authenticationService: authenticationService, router: router, fireStoreService: fireStoreService, listenerService: listenerService)
        
        peopleView.presenter = peopleViewPresenter
        
        let chatsViewPresenter = ChatsViewPresenter(view: chatsView, authenticationService: authenticationService, fireStoreService: fireStoreService, router: router, listenerService: listenerService)
        
        chatsView.presenter = chatsViewPresenter
        
        let profileViewPresenter = ConfigurationProfileViewPresenter(view: configProfileView, fireStoreService: fireStoreService, authenticationService: authenticationService, router: router)
        
        configProfileView.presenter = profileViewPresenter
        
        view.modalPresentationStyle = .fullScreen
        
        return view
    }
    
    func createProfileScreen(router: RouterAuthenticationProtocol, user: UserModel, currentUser: UserModel) -> UIViewController {
        
        let view = ProfileViewController(user: user)
        let validator = Validator()
        let storageService = StorageService()
        let fireStoreService = FirestoreService(validator: validator, storageService: storageService)
        
        let profilePresenter = ProfileViewPresenter(view: view, fireStoreService: fireStoreService, router: router)
        
        view.presenter = profilePresenter
        view.currentUser = currentUser
       
        return view
    }
}

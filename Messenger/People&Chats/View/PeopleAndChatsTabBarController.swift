//
//  MainTabBarController.swift
//  Messenger
//
//  Created by Alexander on 20.11.2021.
//

import UIKit

class PeopleAndChatsTabBarController: UITabBarController {
    
    // MARK: - Icons for items
    let peopleIcon = UIImage(systemName: "person.3", withConfiguration: UIImage.SymbolConfiguration(weight: .medium))!
    let chatsIcon = UIImage(systemName: "captions.bubble", withConfiguration: UIImage.SymbolConfiguration(weight: .medium))!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let peopleViewController = PeopleViewController()
        let chatsViewController = ChatsViewController()
        
        viewControllers = [
            generateNavigationControllers(rootViewController: peopleViewController, title: "People", image: peopleIcon),
            generateNavigationControllers(rootViewController: chatsViewController, title: "Chats", image: chatsIcon)
        ]
    }
}

// MARK: - Generate navigation view controller
extension PeopleAndChatsTabBarController {
    
    func generateNavigationControllers(rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        
        let navigationViewController = UINavigationController(rootViewController: rootViewController)
        navigationViewController.tabBarItem.title = title
        
        let attributes : [NSAttributedString.Key: Any] = [.font: UIFont.tabBarItemFont!]
        navigationViewController.tabBarItem.setTitleTextAttributes(attributes, for: .normal)
        navigationViewController.tabBarItem.image = image
        
        tabBar.tintColor = .mainWhite
        tabBar.barTintColor = .mainDark
      
        return navigationViewController
    }
}

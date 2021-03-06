//
//  MainTabBarController.swift
//  Messenger
//
//  Created by Alexander on 20.11.2021.
//

import UIKit

class PeopleAndChatsTabBarController: UITabBarController {
    
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


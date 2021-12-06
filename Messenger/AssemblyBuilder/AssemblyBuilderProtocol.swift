//
//  AssemblyBuilderProtocol.swift
//  Messenger
//
//  Created by Alexander on 03.12.2021.
//

import UIKit

protocol AssemblyBuilderProtocol {
   
    func createAuthenticationScreen(router: RouterAuthenticationProtocol) -> UIViewController
    func createEmailRegistrationScreen(router: RouterAuthenticationProtocol) -> UIViewController
    func createLoginScreen(router: RouterAuthenticationProtocol) -> UIViewController
    func createSetupProfileScreen(router: RouterAuthenticationProtocol) -> UIViewController
    func createPeopleAndChatsTabBarController() -> UIViewController
}

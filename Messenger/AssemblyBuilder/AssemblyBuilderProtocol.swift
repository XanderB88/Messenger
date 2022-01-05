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
    func createPeopleAndChatsTabBarController(router: RouterAuthenticationProtocol) -> UIViewController
    func createProfileScreen(router: RouterAuthenticationProtocol, user: UserModel, currentUser: UserModel) -> UIViewController
    func createRequestChat(router: RouterAuthenticationProtocol, chat: ChatModel) -> UIViewController
    func createConversationScreen(router: RouterAuthenticationProtocol, chat: ChatModel, user: UserModel) -> UIViewController
}

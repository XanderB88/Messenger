//
//  RouterAuthenticationProtocol.swift
//  Messenger
//
//  Created by Alexander on 04.12.2021.
//

import UIKit

protocol RouterAuthenticationProtocol: RouterProtocol {
    
    func initialAuthenticationScreen()
    func toLoginScreen()
    func toEmailRegistrationScreen()
    func toSetupProfileScreen()
    func toPeopleAndChatsTabBarController()
    func toProfileScreen(user: UserModel, currentUser: UserModel)
    func toRequestChat(chat: ChatModel)
    func toConversationScreen(navigationController: UINavigationController, chat: ChatModel, user: UserModel)
}

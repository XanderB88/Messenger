//
//  ConversationViewController.swift
//  Messenger
//
//  Created by Alexander on 05.01.2022.
//

import Foundation
import MessageKit

class ConversationViewController: MessagesViewController {
    
    private var messages = [MessageModel]()
    
    private let user: UserModel
    private let chat: ChatModel
    
    init(user: UserModel, chat: ChatModel) {
        
        self.user = user
        self.chat = chat
        super.init(nibName: nil, bundle: nil)
        
        title = chat.friendUsername
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ConversationViewController: MessagesDataSource {
    
    func currentSender() -> SenderType {
        
        return Sender(senderId: user.id, displayName: user.username)
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        
        return messages[indexPath.item]
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        
        return 1
    }
}

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
        messagesCollectionView.collectionViewLayout.collectionView?.backgroundColor = .mainDark

        setupMessageInputBar()
        setupSendButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let navigationBar = self.navigationController?.navigationBar
        navigationBar?.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.mainWhite]
        print(navigationItem.hidesBackButton)
    }
}

extension ConversationViewController {
    
    func setupMessageInputBar() {
        
        messageInputBar.isTranslucent = true
        messageInputBar.separatorLine.isHidden = true
        messageInputBar.backgroundView.backgroundColor = .mainDark
        messageInputBar.inputTextView.backgroundColor = .mainDark
        messageInputBar.inputTextView.placeholderTextColor = .mainWhite
        messageInputBar.inputTextView.textContainerInset = UIEdgeInsets(top: 14, left: 14, bottom: 30, right: 36)
        messageInputBar.inputTextView.placeholderLabelInsets = UIEdgeInsets(top: 14, left: 14, bottom: 36, right: 36)
        messageInputBar.inputTextView.layer.borderColor = UIColor.mainWhite.cgColor
        messageInputBar.inputTextView.layer.borderWidth = 0.2
        messageInputBar.inputTextView.layer.cornerRadius = 18
        messageInputBar.inputTextView.layer.masksToBounds = true
        messageInputBar.inputTextView.scrollIndicatorInsets = UIEdgeInsets(top: 14, left: 0, bottom: 14, right: 0)
        
        messageInputBar.layer.shadowColor = UIColor.mainDark.cgColor
        messageInputBar.layer.shadowRadius = 5
        messageInputBar.layer.opacity = 0.3
        messageInputBar.layer.shadowOffset = CGSize(width: 0, height: 4)
    }
    
    func setupSendButton() {
        
        messageInputBar.sendButton.setImage(UIImage(systemName: "arrowshape.turn.up.forward.circle"), for: .normal)
        messageInputBar.sendButton.addGradient(cornerRadius: 18)
        messageInputBar.setRightStackViewWidthConstant(to: 56, animated: false)
        messageInputBar.sendButton.tintColor = .mainBlue
        messageInputBar.sendButton.contentEdgeInsets = UIEdgeInsets(top: 2, left: 2, bottom: 6, right: 29)
        messageInputBar.sendButton.setSize(CGSize(width: 48, height: 48), animated: false)
        messageInputBar.middleContentViewPadding.right = -54
    }
}

// MARK: - Messages Data Source
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

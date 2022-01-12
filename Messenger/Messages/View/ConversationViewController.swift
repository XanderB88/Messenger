//
//  ConversationViewController.swift
//  Messenger
//
//  Created by Alexander on 05.01.2022.
//

import Foundation
import FirebaseFirestore
import MessageKit
import InputBarAccessoryView

class ConversationViewController: MessagesViewController {
    
    private var messages = [MessageModel]()
    
    private let user: UserModel
    private let chat: ChatModel
    
    var presenter: ConversationViewPresenterProtocol!
    var messagesListener: ListenerRegistration?
    
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
        
        messageInputBar.delegate = self
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        
        messagesListener = presenter.getMessageListener(chat: chat)
        
        setupCollectionView()
        setupMessageInputBar()
        setupSendButton()
    }
    
    deinit {
        
        messagesListener?.remove()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.standardAppearance.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont.secondaryFont!]
        
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    private func insertNewMessage(message: MessageModel) {
        
        guard !messages.contains(message) else { return }
        
        messages.append(message)
        messages.sort()
        
        messagesCollectionView.reloadData()
    }
}

// MARK: - Conversation View Protocol
extension ConversationViewController: ConversationViewProtocol {
    
    func updateView() {
        self.messagesCollectionView.scrollToLastItem()
    }
    
    func updateMessages(message: MessageModel) {
        
        self.insertNewMessage(message: message)
    }
}

extension ConversationViewController {
    
    func setupCollectionView() {
        guard let flowLayout = messagesCollectionView.collectionViewLayout as? MessagesCollectionViewFlowLayout else {
            return
        }
        flowLayout.collectionView?.backgroundColor = .mainDark
        flowLayout.setMessageIncomingAvatarSize(.init(width: 45, height: 45))
        flowLayout.setMessageOutgoingAvatarSize(.init(width: 45, height: 45))
    }
    
    func setupMessageInputBar() {
        
        messageInputBar.isTranslucent = true
        messageInputBar.separatorLine.isHidden = true
        messageInputBar.backgroundView.backgroundColor = .mainDark
        messageInputBar.inputTextView.backgroundColor = .mainDark
        messageInputBar.inputTextView.textColor = .white
        messageInputBar.inputTextView.placeholderTextColor = .secondaryWhite
        messageInputBar.inputTextView.textContainerInset = UIEdgeInsets(top: 24, left: 14, bottom: 22, right: 36)
        messageInputBar.inputTextView.placeholderLabelInsets = UIEdgeInsets(top: 24, left: 14, bottom: 22, right: 36)
        messageInputBar.inputTextView.layer.borderColor = UIColor.mainWhite.cgColor
        messageInputBar.inputTextView.layer.borderWidth = 0.2
        messageInputBar.inputTextView.layer.cornerRadius = 18
        messageInputBar.inputTextView.layer.masksToBounds = true
        messageInputBar.inputTextView.scrollIndicatorInsets = UIEdgeInsets(top: 14, left: 0, bottom: 14, right: 0)
    }
    
    func setupSendButton() {
        
        messageInputBar.sendButton.setImage(UIImage(named: "send"), for: .normal)
        messageInputBar.sendButton.addGradient(cornerRadius: 18)
        messageInputBar.setRightStackViewWidthConstant(to: 56, animated: false)
        messageInputBar.sendButton.title = .none
        messageInputBar.sendButton.setSize(CGSize(width: 66, height: 66), animated: false)
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
    
    func numberOfItems(inSection section: Int, in messagesCollectionView: MessagesCollectionView) -> Int {
        
        return messages.count
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        
        return 1
    }
}

// MARK: - Messages Layout Delegate
extension ConversationViewController: MessagesLayoutDelegate {
    
    func footerViewSize(for section: Int, in messagesCollectionView: MessagesCollectionView) -> CGSize {
        
        return CGSize(width: 8, height: 8)
    }
}
 
// MARK: - Messages Display Delegate
extension ConversationViewController: MessagesDisplayDelegate {
    
    func backgroundColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        
        return isFromCurrentSender(message: message) ? .mainWhite.withAlphaComponent(0.5) : .mainBlue
    }
    
    func textColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        
        return isFromCurrentSender(message: message) ? .black : .white
    }
    
    func configureAvatarView(_ avatarView: AvatarView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
        
        return isFromCurrentSender(message: message) ? avatarView.sd_setImage(with: URL(string: chat.friendUserImageUrl)) : avatarView.sd_setImage(with: URL(string: user.userImageUrl))
    }
    
    func messageStyle(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageStyle {
        
        return .bubble
    }
}

extension ConversationViewController: InputBarAccessoryViewDelegate {
    
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        
        let message = MessageModel(user: user, content: text)
        
        presenter.sendMessage(chat: chat, message: message, currentUser: user)
        
        inputBar.inputTextView.text = ""
    }
}

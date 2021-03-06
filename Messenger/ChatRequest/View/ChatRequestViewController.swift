//
//  ChatRequestViewController.swift
//  Messenger
//
//  Created by Alexander on 29.11.2021.
//

import UIKit
import SDWebImage

class ChatRequestViewController: UIViewController {
    
    // MARK: - Image
    let profileImageView = UIImageView(image: UIImage(named: "user5"), contentMode: .scaleAspectFill)
    
    // MARK: - Labels
    let userNameLabel = UILabel(text: "Veronica White", textColor: .mainWhite, font: .mainFont)
    let aboutUserLabel = UILabel(text: "I want to chat with you", textColor: .secondaryWhite, font: .secondaryFont)
    
    // MARK: - Buttons
    let acceptButton = UIButton(title: "Accept", titleColor: .mainWhite, backgroundColor: .mainWhite, backgroundColorAlfa: 0.5, font: .secondaryFont, cornerRadius: 10)
    let denyButton = UIButton(title: "Deny", titleColor: .mainBlue, backgroundColor: .mainDark, backgroundColorAlfa: 0.5, font: .secondaryFont, cornerRadius: 10)
    
    // MARK: - Request form
    let requestForm = UIView()
    
    private var chat: ChatModel
    
    // MARK: - Presenter
    var presenter: ChatRequestPresenterProtocol!
    
    init(chat: ChatModel) {
        
        self.chat = chat
        userNameLabel.text = chat.friendUsername
        profileImageView.sd_setImage(with: URL(string: chat.friendUserImageUrl))
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupConstraints()
        
        acceptButton.addTarget(self, action: #selector(acceptButtonPressed), for: .touchUpInside)
        denyButton.addTarget(self, action: #selector(denyButtonPressed), for: .touchUpInside)
    }
    
    @objc private func acceptButtonPressed() {
        
        self.dismiss(animated: true) {
            self.presenter.createActiveChat(chat: self.chat)
        }
    }
    
    @objc private func denyButtonPressed() {
        
        self.dismiss(animated: true) {
            
            self.presenter.removeWaitingChats(chat: self.chat)
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        self.acceptButton.addGradient(cornerRadius: 10)
    }
}

// MARK: - Setup constraints
extension ChatRequestViewController {
    
    private func setupConstraints() {
        
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        aboutUserLabel.translatesAutoresizingMaskIntoConstraints = false
        requestForm.translatesAutoresizingMaskIntoConstraints = false
        
        requestForm.backgroundColor = .mainDark
        requestForm.layer.cornerRadius = 30
        
        aboutUserLabel.numberOfLines = 0
        
        view.addSubview(profileImageView)
        view.addSubview(requestForm)
        
        requestForm.addSubview(userNameLabel)
        requestForm.addSubview(aboutUserLabel)
       
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: view.topAnchor),
            profileImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            profileImageView.bottomAnchor.constraint(equalTo: requestForm.topAnchor, constant: 30)
        ])
        
        NSLayoutConstraint.activate([
            requestForm.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            requestForm.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            requestForm.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            requestForm.heightAnchor.constraint(equalToConstant: 206)
        ])
        
        NSLayoutConstraint.activate([
            userNameLabel.topAnchor.constraint(equalTo: requestForm.topAnchor, constant: 16),
            userNameLabel.leadingAnchor.constraint(equalTo: requestForm.leadingAnchor, constant: 24),
            userNameLabel.trailingAnchor.constraint(equalTo: requestForm.trailingAnchor, constant: -24)
        ])
        
        NSLayoutConstraint.activate([
            aboutUserLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 8),
            aboutUserLabel.leadingAnchor.constraint(equalTo: requestForm.leadingAnchor, constant: 24),
            aboutUserLabel.trailingAnchor.constraint(equalTo: requestForm.trailingAnchor, constant: -24)
        ])
        
        let buttonsGroup = UIStackView(arrangedSubviews: [acceptButton, denyButton], axis: .horizontal, spacing: 10)
        buttonsGroup.distribution = .fillEqually
        
        denyButton.layer.borderColor = UIColor.mainBlue.cgColor
        denyButton.layer.borderWidth = 1.5
       
        requestForm.addSubview(buttonsGroup)
        
        NSLayoutConstraint.activate([
            buttonsGroup.topAnchor.constraint(equalTo: aboutUserLabel.bottomAnchor, constant: 16),
            buttonsGroup.leadingAnchor.constraint(equalTo: requestForm.leadingAnchor, constant: 24),
            buttonsGroup.trailingAnchor.constraint(equalTo: requestForm.trailingAnchor, constant: -24),
            buttonsGroup.heightAnchor.constraint(equalToConstant: 45)
        ])
        
    }
}


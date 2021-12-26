//
//  ProfileViewController.swift
//  Messenger
//
//  Created by Alexander on 28.11.2021.
//

import UIKit
import SDWebImage

class ProfileViewController: UIViewController {

    // MARK: - Image
    let profileImageView = UIImageView(image: UIImage(named: "user10"), contentMode: .scaleAspectFill)
    
    // MARK: - Labels
    let userNameLabel = UILabel(text: "Victoria Jordan", textColor: .mainWhite, font: .mainFont)
    let aboutUserLabel = UILabel(text: "I'm a cool girl and want to chat with you!", textColor: .secondaryWhite, font: .secondaryFont)
    
    // MARK: - TextFields
    let messageTextField = MessageFromProfileTextField(font: .secondaryFont, placeholder: "Write something here", isSecured: false)

    // MARK: - ProfileForm
    let profileForm = UIView()
    
    private let user: UserModel
    
    var presenter: ProfileViewPresenterProtocol!
    
    init(user: UserModel) {
        
        self.user = user
        self.userNameLabel.text = user.username
        self.aboutUserLabel.text = user.description
        self.profileImageView.sd_setImage(with: URL(string: user.userImageUrl))
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupConstraints()
        setTargetForButton()
        
    }
    
    @objc private func sendMessage() {
        
        guard let message = messageTextField.text, message != "" else { return }
           
        self.presenter.sendMessage(message: message, receiver: self.user)
    }
}

// MARK: - Setup constraints
extension ProfileViewController {
    
    private func setTargetForButton() {
        
        if let button = messageTextField.rightView as? UIButton {
            
            button.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
        }
    }
    
    private func setupConstraints() {
        
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        aboutUserLabel.translatesAutoresizingMaskIntoConstraints = false
        messageTextField.translatesAutoresizingMaskIntoConstraints = false
        profileForm.translatesAutoresizingMaskIntoConstraints = false
        
        profileForm.backgroundColor = .mainDark
        profileForm.layer.cornerRadius = 30
        
        aboutUserLabel.numberOfLines = 0
        
        view.addSubview(profileImageView)
        view.addSubview(profileForm)
        
        profileForm.addSubview(userNameLabel)
        profileForm.addSubview(aboutUserLabel)
        profileForm.addSubview(messageTextField)
       
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: view.topAnchor),
            profileImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            profileImageView.bottomAnchor.constraint(equalTo: profileForm.topAnchor, constant: 30)
        ])
        
        NSLayoutConstraint.activate([
            profileForm.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileForm.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            profileForm.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            profileForm.heightAnchor.constraint(equalToConstant: 206)
        ])
        
        NSLayoutConstraint.activate([
            userNameLabel.topAnchor.constraint(equalTo: profileForm.topAnchor, constant: 16),
            userNameLabel.leadingAnchor.constraint(equalTo: profileForm.leadingAnchor, constant: 24),
            userNameLabel.trailingAnchor.constraint(equalTo: profileForm.trailingAnchor, constant: -24)
        ])
        
        NSLayoutConstraint.activate([
            aboutUserLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 8),
            aboutUserLabel.leadingAnchor.constraint(equalTo: profileForm.leadingAnchor, constant: 24),
            aboutUserLabel.trailingAnchor.constraint(equalTo: profileForm.trailingAnchor, constant: -24)
        ])
        
        NSLayoutConstraint.activate([
            messageTextField.topAnchor.constraint(equalTo: aboutUserLabel.bottomAnchor, constant: 16),
            messageTextField.leadingAnchor.constraint(equalTo: profileForm.leadingAnchor, constant: 24),
            messageTextField.trailingAnchor.constraint(equalTo: profileForm.trailingAnchor, constant: -24),
            messageTextField.heightAnchor.constraint(equalToConstant: 45)
        ])
        
    }
}


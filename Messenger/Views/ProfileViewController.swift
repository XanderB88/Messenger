//
//  ProfileViewController.swift
//  Messenger
//
//  Created by Alexander on 28.11.2021.
//

import UIKit

class ProfileViewController: UIViewController {

    // MARK: - Image
    let profileImageView = UIImageView(image: UIImage(named: "user10"), contentMode: .scaleAspectFill)
    
    // MARK: - Labels
    let userNameLabel = UILabel(text: "Victoria Jordan", textColor: .mainWhite, font: .mainFont)
    let aboutUserLabel = UILabel(text: "I'm a cool girl and want to chat with you!", textColor: .secondaryWhite, font: .secondaryFont)
    
    // MARK: - TextFields
    let messageTextField = UnderlineTextField(font: .secondaryFont, placeholder: "Write something here", isSecured: false)
    
    // MARK: - ProfileForm
    let profileForm = UIView()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupConstraints()
    }
}

// MARK: - Setup constraints
extension ProfileViewController {
    
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
            userNameLabel.leadingAnchor.constraint(equalTo: profileForm.leadingAnchor, constant: 16),
            userNameLabel.trailingAnchor.constraint(equalTo: profileForm.trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            aboutUserLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 8),
            aboutUserLabel.leadingAnchor.constraint(equalTo: profileForm.leadingAnchor, constant: 16),
            aboutUserLabel.trailingAnchor.constraint(equalTo: profileForm.trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            messageTextField.topAnchor.constraint(equalTo: aboutUserLabel.bottomAnchor, constant: 16),
            messageTextField.leadingAnchor.constraint(equalTo: profileForm.leadingAnchor, constant: 16),
            messageTextField.trailingAnchor.constraint(equalTo: profileForm.trailingAnchor, constant: -16),
            messageTextField.heightAnchor.constraint(equalToConstant: 45)
        ])
        
    }
}

// MARK: - Activate a canvas
import SwiftUI

struct ProfileViewControllerProvider: PreviewProvider {
    
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        
        let viewController = ProfileViewController()
        
        func makeUIViewController(context: Context) -> some UIViewController {
            return viewController
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        }
    }
}

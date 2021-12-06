//
//  ActiveChatCell.swift
//  Messenger
//
//  Created by Alexander on 23.11.2021.
//

import UIKit

class ActiveChatCell: UICollectionViewCell {
    
    // MARK: - Constants
    let userImageView = UIImageView()
    let userName = UILabel(text: "User name", textColor: .mainWhite, font: .secondaryFont)
    let lastMessage = UILabel(text: "What's up", textColor: .secondaryWhite, font: .searchAndMessageFont)
    let gradientSideLineView = GradientView(from: .topTrailing, to: .bottomTrailing, startColor: .mainBlue, endColor: .secondaryBlue)
    let chatCellSize: CGFloat = 88
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewConfiguration()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Cell configuration
extension ActiveChatCell: CellConfigurationProtocol {
   
    
    static var reusableId: String {
        return "ActiveChatCell"
    }
    
    func cellConfiguration<U>(with model: U) where U : Hashable {
        
        guard let chat: ChatModel = model as? ChatModel else { return }
        
        userImageView.image = UIImage(named: chat.userImageString)
        userName.text = chat.username
        lastMessage.text = chat.lastMessage
    }
    
    // MARK: - Setup view configuration
    private func setupViewConfiguration() {
        self.backgroundColor = .mainWhite.withAlphaComponent(0.1)
        self.layer.cornerRadius = 5
        self.clipsToBounds = true
    }
    
    // MARK: - Setup constraints
    private func setupConstraints() {

        userImageView.translatesAutoresizingMaskIntoConstraints = false
       
        NSLayoutConstraint.activate([
            userImageView.widthAnchor.constraint(equalToConstant: chatCellSize),
            userImageView.heightAnchor.constraint(equalToConstant: chatCellSize)
        ])

        userName.translatesAutoresizingMaskIntoConstraints = false
        lastMessage.translatesAutoresizingMaskIntoConstraints = false
        
        let messageForm = UIStackView(arrangedSubviews: [userName, lastMessage], axis: .vertical, spacing: -20)
        messageForm.distribution = .fillEqually

        gradientSideLineView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            gradientSideLineView.widthAnchor.constraint(equalToConstant: 8)
        ])

        let generalMessageForm = UIStackView(arrangedSubviews: [userImageView, messageForm, gradientSideLineView], axis: .horizontal, spacing: 15)
        
        self.addSubview(generalMessageForm)
        
        NSLayoutConstraint.activate([
            generalMessageForm.topAnchor.constraint(equalTo: self.topAnchor),
            generalMessageForm.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            generalMessageForm.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            generalMessageForm.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}

// MARK: - Activate a canvas
import SwiftUI

struct ActiveChatCellProvider: PreviewProvider {
    
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        
        let viewController = PeopleAndChatsTabBarController()
        
        func makeUIViewController(context: Context) -> some UIViewController {
            return viewController
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        }
    }
}

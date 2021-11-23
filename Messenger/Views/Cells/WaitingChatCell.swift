//
//  WaitingChatCell.swift
//  Messenger
//
//  Created by Alexander on 24.11.2021.
//

import Foundation
import UIKit

class WaitingChatCell: UICollectionViewCell {
    
    // MARK: - Constants
    let userImageView = UIImageView()
    let chatCellSize: CGFloat = 88
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        setupViewConfiguration()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Cell configuration
extension WaitingChatCell: CellConfigurationProtocol {
    
    static var reusableId: String {
        return "WaitingChatCell"
    }
    
    func cellConfiguration(with model: ChatModel) {
        userImageView.image = UIImage(named: model.userImageString)
    }
    
    // MARK: - Setup view configuration
    private func setupViewConfiguration() {
        self.layer.cornerRadius = chatCellSize / 2
        self.clipsToBounds = true
    }
    
    // MARK: - Setup constraints
    private func setupConstraints() {
        
        //User image
        userImageView.translatesAutoresizingMaskIntoConstraints = false
       
        self.addSubview(userImageView)
        
        NSLayoutConstraint.activate([
            userImageView.widthAnchor.constraint(equalToConstant: chatCellSize),
            userImageView.heightAnchor.constraint(equalToConstant: chatCellSize)
        ])
    }
}

// MARK: - Activate a canvas
import SwiftUI

struct WaitingChatCellProvider: PreviewProvider {
    
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        
        let viewController = MainTabBarController()
        
        func makeUIViewController(context: Context) -> some UIViewController {
            return viewController
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        }
    }
}

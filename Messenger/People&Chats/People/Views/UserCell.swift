//
//  UserCell.swift
//  Messenger
//
//  Created by Alexander on 27.11.2021.
//

import UIKit
import SDWebImage

class UserCell: UICollectionViewCell {
    
    // MARK: - Constants
    let userImageView = UIImageView()
    let userName = UILabel(text: "User name", textColor: .mainWhite, font: .secondaryFont)
    
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
extension UserCell: CellConfigurationProtocol {
    
    static var reusableId: String {
        return "Users"
    }
    
    func cellConfiguration<U>(with model: U) where U : Hashable {
        
        guard let user: UserModel = model as? UserModel else { return }
        
        userImageView.sd_setImage(with: URL(string: user.userImageUrl))
        userName.text = user.username
    }
   
    // MARK: - Setup view configuration
    private func setupViewConfiguration() {
        userImageView.layer.cornerRadius = 5
        userImageView.clipsToBounds = true
    }
    
    // MARK: - Setup constraints
    private func setupConstraints() {
        userName.translatesAutoresizingMaskIntoConstraints = false
        userImageView.translatesAutoresizingMaskIntoConstraints = false
 
        let userForm = UIStackView(arrangedSubviews: [userImageView, userName], axis: .vertical, spacing: 0)
        
        self.addSubview(userForm)
        
        NSLayoutConstraint.activate([
            userImageView.heightAnchor.constraint(equalTo: userForm.widthAnchor)
            
        ])
       
        NSLayoutConstraint.activate([
            userForm.topAnchor.constraint(equalTo: self.topAnchor),
            userForm.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            userForm.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            userForm.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}

// MARK: - Activate a canvas
import SwiftUI

struct UserCellProvider: PreviewProvider {
    
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

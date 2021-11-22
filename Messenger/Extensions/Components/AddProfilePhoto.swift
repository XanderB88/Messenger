//
//  AddProfilePhoto.swift
//  Messenger
//
//  Created by Alexander on 17.11.2021.
//

import UIKit

class AddProfilePhoto: UIView {
    
    lazy var profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = #imageLiteral(resourceName: "user")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.mainWhite.cgColor
        return imageView
    }()
    
    lazy var plusButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "plus"), for: .normal)
        button.tintColor = .mainWhite
        return button
    }()
    
   override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(profileImage)
        addSubview(plusButton)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            profileImage.topAnchor.constraint(equalTo: self.topAnchor),
            profileImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            profileImage.widthAnchor.constraint(equalToConstant: 120),
            profileImage.heightAnchor.constraint(equalToConstant: 120)
        ])
        
        NSLayoutConstraint.activate([
            plusButton.bottomAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 5),
            plusButton.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: -10),
            plusButton.widthAnchor.constraint(equalToConstant: 30),
            plusButton.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            self.bottomAnchor.constraint(equalTo: profileImage.bottomAnchor),
            self.trailingAnchor.constraint(equalTo: plusButton.trailingAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        profileImage.layer.masksToBounds = true
        profileImage.layer.cornerRadius = profileImage.frame.width / 2
    }
}

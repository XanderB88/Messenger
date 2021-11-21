//
//  SetUpProfileViewController.swift
//  Messenger
//
//  Created by Alexander on 17.11.2021.
//

import UIKit

class SetupProfileViewController: UIViewController {
    
    // MARK: - Custom add photo component
    let profileImageForm = AddProfilePhoto()
    
    // MARK: - Buttons
    let goToChatButton = UIButton(title: "Go to chat", backgroundColor: .mainWhite, backgroundColorAlfa: 0.2)
    
    // MARK: - Labels
    let greetingLabel = UILabel(text: "SET UP PROFILE", textColor: .mainWhite, font: .headerFont)
    let firstNameLabel = UILabel(text: "FIRST NAME", textColor: .secondaryWhite, font: .secondaryFont)
    let secondNameLabel = UILabel(text: "SECOND NAME", textColor: .secondaryWhite, font: .secondaryFont)
    
    // MARK: - TextFields
    let firstNameTextField = UnderlineTextField( placeholder: "First Name")
    let secondNameTextField = UnderlineTextField( placeholder: "Second Name")
    
    // MARK: - Segmented control
    let genderControl = UISegmentedControl(first: "Male", second: "Female")
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .mainDark
        setupConstraints()
    }
}

// MARK: - Setup constraints
extension SetupProfileViewController {
    
    private func setupConstraints() {
        
        // Greeting label
        greetingLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(greetingLabel)
        
        NSLayoutConstraint.activate([
            greetingLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            greetingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        // Profile image form
        profileImageForm.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(profileImageForm)
       
        NSLayoutConstraint.activate([
            profileImageForm.topAnchor.constraint(equalTo: greetingLabel.bottomAnchor, constant: 30),
            profileImageForm.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        // First name textfield with label
        let firstNameTextFieldForm = UIStackView(arrangedSubviews: [firstNameLabel, firstNameTextField], axis: .vertical, spacing: 15)
        
        // First name textfield with label
        let secondNameTextFieldForm = UIStackView(arrangedSubviews: [secondNameLabel, secondNameTextField], axis: .vertical, spacing: 15)
        
        // User form
        let signupForm = UIStackView(arrangedSubviews: [firstNameTextFieldForm, secondNameTextFieldForm, genderControl, goToChatButton], axis: .vertical, spacing: 40)
        
        view.addSubview(signupForm)
        
        NSLayoutConstraint.activate([
            signupForm.topAnchor.constraint(equalTo: profileImageForm.bottomAnchor, constant: 100),
            signupForm.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            signupForm.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
    }
}

// MARK: - Activate a canvas
import SwiftUI

struct SetupProfileViewControllerProvider: PreviewProvider {
    
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        
        let viewController = SetupProfileViewController()
        
        func makeUIViewController(context: Context) -> some UIViewController {
            return viewController
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        }
    }
}

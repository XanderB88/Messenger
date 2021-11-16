//
//  LoginViewController.swift
//  Messenger
//
//  Created by Alexander on 15.11.2021.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK: - Buttons
    let googleButton = UIButton(title: "Google", backgroundColor: .mainWhite, backgroundColorAlfa: 0.2, icon: #imageLiteral(resourceName: "google"))
    let loginButton = UIButton(title: "LogIn", backgroundColor: .mainWhite, backgroundColorAlfa: 0.2, icon: #imageLiteral(resourceName: "login"))
    
    lazy var signupButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("SignUP", for: .normal)
        button.setTitleColor(.mainRed, for: .normal)
        button.titleLabel?.font = .secondaryFont18
        return button
    }()
    
    // MARK: - Labels
    let greetingLabel = UILabel(text: "WELCOME BACK!", textColor: .mainWhite, font: .headerFont30)
    let googleLabel = UILabel(text: "LOGIN WITH", textColor: .secondaryWhite, font: .secondaryFont18)
    let orLabel = UILabel(text: "OR", textColor: .secondaryWhite, font: .secondaryFont18)
    let emailLabel = UILabel(text: "EMAIL", textColor: .secondaryWhite, font: .secondaryFont18)
    let passwordLabel = UILabel(text: "PASSWORD", textColor: .secondaryWhite, font: .secondaryFont18)
    let needAccountLabel = UILabel(text: "NEED AN ACCOUNT?", textColor: .secondaryWhite, font: .secondaryFont18)
    
    // MARK: - TextFields
    let emailTextField = UnderlineTextField( placeholder: "Email")
    let passwordTextField = UnderlineTextField( placeholder: "Password", isSecured: true)
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .mainDark
        setupConstraints()
    }
}

// MARK: - Setup constraints
extension LoginViewController {
    private func setupConstraints() {
        
        // Greeting label
        greetingLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(greetingLabel)
        
        NSLayoutConstraint.activate([
            greetingLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            greetingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        // Google button with label
        googleLabel.translatesAutoresizingMaskIntoConstraints = false
        googleButton.translatesAutoresizingMaskIntoConstraints = false
        
        let googleButtonForm = UIStackView(arrangedSubviews: [googleLabel, googleButton], axis: .vertical, spacing: 15)
        
        // Email textfield with label
        let emailTextFieldForm = UIStackView(arrangedSubviews: [emailLabel, emailTextField], axis: .vertical, spacing: 15)
        
        // Password textfield with label
        let passwordTextFieldForm = UIStackView(arrangedSubviews: [passwordLabel, passwordTextField], axis: .vertical, spacing: 15)
        
        // Login form
        let loginForm = UIStackView(arrangedSubviews: [googleButtonForm, orLabel, emailTextFieldForm, passwordTextFieldForm, loginButton], axis: .vertical, spacing: 40)
        
        view.addSubview(loginForm)
        
        NSLayoutConstraint.activate([
            loginForm.topAnchor.constraint(equalTo: greetingLabel.bottomAnchor, constant: 100),
            loginForm.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            loginForm.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
        
        // Bottom form
        
        let bottomForm = UIStackView(arrangedSubviews: [needAccountLabel, signupButton], axis: .horizontal, spacing: 5)
        
        view.addSubview(bottomForm)
        
        NSLayoutConstraint.activate([
            bottomForm.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 95),
            bottomForm.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -95),
            bottomForm.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50)
        ])
    }
}

// MARK: - Activate a canvas
import SwiftUI

struct LoginViewControllerProvider: PreviewProvider {
    
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        
        let viewController = LoginViewController()
        
        func makeUIViewController(context: Context) -> some UIViewController {
            return viewController
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        }
    }
}

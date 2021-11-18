//
//  SignUpViewController.swift
//  Messenger
//
//  Created by Alexander on 16.11.2021.
//

import UIKit

class SignupViewController: UIViewController {

    // MARK: - Buttons
    let signupButton = UIButton(title: "SignUp", backgroundColor: .mainWhite, backgroundColorAlfa: 0.2)
    let loginButton = UIButton(title: "LogIn", titleColor: .mainRed, backgroundColor: .clear, font: .secondaryFont18)
    
    // MARK: - Labels
    let greetingLabel = UILabel(text: "GOOD TO SEE YOU!", textColor: .mainWhite, font: .headerFont30)
    let emailLabel = UILabel(text: "EMAIL", textColor: .secondaryWhite, font: .secondaryFont18)
    let passwordLabel = UILabel(text: "PASSWORD", textColor: .secondaryWhite, font: .secondaryFont18)
    let confirmPasswordLabel = UILabel(text: "CONFIRM PASSWORD", textColor: .secondaryWhite, font: .secondaryFont18)
    let alreadyOnboardLabel = UILabel(text: "ALREADY ONBOARD?", textColor: .secondaryWhite, font: .secondaryFont18)
    
    // MARK: - TextFields
    let emailTextField = UnderlineTextField( placeholder: "Email")
    let passwordTextField = UnderlineTextField( placeholder: "Password", isSecured: true)
    let confirmPasswordTextField = UnderlineTextField( placeholder: "Confirm password", isSecured: true)
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .mainDark
        setupConstraints()
    }
}

// MARK: - Setup constraints
extension SignupViewController {
    
    private func setupConstraints() {
        
        // Greeting label
        greetingLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(greetingLabel)
        
        NSLayoutConstraint.activate([
            greetingLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            greetingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        // Email textfield with label
        let emailTextFieldForm = UIStackView(arrangedSubviews: [emailLabel, emailTextField], axis: .vertical, spacing: 15)
        
        // Password textfield with label
        let passwordTextFieldForm = UIStackView(arrangedSubviews: [passwordLabel, passwordTextField], axis: .vertical, spacing: 15)
        
        // Confirm password textfield with label
        let confirmPasswordTextFieldForm = UIStackView(arrangedSubviews: [confirmPasswordLabel, confirmPasswordTextField], axis: .vertical, spacing: 15)
        
        // Signup form
        let signupForm = UIStackView(arrangedSubviews: [emailTextFieldForm, passwordTextFieldForm, confirmPasswordTextFieldForm, signupButton], axis: .vertical, spacing: 40)
        
        view.addSubview(signupForm)
        
        NSLayoutConstraint.activate([
            signupForm.topAnchor.constraint(equalTo: greetingLabel.bottomAnchor, constant: 100),
            signupForm.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            signupForm.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
        
        // Bottom form
        let bottomForm = UIStackView(arrangedSubviews: [alreadyOnboardLabel, loginButton], axis: .horizontal, spacing: 5)
        
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

struct SignupViewControllerProvider: PreviewProvider {
    
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        
        let viewController = SignupViewController()
        
        func makeUIViewController(context: Context) -> some UIViewController {
            return viewController
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        }
    }
}
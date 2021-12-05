//
//  EmailRegistrationViewController.swift
//  Messenger
//
//  Created by Alexander on 16.11.2021.
//

import UIKit

class EmailRegistrationViewController: UIViewController {

    // MARK: - Buttons
    let signupButton = UIButton(title: "SignUp", backgroundColor: .mainWhite, backgroundColorAlfa: 0.2)
    let loginButton = UIButton(title: "LogIn", titleColor: .mainRed, backgroundColor: .clear, font: .secondaryFont)
    
    // MARK: - Labels
    let greetingLabel = UILabel(text: "GOOD TO SEE YOU!", textColor: .mainWhite, font: .headerFont)
    let emailLabel = UILabel(text: "EMAIL", textColor: .secondaryWhite, font: .secondaryFont)
    let passwordLabel = UILabel(text: "PASSWORD", textColor: .secondaryWhite, font: .secondaryFont)
    let confirmPasswordLabel = UILabel(text: "CONFIRM PASSWORD", textColor: .secondaryWhite, font: .secondaryFont)
    let alreadyOnboardLabel = UILabel(text: "ALREADY ONBOARD?", textColor: .secondaryWhite, font: .secondaryFont)
    
    // MARK: - TextFields
    let emailTextField = UnderlineTextField( placeholder: "Email")
    let passwordTextField = UnderlineTextField( placeholder: "Password", isSecured: true)
    let confirmPasswordTextField = UnderlineTextField( placeholder: "Confirm password", isSecured: true)
    
    // MARK: - Presenter
    var presenter: EmailRegistrationViewPresenterProtocol!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .mainDark
        setupConstraints()
        
        signupButton.addTarget(self, action: #selector(signupButtonPressed), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
    }
    
    @objc private func signupButtonPressed() {
        
        presenter.register(email: emailTextField.text, password: passwordTextField.text, confirmPassword: confirmPasswordTextField.text)
    }
    
    @objc private func loginButtonPressed() {
       
        dismiss(animated: true) {
           
            self.presenter.pressedToLoginButton()
        }
    }
}

// MARK: - Email registration view protocol
extension EmailRegistrationViewController: EmailRegistrationViewProtocol {
    
    func success() {
        self.showAlert(withTitle: "Success", withMessage: "You was registered")
    }
    
    func failure(error: Error) {
        self.showAlert(withTitle: "Error", withMessage: error.localizedDescription)
    }
}

// MARK: - Setup constraints
extension EmailRegistrationViewController {
    
    private func setupConstraints() {
        
        greetingLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(greetingLabel)
        
        NSLayoutConstraint.activate([
            greetingLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            greetingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        let emailTextFieldForm = UIStackView(arrangedSubviews: [emailLabel, emailTextField], axis: .vertical, spacing: 15)
        
        let passwordTextFieldForm = UIStackView(arrangedSubviews: [passwordLabel, passwordTextField], axis: .vertical, spacing: 15)
        
        let confirmPasswordTextFieldForm = UIStackView(arrangedSubviews: [confirmPasswordLabel, confirmPasswordTextField], axis: .vertical, spacing: 15)
        
        let signupForm = UIStackView(arrangedSubviews: [emailTextFieldForm, passwordTextFieldForm, confirmPasswordTextFieldForm, signupButton], axis: .vertical, spacing: 40)
        
        view.addSubview(signupForm)
        
        NSLayoutConstraint.activate([
            signupForm.topAnchor.constraint(equalTo: greetingLabel.bottomAnchor, constant: 100),
            signupForm.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            signupForm.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
        
        let bottomForm = UIStackView(arrangedSubviews: [alreadyOnboardLabel, loginButton], axis: .horizontal, spacing: 5)
        
        view.addSubview(bottomForm)
        
        NSLayoutConstraint.activate([
            bottomForm.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 95),
            bottomForm.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -95),
            bottomForm.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -35)
        ])
    }
}


// MARK: - Activate a canvas
import SwiftUI

struct EmailRegistrationViewControllerProvider: PreviewProvider {
    
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        
        let viewController = EmailRegistrationViewController()
        
        func makeUIViewController(context: Context) -> some UIViewController {
            return viewController
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        }
    }
}

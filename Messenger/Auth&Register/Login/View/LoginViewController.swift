//
//  LoginViewController.swift
//  Messenger
//
//  Created by Alexander on 15.11.2021.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK: - Buttons
    let googleButton = UIButton(title: "Google", backgroundColor: .mainWhite, backgroundColorAlfa: 0.2)
    let loginButton = UIButton(title: "LogIn", backgroundColor: .mainWhite, backgroundColorAlfa: 0.2)
    let signupButton = UIButton(title: "SignUp", titleColor: .mainRed, backgroundColor: .clear, font: .secondaryFont)
    
    // MARK: - Icons for buttons
    let googleIcon = UIImage(named: "google")
    let loginIcon = UIImage(named: "login")
    
    // MARK: - Labels
    let greetingLabel = UILabel(text: "WELCOME BACK!", textColor: .mainWhite, font: .headerFont)
    let googleLabel = UILabel(text: "LOGIN WITH", textColor: .secondaryWhite, font: .secondaryFont)
    let orLabel = UILabel(text: "OR", textColor: .secondaryWhite, font: .secondaryFont)
    let emailLabel = UILabel(text: "EMAIL", textColor: .secondaryWhite, font: .secondaryFont)
    let passwordLabel = UILabel(text: "PASSWORD", textColor: .secondaryWhite, font: .secondaryFont)
    let needAccountLabel = UILabel(text: "NEED AN ACCOUNT?", textColor: .secondaryWhite, font: .secondaryFont)
    
    // MARK: - TextFields
    let emailTextField = UnderlineTextField( placeholder: "Email")
    let passwordTextField = UnderlineTextField( placeholder: "Password", isSecured: true)
    
    // MARK: - Presenter
    
    var presenter: LoginViewPresenterProtocol!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .mainDark
        setupIconsForButtons()
        setupConstraints()
        
        googleButton.addTarget(self, action: #selector(googleButtonPressed), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        signupButton.addTarget(self, action: #selector(signupButtonPressed), for: .touchUpInside)
    }
    
    @objc private func googleButtonPressed() {
        
    }
    
    @objc private func loginButtonPressed() {
        
        presenter.login(email: emailTextField.text, password: passwordTextField.text)
    }
    
    @objc private func signupButtonPressed() {
        
        dismiss(animated: true) {
            
            self.presenter.pressedToSignUpButton()
        }
    }
}

// MARK: - Login view protocol
extension LoginViewController: LoginViewProtocol {
   
    func success() {
        
        self.showAlert(withTitle: "Success", withMessage: "You are logged in")
    }
    
    func failure(error: Error) {
        
        self.showAlert(withTitle: "Error", withMessage: error.localizedDescription)
    }
}

// MARK: - Setup constraints
extension LoginViewController {
    private func setupConstraints() {
        
        greetingLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(greetingLabel)
        
        NSLayoutConstraint.activate([
            greetingLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            greetingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        googleLabel.translatesAutoresizingMaskIntoConstraints = false
        googleButton.translatesAutoresizingMaskIntoConstraints = false
        
        let googleButtonForm = UIStackView(arrangedSubviews: [googleLabel, googleButton], axis: .vertical, spacing: 15)
        
        let emailTextFieldForm = UIStackView(arrangedSubviews: [emailLabel, emailTextField], axis: .vertical, spacing: 15)
        
        let passwordTextFieldForm = UIStackView(arrangedSubviews: [passwordLabel, passwordTextField], axis: .vertical, spacing: 15)
        
        let loginForm = UIStackView(arrangedSubviews: [googleButtonForm, orLabel, emailTextFieldForm, passwordTextFieldForm, loginButton], axis: .vertical, spacing: 40)
        
        view.addSubview(loginForm)
        
        NSLayoutConstraint.activate([
            loginForm.topAnchor.constraint(equalTo: greetingLabel.bottomAnchor, constant: 70),
            loginForm.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            loginForm.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
        
        let bottomForm = UIStackView(arrangedSubviews: [needAccountLabel, signupButton], axis: .horizontal, spacing: 5)
        
        view.addSubview(bottomForm)
        
        NSLayoutConstraint.activate([
            bottomForm.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 95),
            bottomForm.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -95),
            bottomForm.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -35)
        ])
    }
    
    fileprivate func setupIconsForButtons(){
        
        guard let googleIcon = googleIcon,
              let loginIcon = loginIcon
        else { return }
      
        googleButton.setupIconForButton(icon: googleIcon)
        loginButton.setupIconForButton(icon: loginIcon)
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

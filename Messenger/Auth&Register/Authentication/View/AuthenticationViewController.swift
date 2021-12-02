//
//  AuthenticationViewController.swift
//  Messenger
//
//  Created by Alexander on 12.11.2021.
//

import UIKit

class AuthenticationViewController: UIViewController {
    
    // MARK: - Buttons
    let googleButton = UIButton(title: "Google", backgroundColor: .mainWhite, backgroundColorAlfa: 0.2)
    let emailButton = UIButton(title: "Email", backgroundColor: .mainWhite, backgroundColorAlfa: 0.2)
    let loginButton = UIButton(title: "LogIn", backgroundColor: .mainWhite, backgroundColorAlfa: 0.2)
    
    // MARK: - Icons for buttons
    let googleIcon = UIImage(named: "google")
    let emailIcon = UIImage(named: "email")
    let loginIcon = UIImage(named: "login")
    
    // MARK: - Labels
    
    let logoLabel = UILabel(text: "Messenger", textColor: .mainWhite, font: .logoFont)
    let googleLabel = UILabel(text: "GET STARTED USING", textColor: .secondaryWhite, font: .secondaryFont)
    let emailLabel = UILabel(text: "SIGN UP USING", textColor: .secondaryWhite, font: .secondaryFont)
    let loginLabel = UILabel(text: "ALREDY HAS ACCOUNT", textColor: .secondaryWhite, font: .secondaryFont)
    
    // MARK: - Images
    let logoImageView = UIImageView(image: #imageLiteral(resourceName: "messenger"), contentMode: .scaleAspectFit)
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .mainDark
        setupIconsForButtons()
        setupConstraints()
    }
}

// MARK: - Setup constraints
extension AuthenticationViewController {
    
    fileprivate func setupConstraints() {
        
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let logoForm = UIStackView(arrangedSubviews: [logoLabel, logoImageView], axis: .horizontal, spacing: 10)
        
        view.addSubview(logoForm)
        
        NSLayoutConstraint.activate([
            logoImageView.widthAnchor.constraint(equalToConstant: 70),
            logoImageView.heightAnchor.constraint(equalToConstant: 70)
        ])
        
        NSLayoutConstraint.activate([
            logoForm.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            logoForm.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 75),
            logoForm.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -75),
        ])
        
        googleLabel.translatesAutoresizingMaskIntoConstraints = false
        googleButton.translatesAutoresizingMaskIntoConstraints = false
        
        let googleButtonForm = UIStackView(arrangedSubviews: [googleLabel, googleButton], axis: .vertical, spacing: 15)
        
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        emailButton.translatesAutoresizingMaskIntoConstraints = false
        
        let emailButtonForm = UIStackView(arrangedSubviews: [emailLabel, emailButton], axis: .vertical, spacing: 15)
        
        loginLabel.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        
        let loginButtonForm = UIStackView(arrangedSubviews: [loginLabel, loginButton], axis: .vertical, spacing: 15)
        
        let generalButtonForm = UIStackView(arrangedSubviews: [googleButtonForm, emailButtonForm, loginButtonForm], axis: .vertical, spacing: 40)
        
        view.addSubview(generalButtonForm)
        
        NSLayoutConstraint.activate([
            generalButtonForm.topAnchor.constraint(equalTo: logoForm.bottomAnchor, constant: 100),
            generalButtonForm.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            generalButtonForm.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
    }
    
    // Add icons to buttons
    fileprivate func setupIconsForButtons(){
        
        guard let googleIcon = googleIcon,
              let emailIcon = emailIcon,
              let loginIcon = loginIcon
        else { return }
      
        googleButton.setupIconForButton(icon: googleIcon)
        emailButton.setupIconForButton(icon: emailIcon)
        loginButton.setupIconForButton(icon: loginIcon)
    }
}

// MARK: - Activate a canvas
import SwiftUI

struct AuthenticationViewControllerProvider: PreviewProvider {
    
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        
        let viewController = AuthenticationViewController()
        
        func makeUIViewController(context: Context) -> some UIViewController {
            return viewController
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        }
    }
}


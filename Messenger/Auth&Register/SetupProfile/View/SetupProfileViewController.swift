//
//  SetUpProfileViewController.swift
//  Messenger
//
//  Created by Alexander on 17.11.2021.
//

import UIKit
import FirebaseAuth

class SetupProfileViewController: UIViewController {
    
    // MARK: - Custom add photo component
    let profileImageForm = AddProfilePhoto()
    
    // MARK: - Buttons
    let goToChatButton = UIButton(title: "Go to chat", backgroundColor: .mainWhite, backgroundColorAlfa: 0.2)
    
    // MARK: - Labels
    let greetingLabel = UILabel(text: "SET UP PROFILE", textColor: .mainWhite, font: .headerFont)
    let fullNameLabel = UILabel(text: "FULL NAME", textColor: .secondaryWhite, font: .secondaryFont)
    let aboutMeLabel = UILabel(text: "ABOUT ME", textColor: .secondaryWhite, font: .secondaryFont)
    
    // MARK: - TextFields
    let fullNameTextField = UnderlineTextField( placeholder: "Full Name")
    let aboutMeTextField = UnderlineTextField( placeholder: "About me")
    
    // MARK: - Segmented control
    let genderControl = UISegmentedControl(first: "Male", second: "Female")
    
    // MARK: - Presenter
    var presenter: SetupProfileViewPresenterProtocol!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .mainDark
        setupConstraints()
        
        profileImageForm.plusButton.addTarget(self, action: #selector(plusButtonPressed), for: .touchUpInside)
        
        goToChatButton.addTarget(self, action: #selector(goToChatButtonPressed), for: .touchUpInside)
    }
    
    @objc private func plusButtonPressed() {
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.allowsEditing = true
        
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @objc private func goToChatButtonPressed() {
        
        let imageData = getImageData(image: profileImageForm.profileImage.image)
        
        presenter.saveUserProfile(username: fullNameTextField.text,
                                  userImageData: imageData,
                                  description: aboutMeTextField.text,
                                  gender: genderControl.titleForSegment(at: genderControl.selectedSegmentIndex))
    }
}

extension SetupProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true, completion: nil)
        
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else { return }
        
        profileImageForm.profileImage.contentMode = .scaleToFill
        profileImageForm.profileImage.clipsToBounds = true
        profileImageForm.profileImage.image = image
    }
}

extension SetupProfileViewController: SetupProfileViewProtocol {
    func success() {
        
        self.showAlert(withTitle: "Success", withMessage: "Profile is completed") {
            
            self.dismiss(animated: true) {
                
                self.presenter.toChatScreen()
            }
        }
    }
    
    func failure(error: Error) {
        
        self.showAlert(withTitle: "Error", withMessage: error.localizedDescription)
    }
}

// MARK: - Setup constraints
extension SetupProfileViewController {
    
    private func setupConstraints() {
        
        greetingLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(greetingLabel)
        
        NSLayoutConstraint.activate([
            greetingLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            greetingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
   
        profileImageForm.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(profileImageForm)
       
        NSLayoutConstraint.activate([
            profileImageForm.topAnchor.constraint(equalTo: greetingLabel.bottomAnchor, constant: 30),
            profileImageForm.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        let fullNameTextFieldForm = UIStackView(arrangedSubviews: [fullNameLabel, fullNameTextField], axis: .vertical, spacing: 15)
     
        let aboutMeTextFieldForm = UIStackView(arrangedSubviews: [aboutMeLabel, aboutMeTextField], axis: .vertical, spacing: 15)

        let signupForm = UIStackView(arrangedSubviews: [fullNameTextFieldForm, aboutMeTextFieldForm, genderControl, goToChatButton], axis: .vertical, spacing: 40)
        
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

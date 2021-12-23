//
//  ConfigProfileViewController.swift
//  Messenger
//
//  Created by Alexander on 14.12.2021.
//

import UIKit
import FirebaseAuth
import SDWebImage

class ConfigurationProfileViewController: UIViewController {
    
    // MARK: - Custom add photo component
    let profileImageForm = AddProfilePhoto()
    
    // MARK: - Buttons
    let saveButton = UIButton(title: "Save", backgroundColor: .mainWhite, backgroundColorAlfa: 0.2)
    
    // MARK: - Labels
    let greetingLabel = UILabel(text: "", textColor: .mainWhite, font: .headerFont)
    let fullNameLabel = UILabel(text: "FULL NAME", textColor: .secondaryWhite, font: .secondaryFont)
    let aboutMeLabel = UILabel(text: "ABOUT ME", textColor: .secondaryWhite, font: .secondaryFont)
    
    // MARK: - TextFields
    let fullNameTextField = UnderlineTextField( placeholder: "Full Name")
    let aboutMeTextField = UnderlineTextField( placeholder: "About me")
    
    // MARK: - Segmented control
    let genderControl = UISegmentedControl(first: "Male", second: "Female")
    
    // MARK: - Presenter
    var presenter: ConfigurationProfileViewPresenterProtocol!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .mainDark
        setupConstraints()
 
        
        profileImageForm.plusButton.addTarget(self, action: #selector(plusButtonPressed), for: .touchUpInside)
        
        saveButton.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Log Out", style: .plain, target: self, action: #selector(logOutButtonPressed))
        navigationItem.rightBarButtonItem?.tintColor = UIColor.mainBlue
        
        let attributes : [NSAttributedString.Key: Any] = [.font: UIFont.secondaryFont!]
        navigationItem.rightBarButtonItem?.setTitleTextAttributes(attributes, for: .normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter.getUserInfo()
    }
    
    @objc private func plusButtonPressed() {
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.allowsEditing = true
        
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @objc private func saveButtonPressed() {
        
        let imageData = getImageData(image: profileImageForm.profileImage.image)
        
        presenter.saveUserProfile(username: fullNameTextField.text,
                                  userImageData: imageData,
                                  description: aboutMeTextField.text,
                                  gender: genderControl.titleForSegment(at: genderControl.selectedSegmentIndex))
    }
    
    @objc private func logOutButtonPressed() {
        
        presenter.logOutButtonPressed()
    }
}

extension ConfigurationProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true, completion: nil)
        
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else { return }
        
        profileImageForm.profileImage.contentMode = .scaleToFill
        profileImageForm.profileImage.clipsToBounds = true
        profileImageForm.profileImage.image = image
    }
}

extension ConfigurationProfileViewController: ConfigurationProfileViewProtocol {
    
    func updateView(user: UserModel) {
        
        greetingLabel.text = user.username
        fullNameTextField.text = user.username
        aboutMeTextField.text = user.description
        
        self.profileImageForm.profileImage.contentMode = .scaleToFill
        self.profileImageForm.profileImage.clipsToBounds = true
        self.profileImageForm.profileImage.sd_setImage(with: URL(string: user.userImageUrl))
        
        if user.gender == "Male" {
            
            genderControl.selectedSegmentIndex = 0
        } else {
            
            genderControl.selectedSegmentIndex = 1
        }
    }
    
    func success() {
        
        self.showAlert(withTitle: "Success", withMessage: "Profile is changed") {
            
            self.dismiss(animated: true) {
               
                self.presenter.getUserInfo()
            }
        }
    }
    
    func failure(error: Error) {
        
        self.showAlert(withTitle: "Error", withMessage: error.localizedDescription)
    }
    
    func logOut() {
        
        self.showLogOutAlert(withTitle: "", withMessage: "Are you sure you want to log out of your account?") {
            
            self.presenter.popToRoot()
        }
    }
}

// MARK: - Setup constraints
extension ConfigurationProfileViewController {
    
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

        let signupForm = UIStackView(arrangedSubviews: [fullNameTextFieldForm, aboutMeTextFieldForm, genderControl, saveButton], axis: .vertical, spacing: 40)
        
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

struct ConfigProfileViewControllerProvider: PreviewProvider {
    
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

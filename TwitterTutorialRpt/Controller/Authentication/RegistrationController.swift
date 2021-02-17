//
//  RegistrationController.swift
//  TwitterTutorialRpt
//
//  Created by Stephen Learmonth on 15/02/2021.
//

import UIKit

class RegistrationController: UIViewController {
    
    // MARK: - Properties
    
    private lazy var addPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "plus_photo"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(handleAddPhotoButtonClicked), for: .touchUpInside)
        button.layer.cornerRadius = 128.0 / 2.0
        button.setDimensions(width: 128.0, height: 128.0)
        button.layer.masksToBounds = true
        button.contentMode = .scaleAspectFill
        button.imageView?.clipsToBounds = true
        button.layer.borderColor = UIColor.white.cgColor
        return button
    }()
    
    private lazy var emailContainerView: UIView = {
        let view = Utilities.shared.createCustomInputContainerView(withImage: #imageLiteral(resourceName: "ic_mail_outline_white_2x-1"), andTextField: emailTextField)
        return view
    }()
    
    private lazy var passwordContainerView: UIView = {
        let view = Utilities.shared.createCustomInputContainerView(withImage: #imageLiteral(resourceName: "ic_lock_outline_white_2x"), andTextField: passwordTextField)
        return view
    }()
    
    private lazy var fullnameContainerView: UIView = {
        let view = Utilities.shared.createCustomInputContainerView(withImage: #imageLiteral(resourceName: "ic_person_outline_white_2x"), andTextField: fullnameTextField)
        return view
    }()
    
    private lazy var usernameContainerView: UIView = {
        let view = Utilities.shared.createCustomInputContainerView(withImage: #imageLiteral(resourceName: "ic_person_outline_white_2x"), andTextField: usernameTextField)
        return view
    }()
    
    private let emailTextField: UITextField = {
        let tf = Utilities.shared.createCustomTextField(withPlaceholder: "Email")
        tf.tag = 0
        return tf
    }()

    private let passwordTextField: UITextField = {
        let tf = Utilities.shared.createCustomTextField(withPlaceholder: "Password")
        tf.isSecureTextEntry = true
        tf.tag = 1
        return tf
    }()
    
    private let fullnameTextField: UITextField = {
        let tf = Utilities.shared.createCustomTextField(withPlaceholder: "Full Name")
        tf.tag = 2
        return tf
    }()

    private let usernameTextField: UITextField = {
        let tf = Utilities.shared.createCustomTextField(withPlaceholder: "Username")
        tf.tag = 3
        return tf
    }()
    
    private lazy var alreadyHaveAnAccountButton: UIButton = {
        let button = Utilities.shared.attributedButton("Already have an account? ", "Log In")
        button.addTarget(self, action: #selector(handleShowLogIn), for: .touchUpInside)
        return button
    }()

    private let registrationButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.twitterBlue, for: .normal)
        button.backgroundColor = .white
        button.setHeight(to: 50.0)
        button.layer.cornerRadius = 5.0
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20.0)
        button.addTarget(self, action: #selector(handleRegistrationButtonClicked), for: .touchUpInside)
        return button
    }()
    
    private let imagePicker = UIImagePickerController()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Selectors
    
    @objc func handleShowLogIn() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func handleAddPhotoButtonClicked() {
        imagePicker.modalPresentationStyle = .fullScreen
        present(imagePicker, animated: true, completion: nil)
        view.endEditing(true)
    }
    
    @objc func handleViewTapped() {
        print("DEBUG: view tapped")
        view.endEditing(true)
    }
    
    @objc func handleRegistrationButtonClicked() {
        print("DEBUG: registration button clicked")
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        view.backgroundColor = .twitterBlue
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        view.addSubview(addPhotoButton)
        addPhotoButton.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor)
        
        let stack = UIStackView(arrangedSubviews: [emailContainerView,
                                                   passwordContainerView,
                                                   fullnameContainerView,
                                                   usernameContainerView,
                                                   registrationButton])
        stack.axis = .vertical
        stack.spacing = 20
        stack.distribution = .fillEqually
        
        view.addSubview(stack)
        stack.anchor(top: addPhotoButton.bottomAnchor,
                     left: view.leftAnchor,
                     right: view.rightAnchor,
                     paddingTop: 32.0,
                     paddingLeft: 32.0,
                     paddingRight: 32.0)

        view.addSubview(alreadyHaveAnAccountButton)
        alreadyHaveAnAccountButton.anchor(left: view.leftAnchor,
                                          bottom: view.safeAreaLayoutGuide.bottomAnchor,
                                          right: view.rightAnchor,
                                          paddingLeft: 40.0,
                                          paddingRight: 40.0)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleViewTapped))
        tap.numberOfTapsRequired = 1
        view.addGestureRecognizer(tap)

    }
}

// MARK: - UIImagePickerControllerDelegate

extension RegistrationController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let profileImage = info[.editedImage] as? UIImage else { return }
        
        self.addPhotoButton.setImage(profileImage.withRenderingMode(.alwaysOriginal), for: .normal)
        
        addPhotoButton.layer.borderWidth = 3.0
        
        dismiss(animated: true, completion: nil)
    }
}

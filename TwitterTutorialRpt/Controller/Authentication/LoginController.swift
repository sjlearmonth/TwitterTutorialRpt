//
//  LoginController.swift
//  TwitterTutorialRpt
//
//  Created by Stephen Learmonth on 15/02/2021.
//

import UIKit

class LoginController: UIViewController {
    
    // MARK: - Properties
    
    private let logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.image = #imageLiteral(resourceName: "TwitterLogo")
        return iv
    }()
    
    private lazy var emailContainerView: UIView = {
        let view = Utilities.shared.createCustomInputContainerView(withImage: #imageLiteral(resourceName: "ic_mail_outline_white_2x-1"), andTextField: emailTextField)
        return view
    }()
    
    private lazy var passwordContainerView: UIView = {
        let view = Utilities.shared.createCustomInputContainerView(withImage: #imageLiteral(resourceName: "ic_lock_outline_white_2x"), andTextField: passwordTextField)
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
    
    private let logInButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(.twitterBlue, for: .normal)
        button.backgroundColor = .white
        button.setHeight(to: 50.0)
        button.layer.cornerRadius = 5.0
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20.0)
        button.addTarget(self, action: #selector(handleLogInButtonClicked), for: .touchUpInside)
        return button
    }()
    
    private lazy var dontHaveAnAccountButton: UIButton = {
        let button = Utilities.shared.attributedButton("Don't have an account yet? ", "Sign Up")
        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        return button
    }()

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Selectors
    
    @objc func handleLogInButtonClicked() {
        guard let email = emailTextField.text,
              let password = passwordTextField.text else { return }
        AuthService.shared.logUserIn(withEmail: email, andPassword: password) { (result, error) in
            if let error = error {
                print("DEBUG: error is \(error.localizedDescription)")
                return
            }
            
            guard let window = UIApplication.shared.windows.first(where: {$0.isKeyWindow}) else { return }
            guard let tab = window.rootViewController as? MainTabController else { return }
            tab.authenticateUserAndConfigureUI()
            
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func handleShowSignUp() {
        let controller = RegistrationController()
        controller.modalTransitionStyle = .crossDissolve
        controller.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc func handleViewTapped() {
        print("DEBUG: view tapped")
        view.endEditing(true)
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        view.backgroundColor = .twitterBlue
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
        
        view.addSubview(logoImageView)
        logoImageView.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor)
        logoImageView.setDimensions(width: 150.0, height: 150.0)
        
        let stack = UIStackView(arrangedSubviews: [emailContainerView, passwordContainerView, logInButton])
        stack.axis = .vertical
        stack.spacing = 20
        stack.distribution = .fillEqually
        
        view.addSubview(stack)
        stack.anchor(top: logoImageView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingLeft: 32.0, paddingRight: 32.0)
        
        view.addSubview(dontHaveAnAccountButton)
        dontHaveAnAccountButton.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingLeft: 40.0, paddingRight: 40.0)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleViewTapped))
        tap.numberOfTapsRequired = 1
        view.addGestureRecognizer(tap)
    }
}

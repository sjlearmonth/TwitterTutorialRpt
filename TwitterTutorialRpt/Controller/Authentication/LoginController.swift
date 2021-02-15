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
        let view = UIView()
        view.backgroundColor = .red
        view.setHeight(to: 50)
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "ic_mail_outline_white_2x-1")
        view.addSubview(iv)
        iv.anchor(left: view.leftAnchor, bottom: view.bottomAnchor, paddingLeft: 8.0, paddingRight: 8.0, width: 24.0, height: 24.0)
        return view
    }()
    
    private lazy var passwordContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemPurple
        view.setHeight(to: 50)
        return view
    }()

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        
    }
    
    // MARK: - Selectors
    
    // MARK: - Helpers
    
    private func configureUI() {
        view.backgroundColor = .twitterBlue
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
        
        view.addSubview(logoImageView)
        logoImageView.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor)
        logoImageView.setDimensions(width: 150.0, height: 150.0)
        
        let stack = UIStackView(arrangedSubviews: [emailContainerView, passwordContainerView])
        stack.axis = .vertical
        stack.spacing = 8
        
        view.addSubview(stack)
        stack.anchor(top: logoImageView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor)
    }
}

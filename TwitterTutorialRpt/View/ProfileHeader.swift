//
//  ProfileHeader.swift
//  TwitterTutorialRpt
//
//  Created by Stephen Learmonth on 11/03/2021.
//

import UIKit

class ProfileHeader: UICollectionReusableView {
    
    // MARK: - Properties
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .twitterBlue
        
        view.addSubview(backButton)
        backButton.anchor(top: view.topAnchor, left: view.leftAnchor, paddingTop: 50.0, paddingLeft: 16.0)
        backButton.setDimensions(width: 35.0, height: 35.0)
        return view
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "baseline_arrow_back_white_24dp").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleDismissal), for: .touchUpInside)
        return button
    }()
    
    private let profileImageView: UIImageView = {
        let piv = UIImageView()
        piv.contentMode = .scaleAspectFill
        piv.clipsToBounds = true
        piv.backgroundColor = .lightGray
        piv.layer.borderColor = UIColor.white.cgColor
        piv.layer.borderWidth = 4.0
        piv.setDimensions(width: 80.0, height: 80.0)
        piv.layer.cornerRadius = 80.0 / 2.0
        return piv
    }()
    
    private lazy var editProfileFollowButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Loading", for: .normal)
        button.layer.borderColor = UIColor.twitterBlue.cgColor
        button.layer.borderWidth = 2.0
        button.setTitleColor(.twitterBlue, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14.0)
        button.addTarget(self, action: #selector(handleEditProfileFollow), for: .touchUpInside)
        button.setDimensions(width: 100.0, height: 36.0)
        button.layer.cornerRadius = 36.0 / 2.0
        return button
    }()
    
    private let fullnameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        label.text = "fullname"
        return label
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16.0)
        label.textColor = .lightGray
        label.text = "username"
        return label
    }()
    
    private let bioLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16.0)
        label.numberOfLines = 3
        label.text = "This is a user bio that will span more than one line for test purposes."
        return label
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(containerView)
        containerView.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, height: 108.0)
        
        addSubview(profileImageView)
        profileImageView.anchor(top: containerView.bottomAnchor, left: leftAnchor, paddingTop: -24.0, paddingLeft: 8.0)
        
        addSubview(editProfileFollowButton)
        editProfileFollowButton.anchor(top:containerView.bottomAnchor, right: rightAnchor, paddingTop: 12.0, paddingRight: 12.0)
        
        let stack = UIStackView(arrangedSubviews: [fullnameLabel, usernameLabel, bioLabel])
        stack.axis = .vertical
        stack.spacing = 4.0
        stack.distribution = .fillProportionally
        
        addSubview(stack)
        stack.anchor(top: profileImageView.bottomAnchor,
                     left: leftAnchor,
                     right: rightAnchor,
                     paddingTop: 8.0,
                     paddingLeft: 12.0,
                     paddingRight: 12.0)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Selectors
    
    @objc func handleDismissal() {
        print("DEBUG: back button tapped")
    }
    
    @objc func handleEditProfileFollow() {
        
    }
}

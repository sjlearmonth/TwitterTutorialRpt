//
//  ProfileHeader.swift
//  TwitterTutorialRpt
//
//  Created by Stephen Learmonth on 11/03/2021.
//

import UIKit

protocol ProfileHeaderDelegate: class {
    func handleDismissal()
    func handleEditProfileFollow(_ header: ProfileHeader)
}

class ProfileHeader: UICollectionReusableView {
    
    // MARK: - Properties
    
    var user: User? {
        didSet { configure() }
    }
    
    weak var delegate: ProfileHeaderDelegate?
    
    private let filterBar = ProfileFilterView()
    
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
    
    lazy var editProfileFollowButton: UIButton = {
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
        return label
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15.0)
        label.textColor = .lightGray
        return label
    }()
    
    private let bioLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16.0)
        label.numberOfLines = 3
        label.text = "This is a user bio that will span more than one line for test purposes."
        return label
    }()
    
    private let underlineView: UIView = {
        let view = UIView()
        view.backgroundColor = .twitterBlue
        return view
    }()
    
    private lazy var followingLabel: UILabel = {
        let label = UILabel()
        let followTap = UITapGestureRecognizer(target: self, action: #selector(handleFollowerTapped))
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(followTap)
        return label
    }()

    private lazy var followersLabel: UILabel = {
        let label = UILabel()
        let followingTap = UITapGestureRecognizer(target: self, action: #selector(handleFollowingTapped))
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(followingTap)
        return label
    }()

    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        filterBar.delegate = self
        
        addSubview(containerView)
        containerView.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, height: 108.0)
        
        addSubview(profileImageView)
        profileImageView.anchor(top: containerView.bottomAnchor, left: leftAnchor, paddingTop: -24.0, paddingLeft: 8.0)
        
        addSubview(editProfileFollowButton)
        editProfileFollowButton.anchor(top:containerView.bottomAnchor, right: rightAnchor, paddingTop: 12.0, paddingRight: 12.0)
        
        let userDetailstack = UIStackView(arrangedSubviews: [fullnameLabel, usernameLabel, bioLabel])
        userDetailstack.axis = .vertical
        userDetailstack.spacing = 4.0
        userDetailstack.distribution = .fillProportionally
        
        addSubview(userDetailstack)
        userDetailstack.anchor(top: profileImageView.bottomAnchor,
                     left: leftAnchor,
                     right: rightAnchor,
                     paddingTop: 8.0,
                     paddingLeft: 12.0,
                     paddingRight: 12.0)
        
        let followStack = UIStackView(arrangedSubviews: [followingLabel, followersLabel])
        followStack.axis = .horizontal
        followStack.spacing = 8.0
        followStack.distribution = .fillEqually
        
        addSubview(followStack)
        followStack.anchor(top: userDetailstack.bottomAnchor,
                           left: leftAnchor,
                           paddingTop: 8.0,
                           paddingLeft: 12.0)
        
        addSubview(filterBar)
        filterBar.anchor(left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, height: 50.0)
        
        addSubview(underlineView)
        underlineView.anchor(left: leftAnchor, bottom: bottomAnchor, width: frame.width / 3.0, height: 2.0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Selectors
    
    @objc func handleDismissal() {
        print("DEBUG: back button tapped")
        delegate?.handleDismissal()
    }
    
    @objc func handleEditProfileFollow() {
        delegate?.handleEditProfileFollow(self)
    }
    
    @objc func handleFollowerTapped() {
        
    }
    
    @objc func handleFollowingTapped() {
        
    }
    
    // MARK: Helpers
    
    private func configure() {
        guard let user = user else { return }
        let viewModel = ProfileHeaderViewModel(user: user)
        followingLabel.attributedText = viewModel.followingString
        followersLabel.attributedText = viewModel.followersString
        profileImageView.sd_setImage(with: user.profileImageUrl)
        editProfileFollowButton.setTitle(viewModel.actionButtonTitle, for: .normal)
        fullnameLabel.text = user.fullname
        usernameLabel.text = viewModel.usernameText
    }
}

extension ProfileHeader: ProfileFilterViewDelegate {
    func filterView(_ view: ProfileFilterView, didSelect indexPath: IndexPath) {
        guard let cell = view.collectionView.cellForItem(at: indexPath) as? ProfileFilterCell else { return }
        let cellXPosition = cell.frame.origin.x
        UIView.animate(withDuration: 0.3) {
            self.underlineView.frame.origin.x = cellXPosition
        }
    }
}

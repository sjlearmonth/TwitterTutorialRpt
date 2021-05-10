//
//  TweetHeader.swift
//  TwitterTutorialRpt
//
//  Created by Stephen Learmonth on 09/04/2021.
//

import UIKit

class TweetHeader: UICollectionReusableView {
    
    // MARK: - Properties
    
    var tweet: Tweet? {
        didSet {
            configureHeader()
        }
    }
    
    private lazy var profileImageView: UIImageView = {
        let piv = UIImageView()
        piv.contentMode = .scaleAspectFill
        piv.clipsToBounds = true
        piv.setDimensions(width: 48.0, height: 48.0)
        piv.layer.cornerRadius = 24.0
        piv.backgroundColor = .twitterBlue
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleProfileImageTapped))
        tap.numberOfTapsRequired = 1
        piv.addGestureRecognizer(tap)
        piv.isUserInteractionEnabled = true
        return piv
    }()
    
    private let fullnameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14.0)
        label.text = "fullname label"
        return label
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.textColor = .lightGray
        label.text = "username label"
        return label
    }()
    
    private let captionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20.0)
        label.numberOfLines = 0
        label.text = "some caption label text"
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.textAlignment = .left
        label.text = "6:33 PM - 1/28/2020"
        return label
    }()
    
    private lazy var optionsButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .lightGray
        button.setImage(UIImage(named: "down_arrow_24pt"), for: .normal)
        button.addTarget(self, action: #selector(showActionSheet), for: .touchUpInside)
        return button
    }()
    
    private lazy var retweetsLabel = UILabel()
    
    private lazy var likesLabel = UILabel()

    private lazy var statsView: UIView = {
        let view = UIView()
        let upperDivider = UIView()
        upperDivider.backgroundColor = .systemGroupedBackground
        view.addSubview(upperDivider)
        upperDivider.anchor(top: view.topAnchor,
                            left: view.leftAnchor,
                            right: view.rightAnchor,
                            paddingLeft: 8.0,
                            height: 1.8)
        
        let stack = UIStackView(arrangedSubviews: [retweetsLabel, likesLabel])
        stack.axis = .horizontal
        stack.spacing = 12
        
        view.addSubview(stack)
        stack.centerY(inView: view)
        stack.anchor(left: view.leftAnchor, paddingLeft: 16.0)

        let lowerDivider = UIView()
        lowerDivider.backgroundColor = .systemGroupedBackground
        view.addSubview(lowerDivider)
        lowerDivider.anchor(left: view.leftAnchor,
                            bottom: view.bottomAnchor,
                            right: view.rightAnchor,
                            paddingLeft: 8.0,
                            height: 1.8)
        return view
    }()
    
    private lazy var commentStack = createButtonWithCountStack(withImageName: "comment",
                                           andSelector: #selector(handleCommentButtonTapped),
                                           andCount:   0)

    private lazy var retweetStack = createButtonWithCountStack(withImageName: "retweet",
                                           andSelector: #selector(handleRetweetButtonTapped),
                                           andCount:   0)

    private lazy var likeStack = createButtonWithCountStack(withImageName: "like",
                                           andSelector: #selector(handleLikeButtonTapped),
                                           andCount:   0)

    private lazy var shareStack = createButtonWithCountStack(withImageName: "share",
                                           andSelector: #selector(handleShareButtonTapped),
                                           andCount:   0)

    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let labelStack = UIStackView(arrangedSubviews: [fullnameLabel, usernameLabel])
        labelStack.axis = .vertical
        labelStack.spacing = -6
        
        let stack = UIStackView(arrangedSubviews: [profileImageView, labelStack])
        stack.spacing = 12
        
        addSubview(stack)
        stack.anchor(top: topAnchor, left: leftAnchor, paddingTop: 16.0, paddingLeft: 16.0)
        
        addSubview(captionLabel)
        captionLabel.anchor(top: stack.bottomAnchor,
                            left: leftAnchor,
                            right: rightAnchor,
                            paddingTop: 12.0,
                            paddingLeft: 16.0,
                            paddingRight: 16.0)
        
        addSubview(dateLabel)
        dateLabel.anchor(top: captionLabel.bottomAnchor, left: leftAnchor, paddingTop: 20.0, paddingLeft: 16.0)
        
        addSubview(optionsButton)
        optionsButton.centerY(inView: stack)
        optionsButton.anchor(right: rightAnchor, paddingRight: 8.0)
        
        addSubview(statsView)
        statsView.anchor(top: dateLabel.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 12.0, height: 40.0)
        
        let actionStack = UIStackView(arrangedSubviews: [commentStack, retweetStack, likeStack, shareStack])
        actionStack.axis = .horizontal
        actionStack.spacing = 48.0
        actionStack.distribution = .fill
        
        addSubview(actionStack)
        actionStack.centerX(inView: self)
        actionStack.anchor(top: statsView.bottomAnchor, paddingTop: 16.0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Selectors
    
    @objc func handleProfileImageTapped() {
        
    }
    
    @objc func showActionSheet() {
        
    }
    
    @objc func handleCommentButtonTapped() {
        
    }

    @objc func handleRetweetButtonTapped() {
        
    }
    
    @objc func handleLikeButtonTapped() {
        
    }

    @objc func handleShareButtonTapped() {
        
    }


    // MARK: - Helper Functions
    
    private func createButtonWithCountStack(withImageName imageName: String,
                                            andSelector selector: Selector,
                                            andCount count: Int) -> UIStackView {
        
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: imageName), for: .normal)
        button.tintColor = .darkGray
        button.setDimensions(width: 20.0, height: 20.0)
        button.addTarget(self, action: selector, for: .touchUpInside)
        
        let label = UILabel()
        let formatter = NumberFormatter()
        formatter.groupingSeparator = ","
        formatter.numberStyle = .decimal
        label.text = formatter.string(from: NSNumber(value: count))
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14.0)
        
        let stack = UIStackView(arrangedSubviews: [button, label])
        stack.axis = .horizontal
        stack.spacing = 5.0
        stack.distribution = .fill
        
        return stack
    }
    
    private func configureHeader() {
        guard let tweet = tweet else { return }
        
        let viewModel = TweetViewModel(tweet: tweet)
        
        captionLabel.text = tweet.caption
        fullnameLabel.text = tweet.user.fullname
        usernameLabel.text = viewModel.usernameText
        profileImageView.sd_setImage(with: viewModel.profileImageUrl)
        dateLabel.text = viewModel.headerTimestamp
        retweetsLabel.attributedText = viewModel.retweetsAttributedString
        likesLabel.attributedText = viewModel.likesAttributedString
    }
}

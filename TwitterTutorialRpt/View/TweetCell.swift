//
//  TweetCell.swift
//  TwitterTutorialRpt
//
//  Created by Stephen Learmonth on 09/03/2021.
//

import UIKit
import SDWebImage

protocol TweetCellDelegate: class {
    func handleProfileImageTapped(_ cell: TweetCell)
    func handleReplyTapped(_ cell: TweetCell)
}

class TweetCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    var tweet: Tweet? {
        didSet {
            configure()
        }
    }
    
    weak var delegate: TweetCellDelegate?
    
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
    
    private let captionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13.0)
        label.numberOfLines = 0
        label.text = "Some tweet caption"
        return label
    }()
    
    private let infoLabel = UILabel()
    
    private let underlineView: UIView = {
        let uv = UIView()
        uv.backgroundColor = .systemGroupedBackground
        return uv
    }()
    
    private lazy var commentButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "comment"), for: .normal)
        button.tintColor = .darkGray
        button.setDimensions(width: 20.0, height: 20.0)
        button.addTarget(self, action: #selector(handleCommentTapped), for: .touchUpInside)
        return button
    }()
    
    private let commentCountLabel: UILabel = {
        let label = UILabel()
        let formatter = NumberFormatter()
        formatter.groupingSeparator = ","
        formatter.numberStyle = .decimal
        label.text = formatter.string(from: 0)
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14.0)
        return label
    }()

    private lazy var retweetButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "retweet"), for: .normal)
        button.tintColor = .darkGray
        button.setDimensions(width: 20.0, height: 20.0)
        button.addTarget(self, action: #selector(handleRetweetTapped), for: .touchUpInside)
        return button
    }()
    
    private let retweetCountLabel: UILabel = {
        let label = UILabel()
        let formatter = NumberFormatter()
        formatter.groupingSeparator = ","
        formatter.numberStyle = .decimal
        label.text = formatter.string(from: 0)
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14.0)
        return label
    }()

    private lazy var likeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "like"), for: .normal)
        button.tintColor = .darkGray
        button.setDimensions(width: 20.0, height: 20.0)
        button.addTarget(self, action: #selector(handleLikeTapped), for: .touchUpInside)
        return button
    }()
    
    private let likeCountLabel: UILabel = {
        let label = UILabel()
        let formatter = NumberFormatter()
        formatter.groupingSeparator = ","
        formatter.numberStyle = .decimal
        label.text = formatter.string(from: 0)
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14.0)
        return label
    }()

    private lazy var shareButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "share"), for: .normal)
        button.tintColor = .darkGray
        button.setDimensions(width: 20.0, height: 20.0)
        button.addTarget(self, action: #selector(handleShareTapped), for: .touchUpInside)
        return button
    }()

    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        addSubview(profileImageView)
        profileImageView.anchor(top: topAnchor, left: leftAnchor, paddingTop: 8.0, paddingLeft: 8.0)
        
        let stack = UIStackView(arrangedSubviews: [infoLabel, captionLabel])
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.spacing = 4
        
        addSubview(stack)
        stack.anchor(top: profileImageView.topAnchor,
                     left: profileImageView.rightAnchor,
                     right: rightAnchor,
                     paddingLeft: 12.0,
                     paddingRight: 12.0)
        
        infoLabel.font = UIFont.systemFont(ofSize: 13.0)
        
        let commentStack = UIStackView(arrangedSubviews: [commentButton, commentCountLabel])
        commentStack.axis = .horizontal
        commentStack.spacing = 6
        commentStack.distribution = .fill
        
        let retweetStack = UIStackView(arrangedSubviews: [retweetButton, retweetCountLabel])
        retweetStack.axis = .horizontal
        retweetStack.spacing = 6
        retweetStack.distribution = .fill

        let likeStack = UIStackView(arrangedSubviews: [likeButton, likeCountLabel])
        likeStack.axis = .horizontal
        likeStack.spacing = 6
        likeStack.distribution = .fill

        let actionStack = UIStackView(arrangedSubviews: [commentStack,
                                                         retweetStack,
                                                         likeStack,
                                                        shareButton])
        actionStack.axis = .horizontal
        actionStack.spacing = 50
        
        addSubview(actionStack)
        actionStack.anchor(bottom: bottomAnchor, paddingBottom: 8.0)
        actionStack.centerX(inView: self)
        
        addSubview(underlineView)
        underlineView.anchor(left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, height: 1.0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Selectors
    
    @objc func handleCommentTapped() {
        delegate?.handleReplyTapped(self)
    }

    @objc func handleRetweetTapped() {
        
    }

    @objc func handleLikeTapped() {
        
    }

    @objc func handleShareTapped() {
        
    }
    
    @objc func handleProfileImageTapped() {
        delegate?.handleProfileImageTapped(self)
    }

    // MARK: - Helpers
    
    private func configure() {
        guard let tweet = tweet else { return }
        let viewModel = TweetViewModel(tweet: tweet)
        captionLabel.text = tweet.caption
        profileImageView.sd_setImage(with: viewModel.profileImageUrl)
        infoLabel.attributedText = viewModel.userInfoText
    }
}

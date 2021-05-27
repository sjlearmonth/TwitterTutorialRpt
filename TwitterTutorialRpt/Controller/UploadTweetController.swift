//
//  UploadTweetController.swift
//  TwitterTutorialRpt
//
//  Created by Stephen Learmonth on 03/03/2021.
//

import UIKit

class UploadTweetController: UIViewController {
    
    // MARK: - Properties
    
    private let user: User
    private let config: UploadTweetConfiguration
    private lazy var viewModel = UploadTweetViewModel(config: config)
    
    private lazy var actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .twitterBlue
        button.setTitle("Tweet", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16.0)
        button.setTitleColor(.white, for: .normal)
        button.frame = CGRect(x: 0.0, y: 0.0, width: 64.0, height: 32.0)
        button.layer.cornerRadius = 32.0 / 2.0
        button.addTarget(self, action: #selector(handleUploadTweet), for: .touchUpInside)
        return button
    }()
    
    private lazy var profileImageView: UIImageView = {
        let piv = UIImageView()
        piv.contentMode = .scaleAspectFill
        piv.clipsToBounds = true
        piv.setDimensions(width: 48.0, height: 48.0)
        piv.layer.cornerRadius = 24.0
        piv.backgroundColor = .red
        piv.sd_setImage(with: user.profileImageUrl, completed: nil)
        return piv
    }()
    
    private lazy var replyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.textColor = .lightGray
        label.setWidth(to: view.frame.width)
        label.text = "Replying to @spiderman"
        return label
    }()
    
    private let captionTextView = InputTextView()
    
    // MARK: - Lifecycle
    
    init(user: User, config: UploadTweetConfiguration) {
        self.user = user
        self.config = config
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()        
    }
    
    // MARK: - Selectors
    
    @objc func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func handleUploadTweet() {
        guard let caption = captionTextView.text else { return }
        TweetService.shared.uploadTweet(caption: caption, type: config) { (error, ref) in
            if let error = error {
                print("DEBUG: Failed to upload tweet with error \(error.localizedDescription)")
                return
            }
            
            if case .reply(let tweet) = self.config {
                NotificationService.shared.uploadNotification(type: .reply, tweet: tweet)
            }
    
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    // MARK: - API
    
    // MARK: - Helpers
    
    private func configureUI() {
        view.backgroundColor = .white
        configureNavigationBar()
        
        let imageCaptionStack = UIStackView(arrangedSubviews: [profileImageView, captionTextView])
        imageCaptionStack.axis = .horizontal
        imageCaptionStack.spacing = 12
        imageCaptionStack.alignment = .leading
        
        let stack = UIStackView(arrangedSubviews: [replyLabel, imageCaptionStack])
        stack.axis = .vertical
        stack.spacing = 12.0
        
        view.addSubview(stack)
        stack.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                     left: view.leftAnchor,
                     right: view.rightAnchor,
                     paddingTop: 16.0,
                     paddingLeft: 16.0,
                     paddingRight: 16.0)
        
        actionButton.setTitle(viewModel.actionButtonTitle, for: .normal)
        captionTextView.placeholderLabel.text = viewModel.placeholderText
        replyLabel.isHidden = !viewModel.shouldShowReplyLabel
        guard let replyText = viewModel.replyText else { return }
        replyLabel.text = replyText
    }
    
    private func configureNavigationBar() {
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.isTranslucent = false
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: actionButton)
    }
    
}

//
//  FeedController.swift
//  TwitterTutorialRpt
//
//  Created by Stephen Learmonth on 10/02/2021.
//

import UIKit
import SDWebImage

class FeedController: UIViewController {
    
    // MARK: - Properties
    
    var user: User? {
        didSet {
            configureLeftBarButton()
        }
    }
    
    private let profileImageView: UIImageView = {
        let piv = UIImageView()
        piv.setDimensions(width: 40.0, height: 40.0)
        piv.layer.cornerRadius = 40.0 / 2.0
        piv.layer.masksToBounds = true
        piv.contentMode = .scaleAspectFill
        return piv
    }()
    
    private let twitterImageView: UIImageView = {
        let tiv = UIImageView()
        tiv.image = #imageLiteral(resourceName: "twitter_logo_blue")
        tiv.contentMode = .scaleAspectFill
        tiv.setDimensions(width: 44.0, height: 44.0)
        return tiv
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchTweets()
    }
    
    // MARK: API
    
    func fetchTweets() {
        TweetService.shared.fetchTweets { (tweets) in
            print("DEBUG: Tweets are \(tweets)")
        }
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        view.backgroundColor = .white
        navigationItem.titleView = twitterImageView
    }
    
    private func configureLeftBarButton() {
        guard let user = user else { return }
        profileImageView.sd_setImage(with: user.profileImageUrl, completed: nil)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: profileImageView)
    }
}

//
//  MainTabController.swift
//  TwitterTutorialRpt
//
//  Created by Stephen Learmonth on 10/02/2021.
//

import UIKit
import Firebase

class MainTabController: UITabBarController {
    
    // MARK: - Properties
    
    var user: User? {
        didSet {
            guard let nav = viewControllers?[0] as? UINavigationController else { return }
            guard let feed = nav.viewControllers.first as? FeedController else { return }
            feed.user = user
        }
    }
    
    let actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.backgroundColor = .twitterBlue
        button.setImage(UIImage(named: "new_tweet"), for: .normal)
        button.layer.cornerRadius = 56.0 / 2.0
        button.addTarget(self, action: #selector(handleActionButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        logUserOut()
        authenticateUserAndConfigureUI()
    }
    
    // MARK: - Selectors
    
    @objc func handleActionButtonTapped() {
        guard let user = user else { return }
        let controller = UploadTweetController(user: user, config: .tweet)
        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true, completion: nil)
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        view.addSubview(actionButton)
        actionButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingBottom: 64.0, paddingRight: 16.0, width: 56.0, height: 56.0)
        tabBar.barTintColor = .white
    }
    
    private func configureViewControllers() {
        
        let feedController = FeedController(collectionViewLayout: UICollectionViewFlowLayout())
        let feedNC = createNavigationController(image: UIImage(named: "home_unselected"), rootViewController: feedController)
        
        let exploreController = ExploreController()
        let exploreNC = createNavigationController(image: UIImage(named: "search_unselected"), rootViewController: exploreController)
        
        let notificationsController = NotificationsController()
        let notificationsNC = createNavigationController(image: UIImage(named: "like_unselected"), rootViewController: notificationsController)
        
        let conversationsController = ConversationsController()
        let conversationsNC = createNavigationController(image: UIImage(named: "ic_mail_outline_white_2x-1"), rootViewController: conversationsController)
        
        viewControllers = [feedNC, exploreNC, notificationsNC, conversationsNC]
        
    }
    
    private func createNavigationController(image: UIImage?, rootViewController: UIViewController) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: rootViewController)
        navigationController.tabBarItem.image = image
        navigationController.navigationBar.barTintColor = .white
        
        return navigationController
    }
    
    // MARK: - API
    
    func fetchUser() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        UserService.shared.fetchUser(uid: uid) { user in
            self.user = user
        }
    }
    
    func authenticateUserAndConfigureUI() {
        view.backgroundColor = .twitterBlue
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let nav = UINavigationController(rootViewController: LoginController())
                nav.modalTransitionStyle = .crossDissolve
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
            }
        } else {
            configureViewControllers()
            configureUI()
            fetchUser()
        }
    }
    
    private func logUserOut() {
        
        do {
            try Auth.auth().signOut()
        } catch let error {
            print("DEBUG: Failed to sign user out with error \(error.localizedDescription)")
        }
    }
}

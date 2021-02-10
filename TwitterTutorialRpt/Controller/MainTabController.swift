//
//  MainTabController.swift
//  TwitterTutorialRpt
//
//  Created by Stephen Learmonth on 10/02/2021.
//

import UIKit

class MainTabController: UITabBarController {
    
    // MARK: - Properties
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemPink
    }
    
    // MARK: - Helpers
    
    func configureViewControllers() {
        
        let feedController = FeedController()
        let exploreController = ExploreController()
        let notificationsController = NotificationsController()
        let conversationsController = ConversationsController()
        
        viewControllers = [feedController, exploreController, notificationsController, conversationsController]
        
    }
    
}

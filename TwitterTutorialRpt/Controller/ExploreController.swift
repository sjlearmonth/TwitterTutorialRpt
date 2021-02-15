//
//  ExploreController.swift
//  TwitterTutorialRpt
//
//  Created by Stephen Learmonth on 10/02/2021.
//

import UIKit

class ExploreController: UIViewController {
    
    // MARK: - Properties
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        view.backgroundColor = .white
        navigationItem.title = "Explore"
    }
}

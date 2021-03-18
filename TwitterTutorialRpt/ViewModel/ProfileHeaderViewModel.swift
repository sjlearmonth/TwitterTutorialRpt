//
//  ProfileHeaderViewModel.swift
//  TwitterTutorialRpt
//
//  Created by Stephen Learmonth on 17/03/2021.
//

import UIKit

enum ProfileFilterOptions: Int, CaseIterable {
    case tweets
    case repliesAndTweets
    case likes
    
    var description: String {
        switch self {
        case .tweets: return "Tweets"
        case .repliesAndTweets: return "Replies & Tweets"
        case .likes: return "Likes"
        }
    }
}

struct ProfileHeaderViewModel {
    
    private let user: User
    
    var followersString: NSAttributedString? {
        return attributedText(withValue: 0, text: "followers")
    }
    
    var followingString: NSAttributedString? {
        return attributedText(withValue: 0, text: "following")
    }
    
    init(user: User) {
        self.user = user
    }
    
    private func attributedText(withValue value: Int, text: String) -> NSAttributedString {
        
        let attributedTitle = NSMutableAttributedString(string: "\(value)",
                                                         attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14.0)])
        attributedTitle.append(NSAttributedString(string: " \(text)",
                                                   attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14.0),
                                                                NSAttributedString.Key.foregroundColor: UIColor.lightGray]))
        return attributedTitle
    }
}

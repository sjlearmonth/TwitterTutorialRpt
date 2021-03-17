//
//  ProfileHeaderViewModel.swift
//  TwitterTutorialRpt
//
//  Created by Stephen Learmonth on 17/03/2021.
//

import Foundation

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

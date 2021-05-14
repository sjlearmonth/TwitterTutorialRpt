//
//  Notification.swift
//  TwitterTutorialRpt
//
//  Created by Stephen Learmonth on 14/05/2021.
//

import Foundation

struct Notification {
    let tweetID: String?
    var timestamp: Date!
    let user: User
    var tweet: Tweet?
    
    init(user: User, tweet: Tweet?, dictionary: [String: AnyObject]) {
        self.user = user
        self.tweet = tweet
        self.tweetID = dictionary["tweetID"] as? String ?? ""
        if let timestamp = dictionary["timestamp"] as? Double {
            self.timestamp = Date(timeIntervalSince1970: timestamp)
        }
    }
}

//
//  Tweet.swift
//  TwitterTutorialRpt
//
//  Created by Stephen Learmonth on 05/03/2021.
//

import Foundation

struct Tweet {
    let caption: String
    let tweetID: String
    let uid: String
    let likes: Int
    let timestamp: Date!
    let retweetCount: Int
    
    init(tweetID: String, dictionary: [String: Any]) {
        self.caption = dictionary["caption"] as? String ?? ""
        self.tweetID = tweetID
        self.uid = dictionary["uid"] as? String ?? ""
        self.likes = dictionary["likes"] as? Int ?? 0
        if let timestamp = dictionary["timestamp"] as? Double {
            self.timestamp = Date(timeIntervalSince1970: timestamp)
        } else {
            self.timestamp = nil
        }
        self.retweetCount = dictionary["retweets"] as? Int ?? 0
    }
}

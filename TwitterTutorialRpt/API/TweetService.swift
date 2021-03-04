//
//  TweetService.swift
//  TwitterTutorialRpt
//
//  Created by Stephen Learmonth on 04/03/2021.
//

import Firebase

struct TweetService {
    static let shared = TweetService()
    
    func uploadTweet(caption: String, completion: @escaping (Error?, DatabaseReference) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let values = ["uid": uid,
                      "timestamp": Int(NSDate().timeIntervalSince1970),
                      "likes": 0,
                      "retweets": 0,
                      "caption": caption] as [String: Any]
        
        TWEETS_REF.childByAutoId().updateChildValues(values, withCompletionBlock: completion)
    }
}

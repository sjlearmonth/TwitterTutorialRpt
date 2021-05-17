//
//  NotificationService.swift
//  TwitterTutorialRpt
//
//  Created by Stephen Learmonth on 17/05/2021.
//

import Firebase

struct NotificationService {
    
    static let shared = NotificationService()
    
    func uploadNotification(type: NotificationType, tweet: Tweet? = nil, user: User? = nil) {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        var values: [String: Any] = ["timestamp": Int(NSDate().timeElapsedSince1970),
                                     "uid": uid,
                                     "type": type.rawValue]
        
        if let tweet = tweet {
            values["tweetID"] = tweet.tweetID
            NOTIFICATIONS_REF.child(tweet.user.uid).childByAutoId().updateChildValues(values)
        } else if let user = user {
            NOTIFICATIONS_REF.child(user.uid).childByAutoId().updateChildValues(values)
        }
        
    }
}

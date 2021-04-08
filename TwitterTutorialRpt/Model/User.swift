//
//  User.swift
//  TwitterTutorialRpt
//
//  Created by Stephen Learmonth on 24/02/2021.
//

import Foundation
import Firebase

struct User {
    let email: String
    let fullname: String
    let username: String
    let profileImageUrl: URL?
    let uid: String
    var isCurrentUser: Bool { Auth.auth().currentUser?.uid == uid }
    var isFollowed = false
    var stats: UserRelationStats?
    
    init(uid: String, dictionary: [String: AnyObject]) {
        self.uid = uid
        self.email = dictionary["email"] as? String ?? ""
        self.fullname = dictionary["fullname"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        if let profileImageUrlAsString = dictionary["profileImageUrl"] as? String {
            self.profileImageUrl = URL(string: profileImageUrlAsString)
        } else {
            self.profileImageUrl = URL(string: "")
        }
    }
}

struct UserRelationStats {
    var followersCount: Int
    var followingCount: Int
}

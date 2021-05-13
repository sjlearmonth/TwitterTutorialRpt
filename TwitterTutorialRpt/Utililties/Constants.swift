//
//  Constants.swift
//  TwitterTutorialRpt
//
//  Created by Stephen Learmonth on 19/02/2021.
//

import Firebase

let REALTIME_DATABASE_REFERENCE = Database.database().reference()

let USERS_REF = REALTIME_DATABASE_REFERENCE.child("users")

let STORAGE_REF = Storage.storage().reference()
let PROFILE_IMAGES_STORAGE = STORAGE_REF.child("profile_images")

let TWEETS_REF = REALTIME_DATABASE_REFERENCE.child("tweets")

let USER_TWEETS_REF = REALTIME_DATABASE_REFERENCE.child("user-tweets")

let USER_FOLLOWERS_REF = REALTIME_DATABASE_REFERENCE.child("user-followers")

let USER_FOLLOWING_REF = REALTIME_DATABASE_REFERENCE.child("user-following")

let TWEET_REPLIES_REF = REALTIME_DATABASE_REFERENCE.child("tweet-replies")

let USER_LIKES_REF = REALTIME_DATABASE_REFERENCE.child("user-likes")

let TWEET_LIKES_REF = REALTIME_DATABASE_REFERENCE.child("tweet-likes")

typealias DatabaseCompletion = ((Error?, DatabaseReference) -> Void)

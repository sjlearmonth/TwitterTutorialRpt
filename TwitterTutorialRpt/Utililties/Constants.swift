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

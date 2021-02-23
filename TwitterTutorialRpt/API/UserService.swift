//
//  UserService.swift
//  TwitterTutorialRpt
//
//  Created by Stephen Learmonth on 23/02/2021.
//

import Firebase

struct UserService {
    static let shared = UserService()
    
    func fetchUser() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        USERS_REF.child(uid).observeSingleEvent(of: .value) { (snapshot) in
            guard let dictionary = snapshot.value as? [String: AnyObject] else { return }
            print("DEBUG: dictionary is \(dictionary)")
        }
    }
}

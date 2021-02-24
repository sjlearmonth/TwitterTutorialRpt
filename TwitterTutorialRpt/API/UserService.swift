//
//  UserService.swift
//  TwitterTutorialRpt
//
//  Created by Stephen Learmonth on 23/02/2021.
//

import Firebase

struct UserService {
    static let shared = UserService()
    
    func fetchUser(completion: @escaping (User) -> ()) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        USERS_REF.child(uid).observeSingleEvent(of: .value) { (snapshot) in
            guard let dictionary = snapshot.value as? [String: AnyObject] else { return }
            let user = User(uid: uid, dictionary: dictionary)
            completion(user)
        }
    }
}

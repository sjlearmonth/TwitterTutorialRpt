//
//  UserService.swift
//  TwitterTutorialRpt
//
//  Created by Stephen Learmonth on 23/02/2021.
//

import Firebase

struct UserService {
    static let shared = UserService()
    
    func fetchUser(uid: String, completion: @escaping (User) -> ()) {
        USERS_REF.child(uid).observeSingleEvent(of: .value) { (snapshot) in
            guard let dictionary = snapshot.value as? [String: AnyObject] else { return }
            let user = User(uid: uid, dictionary: dictionary)
            completion(user)
        }
    }
    
    func fetchUsers(completion: @escaping ([User]) -> ()) {
        var users = [User]()
        USERS_REF.observe(.childAdded) { snapshot in
            let uid = snapshot.key
            guard let dictionary = snapshot.value as? [String: AnyObject] else { return }
            let user = User(uid: uid, dictionary: dictionary)
            users.append(user)
            completion(users)
        }
    }
    
    func followUser(uid: String, completion: @escaping (Database, Error?) -> ()) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        print("DEBUG: Current uid \(currentUid) started following \(uid)")
        print("DEBUG: uid \(uid) gained \(currentUid) as a follower")
    }
}

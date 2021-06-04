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
    
    func followUser(uid: String, completion: @escaping DatabaseCompletion ) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        USER_FOLLOWING_REF.child(currentUid).updateChildValues([uid : 1]) { (err, ref) in
            USER_FOLLOWERS_REF.child(uid).updateChildValues([currentUid : 1], withCompletionBlock: completion)
        }
    }
    
    func unfollowUser(uid: String, completion: @escaping DatabaseCompletion) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        USER_FOLLOWING_REF.child(currentUid).child(uid).removeValue { (err, ref) in
            USER_FOLLOWERS_REF.child(uid).child(currentUid).removeValue(completionBlock: completion)
        }
    }
    
    func checkIfUserIsFollowed(uid: String, completion: @escaping (Bool) -> Void) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        USER_FOLLOWING_REF.child(currentUid).child(uid).observeSingleEvent(of: .value) {snapshot in
            completion(snapshot.exists())
        }
    }
    
    func fetchUserStats(uid: String, completion: @escaping (UserRelationStats) -> ()) {
        USER_FOLLOWERS_REF.child(uid).observeSingleEvent(of: .value) { snapshot in
            let followersCount = snapshot.children.allObjects.count
            
            USER_FOLLOWING_REF.child(uid).observeSingleEvent(of: .value) { snapshot in
                let followingCount = snapshot.children.allObjects.count
                let stats = UserRelationStats(followersCount: followersCount, followingCount: followingCount)
                completion(stats)
            }
        }
    }
    
    func updateProfileImage(image: UIImage, completion: @escaping (URL?) -> ()) {
        guard let imageData = image.jpegData(compressionQuality: 0.3) else { return }
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let filename = NSUUID().uuidString
        let ref = PROFILE_IMAGES_STORAGE.child(filename)
        ref.putData(imageData, metadata: nil) { meta, err in
            ref.downloadURL { profileImageUrl, error in
                guard let profileImageUrlString = profileImageUrl?.absoluteString else { return }
                let values = ["profileImageUrl": profileImageUrlString]
                USERS_REF.child(uid).updateChildValues(values) { err, ref in
                    completion(profileImageUrl)
                }
            }
        }
    }
    
    func saveUserData(user: User, completion: @escaping (DatabaseCompletion)) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let values = ["fullname": user.fullname, "username": user.username, "bio": user.bio]
        USERS_REF.child(uid).updateChildValues(values as [AnyHashable : Any], withCompletionBlock: completion)
    }
    
    func fetchUser(withUsername username: String, completion: @escaping (User) -> ()) {
        USER_USERNAMES_REF.child(username).observeSingleEvent(of: .value) { snapshot in
            guard let uid = snapshot.value as? String else { return }
            self.fetchUser(uid: uid, completion: completion)
        }
    }
}

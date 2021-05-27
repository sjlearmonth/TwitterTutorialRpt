//
//  EditProfileViewModel.swift
//  TwitterTutorialRpt
//
//  Created by Stephen Learmonth on 27/05/2021.
//

import UIKit

enum EditProfileOptions: Int, CaseIterable {
    case fullname
    case username
    case bio
    
    var description: String {
        switch self {
        case .username: return "Username"
        case .fullname: return "Name"
        case .bio: return "bio"
        }
    }
}

struct EditProfileViewModel {
    
    private let user: User
    let option: EditProfileOptions
    
    init(user: User, option: EditProfileOptions) {
        self.user = user
        self.option = option
    }
    
    var shouldHideTextField: Bool {
        return option == .bio
    }
    
    var shouldHideTextView: Bool {
        return option != .bio
    }
}

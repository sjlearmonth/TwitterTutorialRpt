//
//  EditProfileFooter.swift
//  TwitterTutorialRpt
//
//  Created by Stephen Learmonth on 04/06/2021.
//

import UIKit

protocol EditProfileFooterDelegate: AnyObject {
    func handleLogOutButtonTapped()
}

class EditProfileFooter: UIView {
    
    // MARK: - Properties
    
    private lazy var logOutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log Out", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16.0)
        button.addTarget(self, action: #selector(handleLogOutButtonTapped), for: .touchUpInside)
        button.backgroundColor = .red
        button.layer.cornerRadius = 5.0
        return button
    }()
    
    weak var delegate: EditProfileFooterDelegate?
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(logOutButton)
        logOutButton.anchor(left: leftAnchor, right: rightAnchor, paddingLeft: 16.0, paddingRight: 16.0)
        logOutButton.setHeight(to: 50.0)
        logOutButton.centerY(inView: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Selectors
    
    @objc func handleLogOutButtonTapped() {
        self.delegate?.handleLogOutButtonTapped()
    }
}

//
//  EditProfileCell.swift
//  TwitterTutorialRpt
//
//  Created by Stephen Learmonth on 27/05/2021.
//

import UIKit

class EditProfileCell: UITableViewCell {
    
    // MARK: - Properties
    
    var viewModel: EditProfileViewModel? {
        didSet { configure() }
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.text = "titleLabel"
        return label
    }()
    
    lazy var infoTextField: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .none
        tf.font = UIFont.systemFont(ofSize: 14.0)
        tf.textAlignment = .left
        tf.textColor = .twitterBlue
        tf.addTarget(self, action: #selector(handleUpdateUserInfo), for: .editingDidBegin)
        tf.text = "infoTextField"
        return tf
    }()
    
    let bioTextView: InputTextView = {
        let tv = InputTextView()
        tv.font = UIFont.systemFont(ofSize: 14.0)
        tv.textColor = .twitterBlue
        tv.placeholderLabel.text = "Bio"
        return tv
    }()
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        contentView.addSubview(titleLabel)
        titleLabel.setWidth(to: 100.0)
        titleLabel.anchor(top: topAnchor, left: leftAnchor, paddingTop: 12.0, paddingLeft: 16.0)
        
        contentView.addSubview(infoTextField)
        infoTextField.anchor(top: topAnchor, left: titleLabel.rightAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 4.0, paddingLeft: 16.0, paddingRight: 8.0)
        
        contentView.addSubview(bioTextView)
        bioTextView.anchor(top: topAnchor, left: titleLabel.rightAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 4.0, paddingLeft: 16.0, paddingRight: 8.0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Selectors
    
    @objc func handleUpdateUserInfo() {
        
    }
    
    // MARK: - Helper Functions
    
    func configure() {
        guard let viewModel = viewModel else { return }
        
        infoTextField.isHidden = viewModel.shouldHideTextField
        bioTextView.isHidden = viewModel.shouldHideTextView
    }
}

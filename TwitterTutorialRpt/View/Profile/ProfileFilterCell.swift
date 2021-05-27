//
//  ProfileFilterCell.swift
//  TwitterTutorialRpt
//
//  Created by Stephen Learmonth on 17/03/2021.
//

import UIKit

class ProfileFilterCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    var option: ProfileFilterOptions? {
        didSet { titleLabel.text = option?.description }
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.text = "Filter Option"
        return label
    }()
    
    override var isSelected: Bool {
        didSet {
            titleLabel.font = isSelected ? UIFont.boldSystemFont(ofSize: 16.0) : UIFont.systemFont(ofSize: 14.0)
            titleLabel.textColor = isSelected ? .twitterBlue : .lightGray
        }
    }
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(titleLabel)
        titleLabel.center(inView: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
//  CaptionTextView.swift
//  TwitterTutorialRpt
//
//  Created by Stephen Learmonth on 03/03/2021.
//

import UIKit

class InputTextView: UITextView {
    
    // MARK: - Properties
    
    let placeholderLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16.0)
        label.textColor = .darkGray
        label.text = "What's happening?"
        return label
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        backgroundColor = .white
        font = UIFont.systemFont(ofSize: 16.0)
        isScrollEnabled = false
        setHeight(to: 100.0)
        
        addSubview(placeholderLabel)
        placeholderLabel.anchor(top: topAnchor, left: leftAnchor, paddingTop: 8.0, paddingLeft: 4.0)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleTextInputChange), name: UITextView.textDidChangeNotification, object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- Selectors
    
    @objc func handleTextInputChange() {
        placeholderLabel.isHidden = text.isNotEmpty
    }
}

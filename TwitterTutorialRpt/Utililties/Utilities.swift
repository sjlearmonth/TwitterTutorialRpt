//
//  Utilities.swift
//  TwitterTutorialRpt
//
//  Created by Stephen Learmonth on 16/02/2021.
//

import UIKit

class Utilities {
    
    static let shared = Utilities()
    
    func createCustomInputContainerView(withImage image: UIImage, andTextField textField: UITextField) -> UIView {
        
        let view = UIView()
        let iv = UIImageView()
        view.setHeight(to: 50)
        iv.image = image
        view.addSubview(iv)
        iv.anchor(left: view.leftAnchor, bottom: view.bottomAnchor, paddingBottom: 8.0, width: 24.0, height: 24.0)
        
        view.addSubview(textField)
        textField.anchor(left: iv.rightAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingLeft: 8.0, paddingBottom: 8.0)
        
        let dividerView = UIView()
        dividerView.backgroundColor = .white
        view.addSubview(dividerView)
        dividerView.anchor(left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, height: 0.75)
        return view
    }
    
    func createCustomTextField(withPlaceholder placeholder: String) -> UITextField {
        let tf = UITextField()
        tf.textColor = .white
        tf.font = UIFont.systemFont(ofSize: 16.0)
        tf.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        tf.addTarget(self, action: #selector(handleEditingDidBegin), for: .editingDidBegin)
        tf.addTarget(self, action: #selector(handleEditingDidEnd), for: .editingDidEnd)
        return tf
    }
    
    @objc func handleEditingDidBegin(_ sender: UITextField) {
        sender.attributedPlaceholder = nil
    }
    
    @objc func handleEditingDidEnd(_ sender: UITextField) {
        
        if sender.tag == 0 {
            sender.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        } else {
            sender.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        }
    }
}

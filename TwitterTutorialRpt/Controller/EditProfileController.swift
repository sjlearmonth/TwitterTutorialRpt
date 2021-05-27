//
//  EditProfileController.swift
//  TwitterTutorialRpt
//
//  Created by Stephen Learmonth on 25/05/2021.
//

import UIKit

private let reuseIdentifier = "reuseIdentifier"

class EditProfileController: UITableViewController {
    
    // MARK: - Properties
    
    private let user: User
    private lazy var headerView = EditProfileHeader(user: user)
    
    // MARK: - Lifecycle
    
    init(user: User) {
        self.user = user
        super.init(style: .plain)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureTableView()
    }
    
    // MARK: - Selectors
    
    @objc func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func handleSave() {
        
    }
    
    // MARK: - API
    
    // MARK: - Helpers
    
    private func configureNavigationBar() {
        navigationController?.navigationBar.barTintColor = .twitterBlue
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.isTranslucent = false
//        navigationController?.navigationBar.tintColor = .white
        
//        navigationController?.navigationBar.topItem?.title = "Edit Profile"
        navigationItem.title = "Edit Profile"
//        navigationController?.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleCancel))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(handleCancel))
        navigationItem.leftBarButtonItem?.tintColor = .white
        navigationItem.leftBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 16.0)], for: .normal)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(handleSave))
        navigationItem.rightBarButtonItem?.tintColor = .white
        navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 16.0)], for: .normal)
        navigationItem.rightBarButtonItem?.isEnabled = false
    }
    
    private func configureTableView() {
        tableView.tableHeaderView = headerView
        headerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 180)
        tableView.tableFooterView = UIView()
        headerView.delegate = self
        tableView.register(EditProfileCell.self, forCellReuseIdentifier: reuseIdentifier)
    }
}

extension EditProfileController: EditProfileHeaderDelegate {
    func didTapChangeProfilePhoto() {
        
    }
}

extension EditProfileController {
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let option = EditProfileOptions(rawValue: indexPath.row) else { return 0.0 }
        return option == .bio ? 100 : 48
    }
}

extension EditProfileController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return EditProfileOptions.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! EditProfileCell
        
        guard let option = EditProfileOptions(rawValue: indexPath.row) else { return cell }
        return cell
    }
}

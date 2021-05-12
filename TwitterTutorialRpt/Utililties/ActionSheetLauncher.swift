//
//  ActionSheetLauncher.swift
//  TwitterTutorialRpt
//
//  Created by Stephen Learmonth on 11/05/2021.
//

import UIKit

private let reuseIdentifier = "ActionSheetCell"

class ActionSheetLauncher: NSObject {
    
    // MARK: - Properties
    
    private let user: User
    private let tableView = UITableView()
    private var window: UIWindow?
    private lazy var viewModel = ActionSheetViewModel(user: user)
    
    private lazy var blackView: UIView = {
        let view = UIView()
        view.alpha = 0.0
        view.backgroundColor = UIColor(white: 0, alpha: 0.5)
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleDismissal))
        view.addGestureRecognizer(tap)
        return view
    }()
    
    private lazy var footerView: UIView = {
        let view = UIView()
        view.addSubview(cancelButton)
        cancelButton.anchor(left: view.leftAnchor, right: view.rightAnchor, paddingLeft: 12.0, paddingRight: 12.0)
        cancelButton.centerY(inView: view)
        return view
    }()
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Cancel", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18.0)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .systemGroupedBackground
        button.addTarget(self, action: #selector(handleDismissal), for: .touchUpInside)
        button.setHeight(to: 50.0)
        button.layer.cornerRadius = 50.0 / 2.0
        return button
    }()
    
    // MARK: - Lifecycle
    
    init(user: User) {
        self.user = user
        super.init()
        configureTableView()
    }
    
    // MARK: - Selectors
    
    @objc func handleDismissal() {
        UIView.animate(withDuration: 0.4) {
            self.blackView.alpha = 0.0
            self.tableView.frame.origin.y += 300.0
            self.blackView.frame.origin.y += 300.0
        }

        
    }
    // MARK: - Helper Functions
    
    func show() {
        guard let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else { return }
        self.window = window
        
        window.addSubview(blackView)
        blackView.frame = window.frame

        window.addSubview(tableView)
        let height = CGFloat(viewModel.options.count * 60) + 100.0
        tableView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
        
        UIView.animate(withDuration: 0.4) {
            self.blackView.alpha = 1.0
            self.tableView.frame.origin.y -= height
            self.blackView.frame.origin.y -= height
        }
    }
    
    func configureTableView() {
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = 60.0
        tableView.separatorStyle = .none
        tableView.layer.cornerRadius = 5.0
        tableView.isScrollEnabled = false
        
        tableView.register(ActionSheetCell.self, forCellReuseIdentifier: reuseIdentifier)
    }
}

// MARK: - UITableViewDataSource

extension ActionSheetLauncher: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ActionSheetCell
        cell.option = viewModel.options[indexPath.row]
        return cell
    }
}

// MARK: - UITableViewDelegate

extension ActionSheetLauncher: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 60.0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return footerView
    }
}

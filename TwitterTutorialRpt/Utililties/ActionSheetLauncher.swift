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
    
    private lazy var blackView: UIView = {
        let view = UIView()
        view.alpha = 0.0
        view.backgroundColor = UIColor(white: 0, alpha: 0.5)
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleDismissal))
        view.addGestureRecognizer(tap)
        return view
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
        
        window.addSubview(tableView)
        tableView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: 300)
        
        window.addSubview(blackView)
        blackView.frame = window.frame
        
        UIView.animate(withDuration: 0.4) {
            self.blackView.alpha = 1.0
            self.tableView.frame.origin.y -= 300.0
            self.blackView.frame.origin.y -= 300.0
        }
    }
    
    func configureTableView() {
        tableView.backgroundColor = .red
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = 60.0
        tableView.separatorStyle = .none
        tableView.layer.cornerRadius = 5.0
        tableView.isScrollEnabled = false
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
    }
}

extension ActionSheetLauncher: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
//        cell.backgroundColor = .green
        return cell
    }
}

extension ActionSheetLauncher: UITableViewDelegate {

}

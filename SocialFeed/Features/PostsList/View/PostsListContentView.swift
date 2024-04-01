//
//  PostsListContentView.swift
//  SocialFeed
//
//  Created by Rachmat Wahyu Pramono on 31/03/24.
//

import Foundation
import UIKit

class PostsListContentView: UIView {
    lazy var tableView = UITableView()
    
    public init() {
        super.init(frame: .zero)
        backgroundColor = .white
        setupTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTableView() {
        addSubview(tableView)
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.estimatedRowHeight = 140
        tableView.rowHeight = UITableView.automaticDimension
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
        tableView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -16).isActive = true

        tableView.register(PostItemViewCell.self, forCellReuseIdentifier: "PostItemViewCell")
    }
}

//
//  PostDetailContentView.swift
//  SocialFeed
//
//  Created by Rachmat Wahyu Pramono on 01/04/24.
//

import Foundation
import UIKit

final class PostDetailContentView: UIView {
    lazy var tableView = UITableView()
    lazy var textfield = CommentTextFieldView()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.italicSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public init() {
        super.init(frame: .zero)
        backgroundColor = .white
        setupContentView()
        setupCommentTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupContentView() {
        addSubview(usernameLabel)
        usernameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
        usernameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        usernameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true

        addSubview(descriptionLabel)
        descriptionLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 8).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        
        addSubview(textfield)
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16).isActive = true
        textfield.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        textfield.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
    }
    
    private func setupCommentTableView() {
        addSubview(tableView)
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableView.automaticDimension
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.topAnchor.constraint(equalTo: textfield.bottomAnchor, constant: 16).isActive = true
        tableView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -16).isActive = true

        tableView.register(CommentItemViewCell.self, forCellReuseIdentifier: "CommentItemViewCell")
    }
    
    func configureValue(userName: String, description: String) {
        usernameLabel.text = "Posted by: \(userName)"
        descriptionLabel.text = description
    }
}

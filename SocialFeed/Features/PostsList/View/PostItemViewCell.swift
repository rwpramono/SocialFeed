//
//  PostItemViewCell.swift
//  SocialFeed
//
//  Created by Rachmat Wahyu Pramono on 31/03/24.
//

import Foundation
import Combine
import UIKit

internal class PostItemViewCell: UITableViewCell {
    private lazy var titleLabel = UILabel()
    private lazy var userNameLabel = UILabel()
    private lazy var descriptionLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        /*setupTouchArea*/()
        setupUserNameLabel()
        setupTitleLabel()
        setupDescriptionLabel()
//        setupContainerStackView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUserNameLabel() {
        contentView.addSubview(userNameLabel)
        
        userNameLabel.font = .systemFont(ofSize: 14)
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        userNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16).isActive = true
        userNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        userNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
    }
    
    private func setupTitleLabel() {
        contentView.addSubview(titleLabel)
        
        titleLabel.font = .boldSystemFont(ofSize: 14)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 24).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    private func setupDescriptionLabel() {
        contentView.addSubview(descriptionLabel)
        
        descriptionLabel.font = .systemFont(ofSize: 12)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16).isActive = true
    }
    
//    private func setupContainerStackView() {
//        contentView.addSubview(containerStackView)
//        
//        containerStackView.axis = .vertical
//        containerStackView.setCustomSpacing(16, after: touchAreaView)
//        containerStackView.translatesAutoresizingMaskIntoConstraints = false
//        containerStackView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
//        containerStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24).isActive = true
//        containerStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
//        containerStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16).isActive = true
//    }
    
    func configure(title: String, userName: String, desciption: String) {
        titleLabel.text = title
        userNameLabel.text = userName
        descriptionLabel.text = desciption
    }
}

//
//  PostItemViewCell.swift
//  SocialFeed
//
//  Created by Rachmat Wahyu Pramono on 31/03/24.
//

import Foundation
import Combine
import UIKit

class PostItemViewCell: UITableViewCell {
    private var postData: Post?
    
    let cellTapPublishers = PassthroughSubject<Post, Never>()
    let likeTapPublishers = PassthroughSubject<Int, Never>()

    let contentContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowOpacity = 0.4
        view.layer.shadowRadius = 4
        return view
    }()
    
    let userNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14) 
        label.textColor = .black 
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .black
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 3
        label.lineBreakMode = .byTruncatingTail
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        return label
    }()
    
    let likeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .white
        label.textAlignment = .center
        label.backgroundColor = UIColor.systemPink
        label.layer.cornerRadius = 4
        label.layer.masksToBounds = true
        label.isUserInteractionEnabled = true
        return label
    }()
    
    let commentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .blue
        label.textAlignment = .center
        label.layer.borderWidth = 1.0
        label.layer.borderColor = UIColor.blue.cgColor
        label.layer.cornerRadius = 4
        label.layer.masksToBounds = true
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupContentContainer()
        setupInteractionContainer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentContainer.layer.shadowPath = UIBezierPath(
            roundedRect: contentContainer.bounds,
            cornerRadius: contentContainer.layer.cornerRadius
        ).cgPath
    }
    
    private func setupContentContainer() {
        contentView.addSubview(contentContainer)
        contentContainer.addSubview(userNameLabel)
        contentContainer.addSubview(titleLabel)
        contentContainer.addSubview(descriptionLabel)

        NSLayoutConstraint.activate([
            contentContainer.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            contentContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            contentContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            contentContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            userNameLabel.topAnchor.constraint(equalTo: contentContainer.topAnchor, constant: 8),
            userNameLabel.leadingAnchor.constraint(equalTo: contentContainer.leadingAnchor, constant: 8),
            userNameLabel.trailingAnchor.constraint(equalTo: contentContainer.trailingAnchor, constant: -8),
            
            titleLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: contentContainer.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: contentContainer.trailingAnchor, constant: -8),

            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentContainer.leadingAnchor, constant: 8),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentContainer.trailingAnchor, constant: -8),
        ])
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cellTapped))
        contentView.addGestureRecognizer(tapGesture)
    }
    
    private func setupInteractionContainer() {
        contentContainer.addSubview(likeLabel)
        contentContainer.addSubview(commentLabel)
        
        NSLayoutConstraint.activate([
            likeLabel.widthAnchor.constraint(equalToConstant: 80),
            likeLabel.heightAnchor.constraint(equalToConstant: 24),
            likeLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 12),
            likeLabel.leadingAnchor.constraint(equalTo: contentContainer.leadingAnchor, constant: 8),
            
            commentLabel.widthAnchor.constraint(equalToConstant: 120),
            commentLabel.heightAnchor.constraint(equalToConstant: 24),
            commentLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 12),
            commentLabel.leadingAnchor.constraint(equalTo: likeLabel.trailingAnchor, constant: 16),
            commentLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentContainer.trailingAnchor, constant: -8),
            commentLabel.bottomAnchor.constraint(equalTo: contentContainer.bottomAnchor, constant: -8)
        ])
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(likeLabelTapped))
        likeLabel.addGestureRecognizer(tapGesture)
    }
    
    @objc private func likeLabelTapped() {
        guard let postData else { return }
        likeTapPublishers.send(postData.id)
    }

    @objc private func cellTapped() {
        guard let postData else { return }
        cellTapPublishers.send(postData)
    }

    func configure(post: Post) {
        postData = post
        titleLabel.text = post.title
        userNameLabel.text = post.userName
        descriptionLabel.text = post.description
        likeLabel.text = "\(post.totalLikes) Likes"
        commentLabel.text = "\(post.totalComments) Comments"
    }
}

//
//  CommentItemViewCell.swift
//  SocialFeed
//
//  Created by Rachmat Wahyu Pramono on 01/04/24.
//

import Foundation
import Combine
import UIKit

final class CommentItemViewCell: UITableViewCell {
    private var commentData: Comment?
    
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
    
    let commentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupContentContainer()
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
        contentContainer.addSubview(commentLabel)

        NSLayoutConstraint.activate([
            contentContainer.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            contentContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            contentContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            contentContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            commentLabel.heightAnchor.constraint(equalToConstant: 24),
            commentLabel.topAnchor.constraint(equalTo: contentContainer.topAnchor, constant: 8),
            commentLabel.leadingAnchor.constraint(equalTo: contentContainer.leadingAnchor, constant: 8),
            commentLabel.trailingAnchor.constraint(equalTo: contentContainer.trailingAnchor, constant: -8),
            commentLabel.bottomAnchor.constraint(equalTo: contentContainer.bottomAnchor, constant: -8)
        ])
    }

    func configure(comment: Comment) {
        commentData = comment
        commentLabel.text = comment.text
    }
}

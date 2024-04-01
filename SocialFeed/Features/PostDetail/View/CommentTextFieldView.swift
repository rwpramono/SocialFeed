//
//  CommentTextFieldView.swift
//  SocialFeed
//
//  Created by Rachmat Wahyu Pramono on 01/04/24.
//

import Combine
import Foundation
import UIKit

class CommentTextFieldView: UIView, UITextFieldDelegate {

    private let textField = UITextField()

    let textFieldPublishers = PassthroughSubject<String, Never>()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.placeholder = "Enter Comment"
        textField.delegate = self
        addSubview(textField)
        
        let submitButton = UIButton(type: .system)
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        submitButton.setTitle("Submit", for: .normal)
        submitButton.backgroundColor = .blue
        submitButton.layer.cornerRadius = 5

        submitButton.addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)
        addSubview(submitButton)
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),

            submitButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 8),
            submitButton.centerXAnchor.constraint(equalTo: textField.centerXAnchor),
            submitButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 8),
        ])
    }
    
    @objc func submitButtonTapped() {
        textFieldPublishers.send(textField.text ?? "")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textFieldPublishers.send(textField.text ?? "")
        textField.resignFirstResponder()
        return true
    }
}

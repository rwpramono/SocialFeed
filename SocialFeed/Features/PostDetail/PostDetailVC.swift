//
//  PostDetailVC.swift
//  SocialFeed
//
//  Created by Rachmat Wahyu Pramono on 30/03/24.
//

import Combine
import Foundation
import UIKit

class PostDetailVC: UIViewController {
    private var viewModel: PostDetailVM
    
    private lazy var contentView = PostDetailContentView()

    fileprivate var cancellables = Set<AnyCancellable>()

    init(viewModel: PostDetailVM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = viewModel.post?.title
        
        configureDataSource()
        configureDataBinding()
        
        viewModel.getAllCommentData()
    }
    
    override func loadView() {
        contentView.configureValue(
            userName: viewModel.post?.userName ?? "Unknown",
            description: viewModel.post?.description ?? "Unknown"
        )
        self.view = contentView
    }
    
    private func configureDataSource() {
        contentView.tableView.dataSource = self
    }
    
    private func configureDataBinding() {
        viewModel.$data
            .compactMap { $0 }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.contentView.tableView.reloadData()
            }
            .store(in: &cancellables)

        contentView.textfield.textFieldPublishers
            .filter { !$0.isEmpty }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] commentText in
                self?.viewModel.commentAPost(commentText)
            }
            .store(in: &cancellables)
    }
}

extension PostDetailVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.data?.comments.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CommentItemViewCell", for: indexPath) as? CommentItemViewCell,
              let data = viewModel.data?.comments[indexPath.row] else {
            return UITableViewCell()
        }
        
        cell.configure(comment: data)
        return cell
    }
}

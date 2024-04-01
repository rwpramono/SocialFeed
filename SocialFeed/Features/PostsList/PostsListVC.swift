//
//  PostsListVC.swift
//  SocialFeed
//
//  Created by Rachmat Wahyu Pramono on 30/03/24.
//

import Combine
import Foundation
import UIKit

final class PostsListVC: UIViewController {
    private var viewModel: PostsListVM
    private lazy var contentView = PostsListContentView()

    fileprivate var cancellables = Set<AnyCancellable>()

    init(viewModel: PostsListVM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = contentView
    }

    override func viewDidLoad() {
        let addButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Social Feed"

        configureDataSource()
        configureDataBinding()
        
        viewModel.getAllPostsData()
    }
    
    private func configureDataSource() {
        contentView.tableView.dataSource = self
    }
    
    private func configureDataBinding() {
        viewModel.$data
            .compactMap { $0 }
            .first(where: { !$0.isEmpty })
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.contentView.tableView.reloadData()
            }
            .store(in: &cancellables)
        
        viewModel.$errorMessage
            .dropFirst()
            .first(where: { !$0.isEmpty })
            .receive(on: DispatchQueue.main)
            .sink { [weak self] errorMessage in
                self?.title = "API Gateway Error: \(errorMessage)"
            }
            .store(in: &cancellables)

    }
    
    @objc private func addButtonTapped() {
        let alertController = UIAlertController(title: "New Article", message: "Enter article content", preferredStyle: .alert)
        
        alertController.addTextField { textField in
            textField.placeholder = "Title"
        }
        alertController.addTextField { textField in
            textField.placeholder = "Article content"
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let createAction = UIAlertAction(title: "Create", style: .default) { [weak self] _ in
            guard let title = alertController.textFields?.first?.text,
                  let content = alertController.textFields?.last?.text,
                  !title.isEmpty, !content.isEmpty else {
                return
            }
            self?.viewModel.postArticle(title: title, content: content)
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(createAction)
        
        present(alertController, animated: true, completion: nil)
    }
}

extension PostsListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostItemViewCell", for: indexPath) as? PostItemViewCell,
              let data = viewModel.data?[indexPath.row] else {
            return UITableViewCell()
        }
        
        cell.configure(post: data)
        cell.cellTapPublishers
            .sink { [weak self] postData in
                self?.navigateToDetail(postData: postData)
            }
            .store(in: &cancellables)
        
        cell.likeTapPublishers
            .sink { [weak self] postId in
                self?.viewModel.likeAPost(postId: postId)
            }
            .store(in: &cancellables)
        return cell
    }
    
    func navigateToDetail(postData: Post) {
        let detailVc = PostDetailFactory.makePostsDetailVC(postData: postData)
        self.navigationController?.pushViewController(detailVc, animated: true)
    }
}

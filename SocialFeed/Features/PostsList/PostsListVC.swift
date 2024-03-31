//
//  PostsListVC.swift
//  SocialFeed
//
//  Created by Rachmat Wahyu Pramono on 30/03/24.
//

import Foundation
import UIKit

class PostsListVC: UIViewController {
    private var viewModel: PostsListVM
    private lazy var contentView = PostsListContentView()

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
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Social Feed"

        configureDataSource()
        
        viewModel.getAllPostsData() { [weak self] in
            self?.contentView.tableView.reloadData()
        }
    }
    
    private func configureDataSource() {
        contentView.tableView.dataSource = self
        contentView.tableView.delegate = self
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
        
        cell.configure(title: data.title, userName: data.userName, desciption: data.description)
        return cell
    }
}

extension PostsListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.contentView.layer.masksToBounds = true
    }
}

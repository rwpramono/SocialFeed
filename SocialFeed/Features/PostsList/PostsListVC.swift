//
//  PostsListVC.swift
//  SocialFeed
//
//  Created by Rachmat Wahyu Pramono on 30/03/24.
//

import Combine
import Foundation
import UIKit

class PostsListVC: UIViewController {
    private var viewModel: PostsListVM
    private lazy var contentView = PostsListContentView()
    private lazy var bindings = Set<AnyCancellable>()

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
        configureBindings()
        configureDataSource()
        
        viewModel.getAllPostsData(nil)
    }
    
    private func configureBindings() {
        viewModel.$data
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] _ in
                self?.contentView.tableView.reloadData()
            })
            .store(in: &bindings)
    }

    private func configureDataSource() {
        contentView.tableView.dataSource = self
    }
}

extension PostsListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostItemViewCell", for: indexPath) as? PostItemViewCell,
              let data = viewModel.data?[indexPath.row]
//              indexPath.row < viewModel.categories.endIndex
        else {
            return UITableViewCell()
        }
        
        cell.configure(title: data.title, userName: data.userName, desciption: data.description)
        return cell
    }
}

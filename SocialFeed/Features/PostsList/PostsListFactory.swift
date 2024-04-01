//
//  PostsListFactory.swift
//  SocialFeed
//
//  Created by Rachmat Wahyu Pramono on 01/04/24.
//

import Foundation

class PostsListFactory {
    static func makePostsListVC() -> PostsListVC {
        let vm = PostsListVM(networkService: DependencyContainer.shared.networkService)
        return PostsListVC(viewModel: vm)
    }
}

//
//  PostDetailFactory.swift
//  SocialFeed
//
//  Created by Rachmat Wahyu Pramono on 01/04/24.
//

import Foundation

class PostDetailFactory {
    static func makePostsDetailVC() -> PostDetailVC {
        let vm = PostDetailVM(networkService: DependencyContainer.shared.networkService)
        return PostDetailVC(viewModel: vm)
    }
}

//
//  PostDetailFactory.swift
//  SocialFeed
//
//  Created by Rachmat Wahyu Pramono on 01/04/24.
//

import Foundation

final class PostDetailFactory {
    static func makePostsDetailVC(postData: Post) -> PostDetailVC {
        let vm = PostDetailVM(
            networkService: DependencyContainer.shared.networkService,
            post: postData
        )
        return PostDetailVC(viewModel: vm)
    }
}

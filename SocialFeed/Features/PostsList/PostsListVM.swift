//
//  PostsListVM.swift
//  SocialFeed
//
//  Created by Rachmat Wahyu Pramono on 30/03/24.
//

import Combine
import Foundation

class PostsListVM: ObservableObject {
    private let networkService: HttpNetwork

    private var cancellables = Set<AnyCancellable>()

    @Published var data: [Post]?

    init(networkService: HttpNetwork) {
        self.networkService = networkService
    }
    
    func getAllPostsData() {
        let api = PostAPICollection.getAllPostsMock()
        networkService.execute(api)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { [weak self] (resultData: PostsResponse) in
                    self?.data = resultData.posts
                }
            ).store(in: &cancellables)
    }
    
    func likeAPost(postId: Int) {
        let api = PostAPICollection.likeAPost(postId)
        networkService.execute(api)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { [weak self] (resultData: PostsResponse) in
                    self?.data = resultData.posts
                }
            ).store(in: &cancellables)
    }
}

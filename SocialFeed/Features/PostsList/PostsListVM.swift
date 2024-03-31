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

    private var bindings = Set<AnyCancellable>()

    @Published var data: [Post]?

    init(networkService: HttpNetwork) {
        self.networkService = networkService
    }
    
    internal func getAllPostsData(_ onComplete: (() -> ())?) {
        let api = PostAPICollection.getAllPostsMock()
        networkService.execute(api)
            .receive(on: RunLoop.main)
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        onComplete?()
                    case .failure(let error):
                        print("Some error \(error.localizedDescription)")
                    }
                },
                receiveValue: { [weak self] (resultData: PostsResponse) in
                    self?.data = resultData.posts
                }
            ).store(in: &bindings)
    }
}

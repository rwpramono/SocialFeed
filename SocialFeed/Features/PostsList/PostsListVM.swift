//
//  PostsListVM.swift
//  SocialFeed
//
//  Created by Rachmat Wahyu Pramono on 30/03/24.
//

import Combine
import Foundation

final class PostsListVM: ObservableObject {
    private let networkService: HttpNetwork

    private var cancellables = Set<AnyCancellable>()

    @Published var errorMessage: String = ""
    @Published var data: [Post]?

    init(networkService: HttpNetwork) {
        self.networkService = networkService
    }
    
    func getAllPostsData() {
        let api = PostAPICollection.getAllPostsMock()
        networkService.execute(api)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] completion in
                    if case .failure(let failure) = completion {
                        switch failure.localizedDescription {
                        case "429": self?.errorMessage = "Daily Quota Reached"
                        default:
                            self?.errorMessage = failure.localizedDescription
                        }
                    }
                },
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
                receiveValue: { [weak self] (_: PostsResponse) in
                    // FIXME: Dummy counter to simulate likes due to presistence mock, should be render given API resposnse
                    guard let self, let indexOfPost = self.data?.firstIndex(where: { $0.id == postId }) else { return }
                    var postData = self.data?[indexOfPost]
                    postData?.totalLikes += 1
                    self.data?[indexOfPost] = postData!
                }
            ).store(in: &cancellables)
    }
    
    func postArticle(title: String, content: String) {
        let api = PostAPICollection.createAPost(Post(id: 0, totalLikes: 0, totalComments: 0, title: title, description: content, userName: "Current User"))
        networkService.execute(api)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { [weak self] (postData: Post) in
                    guard let self else { return }
                    self.data?.append(postData)
                }
            ).store(in: &cancellables)

    }
}

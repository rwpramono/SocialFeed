//
//  PostDetailVM.swift
//  SocialFeed
//
//  Created by Rachmat Wahyu Pramono on 30/03/24.
//

import Combine
import Foundation

final class PostDetailVM: ObservableObject {
    private let networkService: HttpNetwork

    private var cancellables = Set<AnyCancellable>()
    
    var post: Post?
    @Published var data: CommentResponse?
    
    init(networkService: HttpNetwork, post: Post? = nil) {
        self.post = post
        self.networkService = networkService
    }
    
    func getAllCommentData() {
        guard let post else { return }
        let api = PostAPICollection.getAllCommentsofPostMock(post.id)
        networkService.execute(api)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { [weak self] (resultData: CommentResponse) in
                    self?.data = resultData
                }
            ).store(in: &cancellables)
    }
    
    func commentAPost(_ comment: String) {
        guard let post else { return }
        // FIXME: Get user id for comment
        let api = PostAPICollection.commentAPost(post.id, by: "current_user", with: comment)
        networkService.execute(api)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { [weak self] (resultData: CommentResponse) in
                    // FIXME: Dummy to simulate comment due to presistence mock, should be render given API resposnse
                    guard let self, var newComment = resultData.comments.last else { return }
                    newComment.text = comment
                    self.data?.comments.append(newComment)
                }
            ).store(in: &cancellables)
    }

}

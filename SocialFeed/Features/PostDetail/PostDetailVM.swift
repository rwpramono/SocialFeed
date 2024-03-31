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

    @Published var data: CommentResponse?
    
    init(networkService: HttpNetwork) {
        self.networkService = networkService
    }
    
    
}

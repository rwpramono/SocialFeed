//
//  PostsListVM.swift
//  SocialFeed
//
//  Created by Rachmat Wahyu Pramono on 30/03/24.
//

import Combine
import Foundation

class PostsListVM: ObservableObject {
    @Published var data: [Post]?
}

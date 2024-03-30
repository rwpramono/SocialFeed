//
//  PostsResponse.swift
//  SocialFeed
//
//  Created by Rachmat Wahyu Pramono on 30/03/24.
//

import Foundation

public struct PostsResponse: Codable {
    public let posts: [Post]

    public init(posts: [Post]) {
        self.posts = posts
    }
}

public struct Post: Codable {
    public let id, totalLikes, totalComments: Int
    public let title, description, userName: String

    enum CodingKeys: String, CodingKey {
        case id, title, description
        case userName = "user_name"
        case totalLikes = "total_likes"
        case totalComments = "total_comments"
    }

    public init(id: Int, title: String, description: String, userName: String, totalLikes: Int, totalComments: Int) {
        self.id = id
        self.title = title
        self.description = description
        self.userName = userName
        self.totalLikes = totalLikes
        self.totalComments = totalComments
    }
}

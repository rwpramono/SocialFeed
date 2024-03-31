//
//  PostsResponse.swift
//  SocialFeed
//
//  Created by Rachmat Wahyu Pramono on 30/03/24.
//

import Foundation

public struct PostsResponse: Codable {
    public let posts: [Post]
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
}

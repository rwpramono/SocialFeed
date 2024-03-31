//
//  CommentResponse.swift
//  SocialFeed
//
//  Created by Rachmat Wahyu Pramono on 30/03/24.
//

import Foundation

public struct Comment: Codable {
    public let id, userID, text: String

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case text
    }
}

public struct CommentResponse: Codable {
    public let totalComments: Int
    public let comments: [Comment]

    enum CodingKeys: String, CodingKey {
        case totalComments = "total_comments"
        case comments
    }
}

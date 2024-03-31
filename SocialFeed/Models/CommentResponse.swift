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

    // TODO: Delete if unecessary
//    public init(id: String, userID: String, text: String) {
//        self.id = id
//        self.userID = userID
//        self.text = text
//    }
}

public struct CommentResponse: Codable {
    public let totalComments: Int
    public let comments: [Comment]

    enum CodingKeys: String, CodingKey {
        case totalComments = "total_comments"
        case comments
    }

    // TODO: Delete if unecessary
//    public init(totalComments: Int, comments: [Comment]) {
//        self.totalComments = totalComments
//        self.comments = comments
//    }
}

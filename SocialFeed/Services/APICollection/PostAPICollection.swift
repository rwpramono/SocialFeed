//
//  PostAPICollection.swift
//  SocialFeed
//
//  Created by Rachmat Wahyu Pramono on 31/03/24.
//

import Foundation

public struct PostAPICollection {
    static func getAllPostsMock() -> APIDataRequest {
        QuickMockerAPI<PostsResponse>(.get, path: "/posts", body: [:], query: [:])
    }
    
    static func getAllCommentsofPostMock(_ postId: Int) -> APIDataRequest {
        QuickMockerAPI<PostsResponse>(.get, path: "/posts/\(postId)/comments", body: [:], query: [:])
    }
    
    static func createAPost(_ postData: Post) -> APIDataRequest {
        QuickMockerAPI<PostsResponse>(.post, path: "/posts", body: [:], query: [:])
    }
    
    static func likeAPost(_ postId: Int) -> APIDataRequest {
        QuickMockerAPI<PostsResponse>(.post, path: "/posts/\(postId)/likes", body: [:], query: [:])
    }
    
    static func commentAPost(_ postId: Int, by userId: String, with commentText: String) -> APIDataRequest {
        QuickMockerAPI<PostsResponse>(.post, path: "/posts/\(postId)/comments", body: [:], query: [:])
    }
}

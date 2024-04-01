//
//  PostAPICollection.swift
//  SocialFeed
//
//  Created by Rachmat Wahyu Pramono on 31/03/24.
//

import Foundation

public struct PostAPICollection {
    static func getAllPostsMock() -> APIDataRequest {
        QuickMockerAPI<PostsResponse>(.get, path: "/posts")
    }
    
    static func getAllCommentsofPostMock(_ postId: Int) -> APIDataRequest {
        QuickMockerAPI<CommentResponse>(.get, path: "/posts/\(postId)/comments")
    }
    
    static func createAPost(_ postData: Post) -> APIDataRequest {
        QuickMockerAPI<PostsResponse>(.post, path: "/posts")
    }
    
    static func likeAPost(_ postId: Int) -> APIDataRequest {
        QuickMockerAPI<PostsResponse>(.post, path: "/posts/\(postId)/likes")
    }
    
    static func commentAPost(_ postId: Int, by userId: String, with commentText: String) -> APIDataRequest {
        QuickMockerAPI<PostsResponse>(.post, path: "/posts/\(postId)/comments")
    }
}

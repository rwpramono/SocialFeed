//
//  PostDetailVMTests.swift
//  SocialFeedTests
//
//  Created by Rachmat Wahyu Pramono on 01/04/24.
//

import XCTest
import Combine
@testable import SocialFeed

final class PostDetailVMTests: XCTestCase {
    private var networkMock: NetworkServiceSpy!
    private var sut: PostDetailVM!
    
    let dummyPost = Post(id: 123, totalLikes: 0, totalComments: 0, title: "title", description: "description", userName: "userName")
    
    fileprivate var cancellables = Set<AnyCancellable>()

    override func setUpWithError() throws {
        networkMock = NetworkServiceSpy()
        sut = PostDetailVM(networkService: networkMock)
    }
    
    override func tearDownWithError() throws {
        sut = nil
        networkMock = nil
    }
    
    func test_getAllCommentData_shouldNotCallService_with_post_value_nil() throws {
        sut.getAllCommentData()

        XCTAssertNil(sut.post)
        XCTAssertNil(sut.data)
    }
    
    func test_commentAPost_shouldNotCallService_with_post_value_nil() throws {
        sut.commentAPost("TEST TEST")

        XCTAssertNil(sut.post)
        XCTAssertNil(sut.data)
    }

    func test_getAllCommentData_shouldCallService_with_results() throws {
        let expectation = self.expectation(description: "PostsListVMTests.GetAllPostsDataExpectation")
        URLProtocolMock.requestHandler = { request in
            let api = PostAPICollection.getAllCommentsofPostMock(123)
            let response = HTTPURLResponse(url: (api.urlComponent?.url)!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            let jsonString = """
            {
              "total_comments": 3,
              "comments": [
                {
                  "id": "(uniqueId)",
                  "user_id": "(uniqueId)",
                  "text": "(fakeRealText:50:5:en_US)"
                }
              ]
            }
            """
            let jsonData = Data(jsonString.utf8)
            return (response, jsonData)
        }
        
        sut.post = dummyPost
        sut.$data
            .dropFirst()
            .sink(receiveValue: { data in
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        sut.getAllCommentData()

        self.waitForExpectations(timeout: 10.0, handler: nil)

        XCTAssertNotNil(sut.data)
        XCTAssertEqual(sut.data?.comments.count, 1)
    }

    func test_commentAPost_shouldCallService_with_results() throws {
        let expectation = self.expectation(description: "PostsListVMTests.GetAllPostsDataExpectation")
        URLProtocolMock.requestHandler = { request in
            let api = PostAPICollection.commentAPost(1234, by: "1234", with: "TEST TEST")
            let response = HTTPURLResponse(url: (api.urlComponent?.url)!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            let jsonString = """
            {
              "total_comments": 3,
              "comments": [
                {
                  "id": "(uniqueId)",
                  "user_id": "(uniqueId)",
                  "text": "(fakeRealText:50:5:en_US)"
                }
              ]
            }
            """
            let jsonData = Data(jsonString.utf8)
            return (response, jsonData)
        }
        
        sut.post = dummyPost
        sut.data = CommentResponse(totalComments: 1, comments: [Comment(id: "123", userID: "TEST", text: "TEST TEST")])
        sut.$data
            .dropFirst()
            .sink(receiveValue: { data in
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        sut.commentAPost("TEST TEST")

        self.waitForExpectations(timeout: 10.0, handler: nil)

        XCTAssertNotNil(sut.data)
        XCTAssertEqual(sut.data?.comments.count, 2)
    }
}

//
//  PostsListVMTests.swift
//  SocialFeedTests
//
//  Created by Rachmat Wahyu Pramono on 01/04/24.
//

import XCTest
import Combine
@testable import SocialFeed

final class PostsListVMTests: XCTestCase {
    private var networkMock: NetworkServiceSpy!
    private var sut: PostsListVM!
    
    fileprivate var cancellables = Set<AnyCancellable>()

    override func setUpWithError() throws {
        networkMock = NetworkServiceSpy()
        sut = PostsListVM(networkService: networkMock)
    }
    
    override func tearDownWithError() throws {
        sut = nil
        networkMock = nil
    }
    
    func test_getAllPostsData_shouldCallService_with_results() throws {
        let expectation = self.expectation(description: "PostsListVMTests.DataExpectation")
        URLProtocolMock.requestHandler = { request in
            let api = PostAPICollection.getAllPostsMock()
            let response = HTTPURLResponse(url: (api.urlComponent?.url)!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            let jsonString = """
            {
                "posts": [
                    {
                        "id": 3,
                        "title": "Let me see--how IS it to be.",
                        "description": "Sunt aperiam iste aut voluptatibus perferendis voluptas quae illo perspiciatis corporis aut est aut.",
                        "user_name": "Aurore Barrows I",
                        "total_likes": 0,
                        "total_comments": 2
                    }
                ]
            }
            """
            let jsonData = Data(jsonString.utf8)
            return (response, jsonData)
        }
                
        sut.$data
            .dropFirst()
            .sink(receiveValue: { data in
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        sut.getAllPostsData()

        self.waitForExpectations(timeout: 10.0, handler: nil)

        XCTAssertNotNil(sut.data)
        XCTAssertEqual(sut.data?.count, 1)
    }

    func test_likeAPost_shouldCallService_with_results() throws {
        let dummyPost = Post(id: 123, totalLikes: 0, totalComments: 0, title: "title", description: "description", userName: "userName")
        let expectation = self.expectation(description: "PostsListVMTests.DataExpectation")
        URLProtocolMock.requestHandler = { request in
            let api = PostAPICollection.likeAPost(1234)
            let response = HTTPURLResponse(url: (api.urlComponent?.url)!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            let jsonString = """
            {
                "posts": [
                    {
                        "id": 3,
                        "title": "Let me see--how IS it to be.",
                        "description": "Sunt aperiam iste aut voluptatibus perferendis voluptas quae illo perspiciatis corporis aut est aut.",
                        "user_name": "Aurore Barrows I",
                        "total_likes": 0,
                        "total_comments": 2
                    }
                ]
            }
            """

            let jsonData = Data(jsonString.utf8)
            return (response, jsonData)
        }
        
        sut.data = [dummyPost, dummyPost, dummyPost]
        sut.$data
            .dropFirst()
            .sink(receiveValue: { data in
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        sut.likeAPost(postId: 123)

        self.waitForExpectations(timeout: 10.0, handler: nil)

        XCTAssertNotNil(sut.data)
        XCTAssertEqual(sut.data?.count, 3)
    }
    
    func test_createAPost_shouldCallService_with_results() throws {
        let dummyPost = Post(id: 123, totalLikes: 0, totalComments: 0, title: "title", description: "description", userName: "userName")
        let expectation = self.expectation(description: "PostsListVMTests.DataExpectation")
        URLProtocolMock.requestHandler = { request in
            let api = PostAPICollection.createAPost(dummyPost)
            let response = HTTPURLResponse(url: (api.urlComponent?.url)!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            let jsonString = """
            {
                "id": 3,
                "title": "Let me see--how IS it to be.",
                "description": "Sunt aperiam iste aut voluptatibus perferendis voluptas quae illo perspiciatis corporis aut est aut.",
                "user_name": "Aurore Barrows I",
                "total_likes": 0,
                "total_comments": 2
            }
            """

            let jsonData = Data(jsonString.utf8)
            return (response, jsonData)
        }
        
        sut.data = [dummyPost, dummyPost, dummyPost]
        sut.$data
            .dropFirst()
            .sink(receiveValue: { data in
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        sut.postArticle(title: "title", content: "description")

        self.waitForExpectations(timeout: 10.0, handler: nil)

        XCTAssertNotNil(sut.data)
        XCTAssertEqual(sut.data?.count, 4)
    }
}

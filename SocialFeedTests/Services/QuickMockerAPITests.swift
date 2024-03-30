//
//  QuickMockerAPITests.swift
//  SocialFeedTests
//
//  Created by Rachmat Wahyu Pramono on 30/03/24.
//

import XCTest

@testable import SocialFeed

class QuickMockerAPITests: XCTestCase {
    struct Dummy: Codable, Hashable {
        let dummyValue: String
    }
    
    func test_should_return_not_nil() throws {
        let sut = QuickMockerAPI<Dummy>(.patch, path: "/dummy", body: ["dummy":"dummy"], query: ["dummy":"dummy"])
        XCTAssertNotNil(sut.urlRequest)
        XCTAssertNotNil(sut.urlComponent)
    }
}

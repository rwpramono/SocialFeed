//
//  QuickMockerAPITests.swift
//  SocialFeedTests
//
//  Created by Rachmat Wahyu Pramono on 30/03/24.
//

import XCTest

@testable import SocialFeed

final class QuickMockerAPITests: XCTestCase {
    struct Dummy: Codable, Hashable {
        let dummyValue: String
    }
    
    func test_should_return_not_nil() throws {
        let sut = QuickMockerAPI<Dummy>(.patch, path: "/dummy")
            .body(["dummy":"dummy"])
            .query(["dummy":"dummy"])
        XCTAssertNotNil(sut.urlRequest)
        XCTAssertNotNil(sut.urlComponent)
        XCTAssertEqual(sut.urlComponent?.path, "/dummy")
        XCTAssertEqual(sut.urlComponent?.query, "dummy=dummy")
    }
    
    func test_with_invalid_path_should_return_nil() throws {
        let sut = QuickMockerAPI<Dummy>(.patch, path: "foo<bar>baz")
        XCTAssertNil(sut.urlRequest)
        XCTAssertNil(sut.urlComponent)
    }
    
    func test_with_invalid_base_url_should_return_nil() throws {
        let sut = QuickMockerAPI<Dummy>(.patch, path: "foo%zbar")
        XCTAssertNil(sut.urlRequest)
        XCTAssertNil(sut.urlComponent)
    }
}

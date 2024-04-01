//
//  CoreDataErrorTests.swift
//  SocialFeedTests
//
//  Created by Rachmat Wahyu Pramono on 30/03/24.
//

import XCTest

@testable import SocialFeed

final class CoreDataErrorTests: XCTestCase {
    
    func test_should_return_failed_to_save_with_reasons() throws {
        let sut = CoreDataError.loadFailed(HttpNetworkError.badRequest)
        XCTAssertEqual(sut.localizedDescription, "Failed to load: Bad request")
    }
    
    func test_should_return_failed_to_load_with_reasons() throws {
        let sut = CoreDataError.saveFailed(HttpNetworkError.badRequest)
        XCTAssertEqual(sut.localizedDescription, "Failed to save: Bad request")
    }
}

//
//  URLSessionServiceSpy.swift
//  SocialFeedTests
//
//  Created by Rachmat Wahyu Pramono on 30/03/24.
//

import Combine
import Foundation
@testable import SocialFeed

final class NetworkServiceSpy: URLSessionService {
    
    init() {
        let mockDecoder = JSONDecoder()
        let config: URLSessionConfiguration = .ephemeral
        config.protocolClasses = [URLProtocolMock.self]
        let mockSession = URLSession(configuration: config)
        super.init(session: mockSession, decoder: mockDecoder)
    }
}

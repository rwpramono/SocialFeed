//
//  DependencyContainer.swift
//  SocialFeed
//
//  Created by Rachmat Wahyu Pramono on 01/04/24.
//

import Foundation

final class DependencyContainer {
    static let shared = DependencyContainer()
    private init() {}

    private let jsonDecoder = JSONDecoder()
    private let urlSession = URLSession(configuration: .ephemeral)

    lazy var networkService: HttpNetwork = URLSessionCoreDataCacheService(session: urlSession, decoder: jsonDecoder)
}

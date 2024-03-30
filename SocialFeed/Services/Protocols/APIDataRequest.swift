//
//  APIDataRequest.swift
//  SocialFeed
//
//  Created by Rachmat Wahyu Pramono on 30/03/24.
//

import Foundation

internal protocol APIDataRequest {
    var urlRequest: URLRequest? { get }
    var urlComponent: URLComponents? { get }

    init(_ httpMethod: HttpMethod, path: String, body: [String: Any], query: [String: String])
}

//
//  QuickMockerAPI.swift
//  SocialFeed
//
//  Created by Rachmat Wahyu Pramono on 30/03/24.
//

import Foundation

public struct QuickMockerAPI<T: Decodable>: APIDataRequest {
    public private(set) var urlRequest: URLRequest?
    public private(set) var urlComponent: URLComponents?

    init(_ httpMethod: HttpMethod, path: String, body: [String : Any], query: [String : String]) {
        // FIXME: Change base url to get from xcconfig
        guard let baseUrl = URL(string: "https://t3s2gv7kzy.api.quickmocker.com"),
              var urlComponent = URLComponents(url: baseUrl, resolvingAgainstBaseURL: false) else {
            self.urlRequest = nil
            self.urlComponent = nil
            return
        }
        
        urlComponent.queryItems = query.map {
            URLQueryItem(name: $0.key, value: $0.value)
        }
        
        guard let completeUrl = urlComponent.url else {
            self.urlRequest = nil
            self.urlComponent = nil
            return
        }
        
        var urlRequest = URLRequest(url: completeUrl, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 60)
        urlRequest.httpMethod = httpMethod.rawValue
        urlRequest.allHTTPHeaderFields = ["Content-Type": "application/json"]
        
        let bodyData = try? JSONSerialization.data(withJSONObject: body)
        urlRequest.httpBody = bodyData

        self.urlComponent = urlComponent
        self.urlRequest = urlRequest
    }
}

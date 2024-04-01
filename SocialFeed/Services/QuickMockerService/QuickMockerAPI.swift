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
    
    init(_ httpMethod: HttpMethod, path: String) {
        // FIXME: Change base url to get from xcconfig
        guard var urlComponent = URLComponents(string: "https://une746ouv8.api.quickmocker.com" + path) else {
            self.urlRequest = nil
            self.urlComponent = nil
            return
        }
        var urlRequest = URLRequest(url: urlComponent.url!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 60)
        urlRequest.httpMethod = httpMethod.rawValue
        urlRequest.allHTTPHeaderFields = ["Content-Type": "application/json"]
        self.urlComponent = urlComponent
        self.urlRequest = urlRequest
    }

    public func body(_ body: [String : Any]) -> QuickMockerAPI<T> {
        var apiAttribute = self
        let bodyData = try? JSONSerialization.data(withJSONObject: body)
        apiAttribute.urlRequest?.httpBody = bodyData
        return apiAttribute
    }
    
    public func query(_ query: [String : String]) -> QuickMockerAPI<T> {
        var apiAttribute = self
        apiAttribute.urlComponent?.queryItems = query.map {
            URLQueryItem(name: $0.key, value: $0.value)
        }
        apiAttribute.urlRequest = URLRequest(url: (apiAttribute.urlComponent?.url)!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 60)
        return apiAttribute
    }
}

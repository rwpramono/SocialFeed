//
//  APIDataRequest.swift
//  SocialFeed
//
//  Created by Rachmat Wahyu Pramono on 30/03/24.
//

import Foundation

protocol APIDataRequest {
    var urlRequest: URLRequest? { get }
    var urlComponent: URLComponents? { get }

    init(_ httpMethod: HttpMethod, path: String)
    
    func body(_ body: [String : Any]) -> Self
    func query(_ query: [String : String]) -> Self
}

//
//  APIDataRequest.swift
//  SocialFeed
//
//  Created by Rachmat Wahyu Pramono on 30/03/24.
//

import Foundation

internal protocol APIDataRequest {
    var urlComponent: URLComponents { get }
    
    init(path: String, query: [String : String])
    
    func request(_ httpMethod: String) -> URLRequest?
}

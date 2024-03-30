//
//  HttpNetworkError.swift
//  SocialFeed
//
//  Created by Rachmat Wahyu Pramono on 30/03/24.
//

import Foundation

public enum NetworkServiceError: Error, LocalizedError {
    case failed
    case badRequest
    case noResponseData
    case invalidAPIDataRequest
    case unableToDecodeResponseData
    case other(message: String?)
    
    public var errorDescription: String? {
        switch self {
        case .failed:
            return "API request failed"
        case .badRequest:
            return "Bad request"
        case .noResponseData:
            return "Empty response data"
        case .invalidAPIDataRequest:
            return "Invalid API Data Protocol"
        case .unableToDecodeResponseData:
            return "Unable to decode response object"
        case .other(message: let message):
            return message
        }
    }
}

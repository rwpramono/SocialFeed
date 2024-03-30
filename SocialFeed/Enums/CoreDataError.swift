//
//  CoreDataError.swift
//  SocialFeed
//
//  Created by Rachmat Wahyu Pramono on 30/03/24.
//

import Foundation

public enum CoreDataError: Error, LocalizedError {
    case saveFailed(Error)
    case loadFailed(Error)
    
    public var errorDescription: String? {
        switch self {
        case .saveFailed(let error):
            return "Failed to save: \(error.localizedDescription)"
        case .loadFailed(let error):
            return "Failed to load: \(error.localizedDescription)"
        }
    }
}

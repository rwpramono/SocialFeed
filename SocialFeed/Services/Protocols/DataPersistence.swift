//
//  DataPersistence.swift
//  SocialFeed
//
//  Created by Rachmat Wahyu Pramono on 30/03/24.
//

import Foundation

protocol DataPersistence {
    associatedtype T: Codable
    
    func save(_ item: T) throws
    func load() throws -> T?
}

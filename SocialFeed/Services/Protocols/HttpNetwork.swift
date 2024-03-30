//
//  HttpNetwork.swift
//  SocialFeed
//
//  Created by Rachmat Wahyu Pramono on 30/03/24.
//

import Foundation
import Combine

protocol HttpNetwork: AnyObject {
    func execute<T: Codable>(_ apiData: APIDataRequest) -> AnyPublisher<T, Error>
}

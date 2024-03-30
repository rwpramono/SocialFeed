//
//  HttpNetwork.swift
//  SocialFeed
//
//  Created by Rachmat Wahyu Pramono on 30/03/24.
//

import Foundation
import Combine

protocol HttpNetwork: AnyObject {
    func fetch<T: Codable>(_ apiData: APIDataProtocol) -> AnyPublisher<T, Error>
}

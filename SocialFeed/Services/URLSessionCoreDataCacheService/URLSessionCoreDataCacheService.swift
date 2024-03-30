//
//  URLSessionService.swift
//  SocialFeed
//
//  Created by Rachmat Wahyu Pramono on 30/03/24.
//

import Combine
import Foundation

public class URLSessionCoreDataCacheService: HttpNetwork {
    let session: URLSession
    let decoder: JSONDecoder
    
    public init(session: URLSession, decoder: JSONDecoder) {
        self.session = session
        self.decoder = decoder
    }
    
    func execute<T: Codable>(_ apiData: APIDataRequest) -> AnyPublisher<T, Error> {
        guard let request = apiData.urlRequest else {
            return Fail(error: HttpNetworkError.invalidAPIDataRequest).eraseToAnyPublisher()
        }
        
        // TODO: Check if cache exist then return makeCachePublisher otherwise makeDataTaskPublisher
        return makeDataTaskPublisher(request, type: T.self)
    }
    
    private func makeCachePublisher<T: Codable>(_ urlRequest: URLRequest, type: T.Type) -> AnyPublisher<T, Error> {
        // FIXME: Change to Core Data access cache
        guard let cache = session.configuration.urlCache,
              let cacheData = cache.cachedResponse(for: urlRequest)?.data else
        {
            return makeDataTaskPublisher(urlRequest, type: T.self)
        }
        return Just(cacheData)
            .decode(type: T.self, decoder: decoder)
            .mapError { $0 as? HttpNetworkError ?? .noResponseData }
            .eraseToAnyPublisher()
    }
    
    private func makeDataTaskPublisher<T: Codable>(_ urlRequest: URLRequest, type: T.Type) -> AnyPublisher<T, Error> {
        session.dataTaskPublisher(for: urlRequest)
            .tryMap { [weak self] jsonData, response -> T in
                guard let self, let response = response as? HTTPURLResponse else {
                    throw HttpNetworkError.noResponseData
                }
                
                switch response.statusCode {
                case 200 ... 299: return try self.decoder.decode(T.self, from: jsonData)
                default: throw HttpNetworkError.other(message: "\(response.statusCode)")
                }
            }
            .mapError { errorMessage in
                errorMessage as? HttpNetworkError ?? HttpNetworkError.other(message: "\(errorMessage.localizedDescription)")
            }
            .eraseToAnyPublisher()
    }
}

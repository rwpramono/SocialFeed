//
//  URLSessionService.swift
//  SocialFeed
//
//  Created by Rachmat Wahyu Pramono on 30/03/24.
//

import Combine
import Foundation

public class NetworkService: HttpNetwork {
    let session: URLSession
    let decoder: JSONDecoder
    
    public init(session: URLSession, decoder: JSONDecoder) {
        self.session = session
        self.decoder = decoder
    }
    
    func fetch<T: Codable>(_ apiData: APIDataRequest) -> AnyPublisher<T, Error> {
        guard let request = apiData.request("GET") else {
            return Fail(error: NetworkServiceError.invalidAPIDataRequest).eraseToAnyPublisher()
        }

        return session.dataTaskPublisher(for: request)
            .mapError { _ in NetworkServiceError.badRequest }
            .flatMap { data, response -> AnyPublisher<Data, Error> in
                guard let response = response as? HTTPURLResponse else {
                    return Fail(error: NetworkServiceError.noResponseData).eraseToAnyPublisher()
                }

                guard 200..<300 ~= response.statusCode else {
                    return Fail(error: NetworkServiceError.other(message: "\(response.statusCode)"))
                        .eraseToAnyPublisher()
                }
                
                return Just(data)
                    .mapError { _ in NetworkServiceError.unableToDecodeResponseData }
                    .eraseToAnyPublisher()
            }
            .decode(type: T.self, decoder: decoder)
        .eraseToAnyPublisher()
    }
}

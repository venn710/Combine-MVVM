//
//  NetworkManager.swift
//  Combine+MVVM
//
//  Created by Venkatesham Boddula on 27/07/24.
//

import Foundation
import Combine

class NetworkManager {
    static let shared: NetworkManager = NetworkManager() // 1
    private init() {}
    func getData<T: Codable>(using urlString: String) -> AnyPublisher<T, APIError> { // 2
        
        do {
            guard let url = URL(string: urlString) else {
                throw APIError.invalidURL
            }
            return URLSession
                .shared
                .dataTaskPublisher(for: url) // 3
                .delay(for: 3, scheduler: DispatchQueue.main) // 4
                .tryMap { data, response in // 5
                    guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                        throw APIError.invalidResponse
                    }
                    let jsonDecoder = JSONDecoder()
                    return try jsonDecoder.decode(T.self, from: data) // 6
                }
                .mapError { error in // 7
                    if let error1 = error as? APIError {
                        return error1
                    }
                    if let _ = error as? DecodingError {
                        return APIError.invalidData
                    }
                    return APIError.defaultError(error.localizedDescription)
                }
                .eraseToAnyPublisher() // 8
        } catch { // 9
            if let error1 = error as? APIError {
                return Fail<T, APIError>(error: error1)
                    .eraseToAnyPublisher()
            }
            return Fail<T, APIError>(error: APIError.defaultError(error.localizedDescription))
                .eraseToAnyPublisher()
        }
    }
}

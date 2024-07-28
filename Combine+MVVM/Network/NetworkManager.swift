//
//  NetworkManager.swift
//  Combine+MVVM
//
//  Created by Venkatesham Boddula on 27/07/24.
//

import Foundation
import Combine

class NetworkManager {
    static let shared: NetworkManager = NetworkManager()
    func getData<T: Codable>() -> AnyPublisher<T, APIError> {
        return URLSession
            .shared
            .dataTaskPublisher(for: URL(string: "https://jsonplaceholder.typicode.com/todos")!)
            .delay(for: 3, scheduler: DispatchQueue.main)
            .tryMap { data, response in
                guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                    throw APIError.invalidResponse
                }
                let jsonDecoder = JSONDecoder()
                return try jsonDecoder.decode(T.self, from: data)
            }
            .mapError { error in
                if let error1 = error as? APIError {
                    return error1
                }
                if let _ = error as? DecodingError {
                    return APIError.invalidData
                }
                return APIError.defaultError(error.localizedDescription)
            }
            .eraseToAnyPublisher()
            }
}

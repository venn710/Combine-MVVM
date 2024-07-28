//
//  APIError.swift
//  Combine+MVVM
//
//  Created by Venkatesham Boddula on 27/07/24.
//

enum APIError: Error {
    case invalidURL
    case invalidData
    case invalidResponse
    case defaultError(String)
    
    var errorDescription: String {
        switch self {
        case .invalidURL:
            "Given URL is invalid"
        case .invalidData:
            "Data is Invalid"
        case .invalidResponse:
            "Response is invalid"
        case .defaultError(let string):
            "Something went wrong \(string)"
        }
    }
}

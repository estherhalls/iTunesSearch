//
//  NetworkError.swift
//  iTunesSearch
//
//  Created by Esther on 2/27/23.
//

import Foundation

enum NetworkError: LocalizedError {
    
    case invalidURL(URL)
    case thrownError(Error)
    case noData
    case unableToDecode
    
    var errorDescription: String? {
        switch self {
        case .invalidURL(let url):
            return "Unable to reach server. Please try again. \(url)"
        case .thrownError(let error):
            return "Error: \(error.localizedDescription) -> \(error)"
        case .noData:
            return "The server responded with no data. Please try again."
        case .unableToDecode:
            return "The server responded with invalid data. Please try again."
        }
    }
}

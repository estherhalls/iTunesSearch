//
//  NetworkingController.swift
//  iTunesSearch
//
//  Created by Esther on 2/27/23.
//

import Foundation

class NetworkingController {

    // Base URL
    private static let baseURL = URL(string: "https://itunes.apple.com/")
    
    // Keys for URL Components
    private static let kSearchComponent = "search"
    private static let kLookupComponent = "lookup"
    private static let kIDKey
    private static let kSearchTermKey = "term"
    private static let kEntityKey = "entity"
    private static let kEntityValue = "album"
    
    static func fetchAlbum(searchTermValue: String, completion: @escaping(Result<SearchResults, NetworkError>) -> Void) {
        // Step 1: URL
        guard let url = baseURL else {return}
        let searchURL = url.appending(path: kSearchComponent)
        // Add query items with URLComponent Struct
        var urlComponents = URLComponents(url: searchURL, resolvingAgainstBaseURL: true)
        // Query Items
        let searchQuery = URLQueryItem(name: kSearchTermKey, value: searchTermValue)
        let entityQuery = URLQueryItem(name: kEntityKey, value: kEntityValue)
        urlComponents?.queryItems = [searchQuery, entityQuery]
        // Final URL
        guard let finalURL = urlComponents?.url else {
            completion(.failure(.invalidURL(url)))
            return
        }
        print(finalURL)
        
        // Step 2: Data Task
        URLSession.shared.dataTask(with: finalURL) { dTaskData, _, error in
            if let error {
                print("Encountered error: \(error.localizedDescription)")
                completion(.failure(.thrownError(error)))
            }
            // Check for Data
            guard let albumData = dTaskData else {
                completion(.failure(.noData))
                return
            }
            // Convert to JSON (do, try, catch)
            do {
                let albums = try JSONDecoder().decode(SearchResults.self, from: albumData)
                completion(.success(albums))
            } catch {
                completion(.failure(.unableToDecode))
                return
            }
            // Resume starts dataTask and continues it; tasks begin in suspended state
        }.resume()
    }
    
    static func fetchTracks(collectionIDValue: String, completion: @escaping(Result<AlbumIDResults, NetworkError>) -> Void) {
        // Step 1: URL
        guard let url = baseURL else {return}
        let lookupURL = url.appending(path: kLookupComponent)
        // Add query items with URLComponent Struct
        var urlComponents = URLComponents(url: lookupURL, resolvingAgainstBaseURL: true)
        // Query Items
        let collectionIDQuery = URLQueryItem(name: kIDKey, value: collectionIDValue)
        let entityQuery = URLQueryItem(name: kEntityKey, value: kEntityValue)
        urlComponents?.queryItems = [collectionIDQuery, entityQuery]
        // Final URL
        guard let finalURL = urlComponents?.url else {
            completion(.failure(.invalidURL(url)))
            return
        }
        print(finalURL)
        
        // Step 2: Data Task
        URLSession.shared.dataTask(with: finalURL) { dTaskData, _, error in
            if let error {
                print("Encountered error: \(error.localizedDescription)")
                completion(.failure(.thrownError(error)))
            }
            // Check for Data
            guard let albumData = dTaskData else {
                completion(.failure(.noData))
                return
            }
            // Convert to JSON (do, try, catch)
            do {
                let tracks = try JSONDecoder().decode(AlbumIDResults.self, from: albumData)
                completion(.success(tracks))
            } catch {
                completion(.failure(.unableToDecode))
                return
            }
            // Resume starts dataTask and continues it; tasks begin in suspended state
        }.resume()
    }
    
    
} // End of Class

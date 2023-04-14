//
//  NetworkingController.swift
//  iTunesSearch
//
//  Created by Esther on 2/27/23.
//

import UIKit

class NetworkingController {

    // Base URL
    private static let baseURL = URL(string: "https://itunes.apple.com/")
    
    // Keys for URL Components
    private static let kSearchComponent = "search"
    private static let kLookupComponent = "lookup"
    private static let kIDKey = "id"
    private static let kSearchTermKey = "term"
    private static let kEntityKey = "entity"
    private static let kEntityAlbumValue = "album"
    private static let kEntitySongValue = "song"
    private static let kExcludeKey = "exclude"
    private static let kExcludeValue = "collection"
    
    // MARK: - Search List Data
    static func fetchAlbum(searchTermValue: String, completion: @escaping(Result<SearchResults, NetworkError>) -> Void) {
        // Step 1: URL
        guard let url = baseURL else {return}
        let searchURL = url.appending(path: kSearchComponent)
        // Add query items with URLComponent Struct
        var urlComponents = URLComponents(url: searchURL, resolvingAgainstBaseURL: true)
        // Query Items
        let searchQuery = URLQueryItem(name: kSearchTermKey, value: searchTermValue)
        let entityQuery = URLQueryItem(name: kEntityKey, value: kEntityAlbumValue)
//        let excludeWrapperQuery = URLQueryItem(name: kExcludeKey, value: kExcludeValue)
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
    
    // MARK: - Album Tracks List Data
    static func fetchTracks(collectionIDValue: Int, completion: @escaping(Result<AlbumIDResults, NetworkError>) -> Void) {
        // Step 1: URL
        guard let url = baseURL else {return}
        let lookupURL = url.appending(path: kLookupComponent)
        // Add query items with URLComponent Struct
        var urlComponents = URLComponents(url: lookupURL, resolvingAgainstBaseURL: true)
        // Query Items
        let collectionIDQuery = URLQueryItem(name: kIDKey, value: "\(collectionIDValue)")
        let entityQuery = URLQueryItem(name: kEntityKey, value: kEntitySongValue)
 
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
    
    // MARK: - Album Image
    static func fetchImage(with imageURL: String, completion: @escaping (Result<UIImage, NetworkError>) -> Void) {
        // Construct URL
        guard let url = URL(string: imageURL) else {return}
        // Data Task
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error {
                print("There was an error with image data task: \(error.localizedDescription)")
                completion(.failure(.thrownError(error)))
            }
            guard let imageData = data else {
                completion(.failure(.noData))
                return }
            guard let image = UIImage(data: imageData) else {
                completion(.failure(.unableToDecode))
                return
            }
            completion(.success(image))
            
        }.resume()
    }
    
    
} // End of Class

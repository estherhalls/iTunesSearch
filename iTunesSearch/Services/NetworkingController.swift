//
//  NetworkingController.swift
//  iTunesSearch
//
//  Created by Esther on 2/27/23.
//

import Foundation

class NetworkingController {
    // Required Technologies: Codable, Result Type, Custom Errors, Capture Lists
//https://itunes.apple.com/search?entity=album&limit=25&term=AlkalineTrio
    
    // Base URL
    private static let baseURL = URL(string: "https://itunes.apple.com/")
    
    // Keys for URL Components
    private static let kSearchComponent = "search"
    private static let kSearchTermKey = "term"
    private static let kEntityKey = "entity"
    private static let kEntityValue = "album"
    
    static func fetchAlbum(with searchTermValue: String, completion: @escaping(Result<Album, NetworkError>) -> Void) {
        
        // Step 1: URL
        guard let url = baseURL else {return}
        let searchURL = url.appending(path: kSearchComponent)
        // Add query items with URLComponent Struct
        var urlComponents = URLComponents(url: searchURL, resolvingAgainstBaseURL: true)
        // Query Items
        let searchQuery = URLQueryItem(name: kSearchTermKey, value: searchTermValue)
        let entityQuery = URLQueryItem(name: kEntityKey, value: kEntityValue)
        urlComponents?.queryItems = [searchQuery, entityQuery]
        
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
                let album = try JSONDecoder().decode(Album.self, from: albumData)
                completion(.success(album))
            } catch {
                completion(.failure(.unableToDecode))
                return
            }
            // Resume starts dataTask and continues it; tasks begin in suspended state
        }.resume()
    }
    
} // End of Class
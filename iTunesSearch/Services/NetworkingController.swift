//
//  NetworkingController.swift
//  iTunesSearch
//
//  Created by Esther on 2/27/23.
//

import Foundation

class NetworkingController {
    // Required Technologies: Codable, Result Type, Custom Errors, Capture Lists
    // Album Detail URL: https://itunes.apple.com/lookup?entity=song&id=320412048
    
    private static let baseURLString = "https://itunes.apple.com/lookup"
    
    static func fetchAlbum(with url: URL, completion: @escaping(Result<Album, NetworkError>) -> Void) {
        
        // Step 1: URL
        // Step 2: Data Task
        URLSession.shared.dataTask(with: url) { dTaskData, _, error in
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

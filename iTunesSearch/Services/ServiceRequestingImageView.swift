//
//  ServiceRequestingImageView.swift
//  iTunesSearch
//
//  Created by Esther on 2/27/23.
//

import UIKit

class ServiceRequestingImageView: UIImageView {
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
}

//
//  AlbumTableViewCell.swift
//  iTunesSearch
//
//  Created by Esther on 2/27/23.
//

import UIKit

class AlbumTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var albumImageView: UIImageView!
    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var trackQTYLabel: UILabel!
    
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureSearchList(with album: Album) {
       setImage(from: album)
        albumNameLabel.text = album.collectionName
        trackQTYLabel.text = "\(album.trackCount)"
        artistNameLabel.text = album.artistName
    }
    
    func setImage(from album: Album) {
        let imageURL = album.artworkURL
        NetworkingController.fetchImage(with: imageURL) { [weak self] result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self?.albumImageView.image = image
                }
            case .failure(let error):
                print("There was an error retrieving the image!", error.errorDescription!)
            }
        }
    }

} // End of Class

//
//  AlbumTableViewCell.swift
//  iTunesSearch
//
//  Created by Esther on 2/27/23.
//

import UIKit

class AlbumTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var albumImageView: ServiceRequestingImageView!
    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var trackQTYLabel: UILabel!
    
    // album to pass from list to detail view
    var album: Album?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(with album: Album) {
        fetchImage(from: album)
        self.album = album
//        albumImageView.layer.cornerRadius = 50
        albumNameLabel.text = album.collectionName
        trackQTYLabel.text = "\(album.trackCount)"
    }
    
    func fetchImage(from album: Album) {
        guard let imageURL = album.artworkURL else {return}
        ServiceRequestingImageView.fetchImage(with: imageURL) { [weak self] result in
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
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

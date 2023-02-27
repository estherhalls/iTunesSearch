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
    
    var album: Album?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configure(with album: Album) {
        albumImageView.layer.cornerRadius = 50
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

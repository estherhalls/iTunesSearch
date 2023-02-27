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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

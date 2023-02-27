//
//  TrackTableViewCell.swift
//  iTunesSearch
//
//  Created by Esther on 2/27/23.
//

import UIKit

class TrackTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var trackNumberLabel: UILabel!
    @IBOutlet weak var trackTitleLabel: UILabel!
    @IBOutlet weak var trackDurationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

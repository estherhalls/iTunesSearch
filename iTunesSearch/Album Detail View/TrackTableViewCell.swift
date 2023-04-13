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
    }

    func configureTracksList(with track: Track) {
        DispatchQueue.main.async {
            self.trackNumberLabel.text = "\(String(describing: track.trackNumber))"
            self.trackTitleLabel.text = track.trackName
            self.trackDurationLabel.text = "\(String(describing: track.trackTime))"
        }
    }


} // End of Class

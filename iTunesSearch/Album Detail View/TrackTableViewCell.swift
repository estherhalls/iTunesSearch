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
    
    
    // MARK: - Properties
    let units = UnitConversion()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureTracksList(with track: Track) {
        DispatchQueue.main.async {
            if let trackNumber = track.trackNumber {
                self.trackNumberLabel.text = "\(trackNumber)"
            }
            self.trackTitleLabel.text = track.trackName
            if let trackTime = track.trackTime {
                let duration = self.units.millisToMinSec(millis: trackTime)
                self.trackDurationLabel.text = duration
            }
        }
    }
    
    
} // End of Class

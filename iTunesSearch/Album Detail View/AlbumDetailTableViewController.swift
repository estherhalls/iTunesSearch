//
//  AlbumDetailTableViewController.swift
//  iTunesSearch
//
//  Created by Esther on 2/27/23.
//

import UIKit

class AlbumDetailTableViewController: UITableViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var albumImageView: UIImageView!
    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    
    // Receiver Property
    var album: Album? {
        didSet {
            updateViews()
        }
    }
    
    // Album and Track Data for TableView
    var albumData: AlbumIDResults? {
        didSet {
            updateData()
        }
    }
    
    var tracks: [Track] = []
 
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Methods
    func updateData(){
        guard let albumData = albumData else {return}
        tracks = albumData.results
        
        let filteredTracks = tracks.filter { track in
            for (_, value) in track {
                if value == nil {
                    return false
                }
            }
            return true
        }
     
        tableView.reloadData()
    }
    
    func updateViews() {
        guard let album = album else {return}
        let imageURL = album.artworkURL
        
        NetworkingController.fetchImage(with: imageURL) { [weak self] result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self?.albumImageView.image = image
                    self?.albumNameLabel.text = album.collectionName
                    self?.artistNameLabel.text = album.artistName
                }
            case .failure(let error):
                print("There was an error retrieving the image!", error.errorDescription!)
            }
        }
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return tracks.count
    }

     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         guard let cell = tableView.dequeueReusableCell(withIdentifier: "trackCell", for: indexPath) as? TrackTableViewCell else { return UITableViewCell() }
         let track = tracks[indexPath.row]
             cell.configureTracksList(with: track)

     return cell
     }
} // End of Class

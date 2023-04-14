//
//  AlbumDetailViewController.swift
//  iTunesSearch
//
//  Created by Esther on 4/14/23.
//

import UIKit

class AlbumDetailViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var albumTitleLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var albumTracksTableView: UITableView!
    @IBOutlet weak var albumImageView: UIImageView!
    
    // MARK: - Properties
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
    var selectedTracks: [Track] = []
    var filteredTracks: [Track] = []
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        albumTracksTableView.dataSource = self
        albumTracksTableView.delegate = self
    }
    
    // MARK: - Methods
    // I need to filter out any AlbumIDResult dictionary that has a wrapperType value of 'collection' because those are the results that are not tracks and return nil for track-specific properties.
    func updateData(){
        guard let albumData = albumData else {return}
        selectedTracks = albumData.results
        filteredTracks = selectedTracks.filter { $0.wrapperType == "track" }
        print(filteredTracks)
        DispatchQueue.main.async {
            self.albumTracksTableView.reloadData()
        }
        
    }
    
    func updateViews() {
        guard let album = album else {return}
        let imageURL = album.artworkURL
        
        NetworkingController.fetchImage(with: imageURL) { [weak self] result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self?.albumImageView.image = image
                    self?.albumTitleLabel.text = album.collectionName
                    self?.artistNameLabel.text = album.artistName
                }
            case .failure(let error):
                print("There was an error retrieving the image!", error.errorDescription!)
            }
        }
    }
    
} // End of Class

// MARK: - Extensions
// Table View Data Source
extension AlbumDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredTracks.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "trackCell", for: indexPath) as? TrackTableViewCell else { return UITableViewCell() }
        let track = filteredTracks[indexPath.row]
        cell.configureTracksList(with: track)
        
        return cell
    }
}

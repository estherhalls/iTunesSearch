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
    }
    
    // MARK: - Methods
    // I need to filter out any AlbumIDResult dictionary that has a wrapperType value of 'collection' because those are the results that are not tracks and return nil for track-specific properties.
    func updateData(){
        guard let albumData = albumData else {return}
        selectedTracks = albumData.results
        filteredTracks = selectedTracks.filter { $0.wrapperType == "track" }
        print(filteredTracks)
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

        return filteredTracks.count
    }
//    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 30))
//        headerView.backgroundColor = .lightGray
//        
//        let leftLabel = UILabel(frame: CGRect(x: 10, y: 0, width: headerView.frame.width/3, height: headerView.frame.height))
//        leftLabel.textAlignment = .left
//        leftLabel.text = "#"
//        headerView.addSubview(leftLabel)
//        
//        let centerLabel = UILabel(frame: CGRect(x: headerView.frame.width/3, y: 0, width: headerView.frame.width/3, height: headerView.frame.height))
//        centerLabel.textAlignment = .center
//        centerLabel.text = "Track Title"
//        headerView.addSubview(centerLabel)
//        
//        let rightLabel = UILabel(frame: CGRect(x: (headerView.frame.width/3) * 2, y: 0, width: headerView.frame.width/3, height: headerView.frame.height))
//        rightLabel.textAlignment = .right
//        rightLabel.text = "Duration"
//        headerView.addSubview(rightLabel)
//        
//        return headerView
//    }

     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         guard let cell = tableView.dequeueReusableCell(withIdentifier: "trackCell", for: indexPath) as? TrackTableViewCell else { return UITableViewCell() }
         let track = filteredTracks[indexPath.row]
             cell.configureTracksList(with: track)

     return cell
     }
} // End of Class

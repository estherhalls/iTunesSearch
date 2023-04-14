//
//  iTunesSearchTableViewController.swift
//  iTunesSearch
//
//  Created by Esther on 2/27/23.
//

import UIKit

class iTunesSearchTableViewController: UITableViewController, UISearchBarDelegate {
    
    // MARK: - Properties
    lazy var searchBar = UISearchBar()
    var placeholderView: UIImageView!
    var albums: [Album] = []
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Searchbar Setup
        searchBar.delegate = self
        searchBar.searchBarStyle = UISearchBar.Style.default
        searchBar.placeholder = "Search Music"
        searchBar.sizeToFit()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        navigationItem.titleView = searchBar
        
        
        // Placeholder Logo View Setup
        placeholderView = UIImageView(image: UIImage(named: "iTunesLogo"))
        placeholderView.alpha = 0.5
        placeholderView.contentMode = .scaleAspectFit
        placeholderView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(placeholderView)
        
        NSLayoutConstraint.activate([
            placeholderView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            placeholderView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 15),
            placeholderView.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: -100),
            placeholderView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        placeholderView.isHidden = false
        // Check if user is returning from detail view
        if !isBeingPresented && !isMovingToParent {
            placeholderView.isHidden = true
        }
    }
    
    // MARK: - Table View Data Source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return albums.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "albumCell", for: indexPath) as? AlbumTableViewCell else { return UITableViewCell() }
        let album = albums[indexPath.row]
        cell.configureSearchList(with: album)
        
        return cell
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailVC",
           let destinationVC = segue.destination as? AlbumDetailViewController {
            if let indexPath = tableView.indexPathForSelectedRow {
                let dataToSend = self.albums[indexPath.row]
                destinationVC.album = dataToSend
                // Network Call for Tracks
                NetworkingController.fetchTracks(collectionIDValue: dataToSend.collectionID) { result in
                    switch result {
                    case .success(let albumIDResult):
                            destinationVC.albumData = albumIDResult
                    case .failure(let error):
                        print("There was an error fetching data for album tracks", error.errorDescription!)
                    }
                }
            }
        }
    }
 
} // End of Class

// MARK: - Search Bar Delegate Extension
// User must be able to search Artist name or album name to return results
extension iTunesSearchTableViewController {
    //    @objc func searchBarButtonClicked() {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            albums.removeAll()
            placeholderView.isHidden = false
            tableView.reloadData()
        } else {
            placeholderView.isHidden = true
            NetworkingController.fetchAlbum(searchTermValue: searchText) { result in
                switch result {
                case .success(let albums):
                    self.albums = albums.results
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                case .failure(let error):
                    print("There was an error fetching results!", error.errorDescription!)
                }
            }
        }
    }
} // End Class

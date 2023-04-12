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
    var albums: [Album] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
        searchBar.searchBarStyle = UISearchBar.Style.default
        searchBar.placeholder = "Search Music"
        searchBar.sizeToFit()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchBarButtonClicked))
        navigationItem.titleView = searchBar

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
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
   

}

// MARK: - Search Bar Delegate Extension
// User must be able to search Artist name or album name to return results
extension iTunesSearchTableViewController {
    @objc func searchBarButtonClicked() {
        searchBar.resignFirstResponder()
        guard let searchTerm = searchBar.text else {
            print ("Search Value Empty")
            return
        }
        
        NetworkingController.fetchAlbum(searchTermValue: searchTerm) { result in
            switch result {
            case .success(let albums):
                self.albums = albums.results
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.searchBar.resignFirstResponder()
                }
            case .failure(let error):
                print("There was an error fetching results!", error.errorDescription!)
            }
        }
    }
} // End Class

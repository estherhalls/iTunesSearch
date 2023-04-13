//
//  Album.swift
//  iTunesSearch
//
//  Created by Esther on 2/27/23.
//

import Foundation

struct SearchResults: Decodable {
    let results: [Album]
}

struct Album: Decodable {
    private enum CodingKeys: String, CodingKey {
        case wrapperType
        case artistName
        case collectionType
        case collectionID = "collectionId"
        case collectionName
        case artworkURL = "artworkUrl100"
        case trackCount
    }
    
    let wrapperType: String
    let artistName: String
    let collectionType: String // Album
    let collectionID: Int // Shared with album and tracks in the album - passed on to pull track info for detail pagee
    let collectionName: String // Album Name
    let artworkURL: String
    let trackCount: Int

    
} // End of Struct

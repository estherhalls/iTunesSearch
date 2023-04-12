//
//  Album.swift
//  iTunesSearch
//
//  Created by Esther on 2/27/23.
//

import Foundation

struct Album: Decodable {
    private enum CodingKeys: String, CodingKey {
        case wrapperType
        case collectionType
        case artistID = "artistId"
        case artistName
        case collectionName
        case artworkURL = "artworkUrl100"
        case trackCount
//        case kind
//        case collectionID = "collectionId"
//        case trackID = "trackId"
//        case trackName
//        case trackNumber
//        case primaryGenre = "primaryGenreName"
    }
    let wrapperType: String
    let collectionType: String // Album
    let artistID: Int
    let artistName: String
    let collectionName: String // Album Name
    let artworkURL: String?
    let trackCount: Int
    
//    let kind: String
//    let collectionID: Int
//    let trackID: Int
//    let trackName: String
//    let trackNumber: Int
//    let primaryGenre: String
    
    // Duration?
    
} // End of Struct

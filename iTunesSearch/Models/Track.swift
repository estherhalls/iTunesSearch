//
//  Track.swift
//  iTunesSearch
//
//  Created by Esther on 2/27/23.
//

import Foundation

struct Track: Decodable {
    private enum CodingKeys: String, CodingKey {
        case kind
        case collectionID = "collectionId"
        case trackID = "trackId"
        case trackName
        case trackNumber
        case primaryGenre = "primaryGenreName"
    }

    let kind: String
    let collectionID: Int
    let trackID: Int
    let trackName: String
    let trackNumber: Int
    let primaryGenre: String
    // Duration?
    
} // End of Struct

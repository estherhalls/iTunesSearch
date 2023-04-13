//
//  Track.swift
//  iTunesSearch
//
//  Created by Esther on 2/27/23.
//

import Foundation

struct AlbumIDResults: Decodable {
    let results: [Track]
}

struct Track: Decodable {
    private enum CodingKeys: String, CodingKey {
        case wrapperType
        case collectionName
        case collectionID = "collectionId"
        case artistName
        case artworkURL = "artworkUrl100"
        case trackCount
        case trackName
        case trackNumber
        case primaryGenre = "primaryGenreName"
        case trackTime = "trackTimeMillis"
    }
    
    let wrapperType: String?
    let collectionName: String
    let collectionID: Int
    let artistName: String
    let artworkURL: String
    let trackCount: Int?
    let trackName: String?
    let trackNumber: Int?
    let primaryGenre: String?
    let trackTime: Int? // duration in Milliseconds
    
    
} // End of Struct

//
//  PlaylistTests.swift
//  MySpotify
//
//  Created by Vladislav Fitc on 26.10.16.
//  Copyright © 2016 Fitc. All rights reserved.
//

import Foundation
import XCTest
import Unbox
@testable import MySpotify

class PlaylistTests: XCTestCase {
    
    func testStringConvertible() {
        let playlist = Playlist(id: "playlistID", name: "playlistName", tracks: .tracks([]))
        
        XCTAssertEqual(playlist.description, "playlistName - 0 tracks")
    }
    
    func testUnbox() {
        
        let id = "playlistID"
        let name = "playlistName"
        let tracksLink = "tracksLink"
        let tracksCount = 4
        
        let playlistDictionary: [String: Any] = [
            "id": id,
            "name": name,
            "tracks": [
                "href": tracksLink,
                "total": tracksCount
            ]
        ]
        
        do {
            let playlist: Playlist = try unbox(dictionary: playlistDictionary)
            XCTAssertEqual(playlist.id, id)
            XCTAssertEqual(playlist.name, name)

            
        } catch let error {
            XCTFail("\(error)")
        }
        
    }
    
    func testDictionaryRepresentable() {
        
        let id = "playlistID"
        let name = "playlistName"
        
        let playlist = Playlist(id: id, name: name, tracks: .tracks([]))
        
        let playlistDictionary = playlist.dictionary
        
        XCTAssertEqual(playlistDictionary.value(forKey: "id") as? String, id)
        XCTAssertEqual(playlistDictionary.value(forKey: "name") as? String, name)
        XCTAssertNotNil(playlistDictionary.value(forKey: "tracks_representation"))

        let decodedPlaylist = Playlist(dictionary: playlistDictionary)
        
        XCTAssertEqual(decodedPlaylist?.id, id)
        XCTAssertEqual(decodedPlaylist?.name, name)

        
    }
    
}

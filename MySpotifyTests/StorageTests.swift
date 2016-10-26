//
//  StorageTests.swift
//  MySpotify
//
//  Created by Vladislav Fitc on 26.10.16.
//  Copyright © 2016 Fitc. All rights reserved.
//

import Foundation
import XCTest
@testable import MySpotify

class StorageTests: XCTestCase {
    
    override func setUp() {
        
        let tracks = [
            Track(id: "t1", title: "t1", artists: [], tempo: .none),
            Track(id: "t2", title: "t2", artists: [], tempo: .none)
        ]
        
        let playlist1 = Playlist(id: "p1", name: "p1", tracks: .tracks([]))
        let playlist2 = Playlist(id: "p2", name: "p2", tracks: .tracks(tracks))
        let playlist3 = Playlist(id: "p3", name: "p3", tracks: .url("TracksURL", count: 10))

        let playlists = [
            playlist1,
            playlist2,
            playlist3
        ]
        
        Storage.sharedInstance.playlists = playlists
    }
    
    override func tearDown() {
        Storage.sharedInstance.playlists = []
    }
    
    
    
    func testFetchTracks() {
        let fetchedTracks = Storage.sharedInstance.tracks(forPlaylistWithID: "p2")
        XCTAssertEqual(fetchedTracks.count, 2)
        XCTAssertEqual(fetchedTracks.first?.id, "t1")
        XCTAssertEqual(fetchedTracks.last?.id, "t2")
        
        XCTAssertTrue(Storage.sharedInstance.tracks(forPlaylistWithID: "unknown").isEmpty)
        XCTAssertTrue(Storage.sharedInstance.tracks(forPlaylistWithID: "p3").isEmpty)
    }
    
    func testMovePlaylist() {
        Storage.sharedInstance.movePlaylist(fromSourceIndex: 0, toTargetIndex: 2)
        let playlists = Storage.sharedInstance.playlists
        XCTAssertEqual(playlists.first?.id, "p2")
        XCTAssertEqual(playlists.last?.id, "p1")

    }
    
}

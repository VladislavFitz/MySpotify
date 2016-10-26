//
//  TrackTests.swift
//  MySpotify
//
//  Created by Vladislav Fitc on 26.10.16.
//  Copyright © 2016 Fitc. All rights reserved.
//

import Foundation
import XCTest
import Unbox
@testable import MySpotify

class TrackTests: XCTestCase {
    
    func testStringConvertible() {
        
        let id = "trackID"
        let title = "trackTitle"
        let artists = [Artist(id: "artistID", name: "artistName")]
        
        let track = Track(id: id, title: title, artists: artists, tempo: .none)
        
        XCTAssertEqual(track.description, "trackTitle - artistName")
    }
    
    func testUnbox() {
        
        let id = "trackID"
        let title = "trackTitle"
        
        let trackDictionary: [String: Any] = [
            "track": [
                "id": id,
                "name": title,
                "artists": [],
            ]
        ]
        
        do {
            let track: Track = try unbox(dictionary: trackDictionary)
            
            XCTAssertEqual(track.id, id)
            XCTAssertEqual(track.title, title)
            XCTAssertTrue(track.artists.isEmpty)
            XCTAssertNil(track.tempo)
            
        } catch let error {
            XCTFail("\(error)")
        }

    }
    
    func testDictionaryRepresentable() {
        
        let id = "trackID"
        let title = "trackTitle"
        let artists = [Artist(id: "id", name: "name")]
        let tempo: Float = 250
        
        let track = Track(id: id, title: title, artists: artists, tempo: tempo)
        
        let trackDictionary = track.dictionary
        
        XCTAssertEqual(trackDictionary["id"] as? String, id)
        XCTAssertEqual(trackDictionary["name"] as? String, title)
        XCTAssertEqual(trackDictionary["tempo"] as? Float, tempo)
        
        let decodedTrack = Track(dictionary: trackDictionary)
        
        XCTAssertNotNil(track)
        XCTAssertNil(Track(dictionary: [:]))
        XCTAssertEqual(decodedTrack?.id, id)
        XCTAssertEqual(decodedTrack?.title, title)
        XCTAssertEqual(decodedTrack?.tempo, tempo)
        
    }
    
}

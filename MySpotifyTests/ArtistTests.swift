//
//  ArtistTests.swift
//  MySpotify
//
//  Created by Vladislav Fitc on 26.10.16.
//  Copyright © 2016 Fitc. All rights reserved.
//

import Foundation
import XCTest
import Unbox
@testable import MySpotify

class ArtistTests: XCTestCase {
    
    func testUnbox() {
        
        let artistDictionary: [String: Any] = [
            "id": "artistID",
            "name": "artistName"
        ]
        
        do {
            let artist: Artist = try unbox(dictionary: artistDictionary)
            XCTAssertEqual(artist.id, "artistID")
            XCTAssertEqual(artist.name, "artistName")
            
        } catch let error {
            XCTFail("\(error)")
        }
    }
    
    func testDictionaryRepresentable() {
        
        let artist = Artist(id: "artistID", name: "artistName")
        
        let artistDictionary = artist.dictionary
        
        XCTAssertEqual(artistDictionary.value(forKey: "id") as? String, "artistID")
        XCTAssertEqual(artistDictionary.value(forKey: "name") as? String, "artistName")
        
        let decodedArtist = Artist(dictionary:artistDictionary)
        
        XCTAssertNotNil(decodedArtist)
        XCTAssertEqual(decodedArtist?.id, "artistID")
        XCTAssertEqual(decodedArtist?.name, "artistName")
        
        XCTAssertNil(Artist(dictionary: [:]))
        
    }
    
}

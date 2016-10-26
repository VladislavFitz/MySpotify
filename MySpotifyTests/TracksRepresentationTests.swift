//
//  TracksRepresentationTests.swift
//  MySpotify
//
//  Created by Vladislav Fitc on 26.10.16.
//  Copyright © 2016 Fitc. All rights reserved.
//

import Foundation
import XCTest
import Unbox
@testable import MySpotify

class TracksRepresentationTests: XCTestCase {
    
    func testCount() {
        let compactRepresentation = TracksRepresentation.url("tracksURL", count: 10)
        
        XCTAssertEqual(compactRepresentation.count, 10)
        
        let completeRepresentation = TracksRepresentation.tracks([
            Track(id: "1", title: "track1", artists: [], tempo: .none),
            Track(id: "2", title: "track2", artists: [], tempo: .none)])
        
        XCTAssertEqual(completeRepresentation.count, 2)
    }
    
    func testDictionaryRepresentable() {
        
        let compactRepresentation = TracksRepresentation.url("tracksURL", count: 10)
        
        let compactRepresentationDictionary = compactRepresentation.dictionary
        
        XCTAssertEqual(compactRepresentationDictionary.value(forKey: "tracks_url") as? String, "tracksURL")
        XCTAssertEqual(compactRepresentationDictionary.value(forKey: "tracks_count") as? Int, 10)
        
        let decodedCompactRepresentation = TracksRepresentation(dictionary: compactRepresentationDictionary)
        
        
        if case .url("tracksURL", count: 10)? = decodedCompactRepresentation {
        } else {
            XCTFail("Wrong decoding")
        }
        
        
        let completeRepresentation = TracksRepresentation.tracks([
            Track(id: "1", title: "track1", artists: [], tempo: .none),
            Track(id: "2", title: "track2", artists: [], tempo: .none)])
        
        let completeRepresentationDictionary = completeRepresentation.dictionary
        
        XCTAssertNotNil(completeRepresentationDictionary.value(forKey: "tracks"))
        
        
        let decodedCompleteRepresentation = TracksRepresentation(dictionary: completeRepresentationDictionary)
        
        if case .tracks? = decodedCompleteRepresentation , decodedCompleteRepresentation?.count == 2 {
        } else {
            XCTFail("Wrong decoding")
        }
        
        
    }
    
}

//
//  TracksRepresentation.swift
//  MySpotify
//
//  Created by Vladislav Fitc on 26.10.16.
//  Copyright © 2016 Fitc. All rights reserved.
//

import Foundation
import Unbox

enum TracksRepresentation {
    
    case url(String, count: Int)
    case tracks([Track])
    
    var count: Int {
        switch self {
        case .tracks(let tracks):
            return tracks.count
            
        case .url(_, count: let count):
            return count
        }
    }
}


extension TracksRepresentation: DictionaryRepresentable {
    
    init?(dictionary: NSDictionary) {
        if let tracksDictionaries = dictionary["tracks"] as? [NSDictionary] {
            let tracks = tracksDictionaries.flatMap({ Track(dictionary: $0) })
            self = .tracks(tracks)
        } else if
            let tracksURL = dictionary["tracks_url"] as? NSString,
            let tracksCount = dictionary["tracks_count"] as? Int {
            self = .url(tracksURL as String, count: tracksCount)
        } else {
            return nil
        }
    }
    
    var dictionary: NSDictionary {
        let dictionary = NSMutableDictionary()
        
        switch self {
        case .tracks(let tracks):
            dictionary.setValue(tracks.map({ $0.dictionary }), forKey: "tracks")
            
        case .url(let url, count: let count):
            dictionary.setValue(url, forKey: "tracks_url")
            dictionary.setValue(count, forKey: "tracks_count")
        }
        
        return dictionary
    }
    
}

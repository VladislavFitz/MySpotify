//
//  Playlist.swift
//  MySpotify
//
//  Created by Vladislav Fitc on 26.10.16.
//  Copyright © 2016 Fitc. All rights reserved.
//

import Foundation
import Unbox

struct Playlist {
    
    let id: String
    let name: String
    var tracks: TracksRepresentation
    
}

extension Playlist: CustomStringConvertible {
    
    var description: String {
        return "\(name) - \(tracks.count) tracks"
    }
    
}

extension Playlist: DictionaryRepresentable{
    
    init?(dictionary: NSDictionary) {
        if
            let id = dictionary["id"] as? NSString,
            let name = dictionary["name"] as? NSString,
            let tracksRepresentationDictionary = dictionary["tracks_representation"] as? NSDictionary,
            let tracksRepresentation = TracksRepresentation(dictionary: tracksRepresentationDictionary)
        {
            self.id = id as String
            self.name = name as String
            self.tracks = tracksRepresentation
        } else {
            return nil
        }
        
    }
    
    var dictionary: NSDictionary {
        let dictionary = NSMutableDictionary()
        dictionary.setValue(id, forKey: "id")
        dictionary.setValue(name, forKey: "name")
        dictionary.setValue(tracks.dictionary, forKey: "tracks_representation")
        
        
        return dictionary
    }
    
}

extension Playlist: Unboxable {
    
    init(unboxer: Unboxer) throws {
        self.id = try unboxer.unbox(key: "id")
        self.name = try unboxer.unbox(key: "name")
        let tracksURL: String = try unboxer.unbox(keyPath: "tracks.href")
        let tracksCount: Int = try unboxer.unbox(keyPath: "tracks.total")
        self.tracks = .url(tracksURL, count: tracksCount)
    }
    
}

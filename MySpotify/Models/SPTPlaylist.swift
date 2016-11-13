//
//  SPTPlaylist.swift
//  MySpotify
//
//  Created by Vladislav Fitc on 26.10.16.
//  Copyright © 2016 Fitc. All rights reserved.
//

import Foundation
import Unbox

struct SPTPlaylist: Playlist {
    
    typealias TrackType = SPTTrack
    
    let id: String
    let title: String
    var tracksRepresentation: TracksRepresentation
    
    var tracks: [SPTTrack] {
        switch tracksRepresentation {
        case .url:
            return []
            
        case .tracks(let tracks):
            return tracks
        }
    }
    
    
}

extension SPTPlaylist: CustomStringConvertible {
    
    var description: String {
        return "\(title) - \(tracksRepresentation.count) tracks"
    }
    
}

extension SPTPlaylist: DictionaryRepresentable{
    
    init?(dictionary: NSDictionary) {
        if
            let id = dictionary["id"] as? NSString,
            let name = dictionary["name"] as? NSString,
            let tracksRepresentationDictionary = dictionary["tracks_representation"] as? NSDictionary,
            let tracksRepresentation = TracksRepresentation(dictionary: tracksRepresentationDictionary)
        {
            self.id = id as String
            self.title = name as String
            self.tracksRepresentation = tracksRepresentation
        } else {
            return nil
        }
        
    }
    
    var dictionary: NSDictionary {
        let dictionary = NSMutableDictionary()
        dictionary.setValue(id, forKey: "id")
        dictionary.setValue(title, forKey: "name")
        dictionary.setValue(tracksRepresentation.dictionary, forKey: "tracks_representation")
        
        
        return dictionary
    }
    
}

extension SPTPlaylist: Unboxable {
    
    init(unboxer: Unboxer) throws {
        self.id = try unboxer.unbox(key: "id")
        self.title = try unboxer.unbox(key: "name")
        let tracksURL: String = try unboxer.unbox(keyPath: "tracks.href")
        let tracksCount: Int = try unboxer.unbox(keyPath: "tracks.total")
        self.tracksRepresentation = .url(tracksURL, count: tracksCount)
    }
    
}

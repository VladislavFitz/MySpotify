//
//  SPTTrack.swift
//  MySpotify
//
//  Created by Vladislav Fitc on 26.10.16.
//  Copyright © 2016 Fitc. All rights reserved.
//

import Foundation
import Unbox

struct SPTTrack: Track {
    
    let id: String
    let title: String
    let artists: [Artist]
    var tempo: Float?
    
}

extension SPTTrack: CustomStringConvertible {
    
    var description: String {
        return "\(title) - \(artists.map({ $0.name }).joined(separator: " ,"))"
    }
    
}

extension SPTTrack: Unboxable {
    
    init(unboxer: Unboxer) throws {
        self.id = try unboxer.unbox(keyPath: "track.id")
        self.title = try unboxer.unbox(keyPath: "track.name")
        self.artists = try unboxer.unbox(keyPath: "track.artists")
    }
    
}

extension SPTTrack: DictionaryRepresentable{
    
    init?(dictionary: NSDictionary) {
        if
            let id = dictionary["id"] as? String,
            let title = dictionary["name"] as? String,
            let artistsDictionaries = dictionary["artists"] as? [NSDictionary]
        {
            self.id = id
            self.title = title
            self.artists = artistsDictionaries.flatMap({ Artist(dictionary: $0) })
            self.tempo = dictionary["tempo"] as? Float
        } else {
            return nil
        }
    }
    
    var dictionary: NSDictionary {
        let dictionary = NSMutableDictionary()
        dictionary.setValue(id, forKey: "id")
        dictionary.setValue(title, forKey: "name")
        dictionary.setValue(tempo, forKey: "tempo")
        dictionary.setValue(artists.map({ $0.dictionary }), forKey: "artists")
        return dictionary
    }
    
}

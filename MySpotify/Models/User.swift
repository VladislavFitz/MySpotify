//
//  User.swift
//  MySpotify
//
//  Created by Vladislav Fitc on 26.10.16.
//  Copyright © 2016 Fitc. All rights reserved.
//

import Foundation
import Unbox

struct User {
    
    let id: String
    let name: String?
    var playlists: [Playlist] = []
    
}

extension User: Unboxable {
    
    init(unboxer: Unboxer) throws {
        self.id = try unboxer.unbox(key: "id")
        self.name = unboxer.unbox(key: "display_name")
    }
    
}

extension User: DictionaryRepresentable{
    
    init?(dictionary: NSDictionary) {
        if
            let id = dictionary["id"] as? NSString,
            let playlistsDictionaries = dictionary["playlists"] as? [NSDictionary]
        {
            self.id = id as String
            self.name = dictionary["name"] as? String
            self.playlists = playlistsDictionaries.flatMap({ Playlist(dictionary: $0) })
        } else {
            return nil
        }
        
    }
    
    var dictionary: NSDictionary {
        let dictionary = NSMutableDictionary()
        
        dictionary.setValue(id, forKey: "id")
        dictionary.setValue(name, forKey: "name")
        dictionary.setValue(playlists.map({ $0.dictionary }), forKey: "playlists")
        
        return dictionary
    }
    
}

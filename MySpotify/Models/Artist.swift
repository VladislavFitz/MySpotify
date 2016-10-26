//
//  Artist.swift
//  MySpotify
//
//  Created by Vladislav Fitc on 26.10.16.
//  Copyright © 2016 Fitc. All rights reserved.
//

import Foundation

import Unbox

struct Artist {
    
    let id: String
    let name: String
    
}

extension Artist: DictionaryRepresentable{
    
    init?(dictionary: NSDictionary) {
        if
            let id = dictionary["id"] as? String,
            let name = dictionary["name"] as? String
        {
            self.id = id
            self.name = name
        } else {
            return nil
        }
    }
    
    var dictionary: NSDictionary {
        let dictionary = NSMutableDictionary()
        dictionary.setValue(id, forKey: "id")
        dictionary.setValue(name, forKey: "name")
        return dictionary
    }
    
}

extension Artist: Unboxable {
    
    init(unboxer: Unboxer) throws {
        self.id = try unboxer.unbox(keyPath: "id")
        self.name = try unboxer.unbox(keyPath: "name")
    }
    
}

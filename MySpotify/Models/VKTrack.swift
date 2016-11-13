//
//  VKTrack.swift
//  MySpotify
//
//  Created by Vladislav Fitc on 13.11.16.
//  Copyright © 2016 Fitc. All rights reserved.
//

import Foundation
import Unbox

struct VKTrack: Track {
    
    let id: String
    let duration: Int
    let title: String
    let artist: String
    let url: URL
    
}

extension VKTrack: Unboxable {
    
    init(unboxer: Unboxer) throws {
        self.id = try unboxer.unbox(key: "id")
        self.duration = try unboxer.unbox(key: "duration")
        self.title = try unboxer.unbox(key: "title")
        self.artist = try unboxer.unbox(key: "artist")
        self.url = try unboxer.unbox(key: "url")
    }
    
}

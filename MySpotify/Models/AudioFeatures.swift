//
//  AudioFeatures.swift
//  MySpotify
//
//  Created by Vladislav Fitc on 26.10.16.
//  Copyright © 2016 Fitc. All rights reserved.
//

import Foundation
import Unbox

struct AudioFeatures {
    
    let trackID: String
    let tempo: Float
    
}

extension AudioFeatures: Unboxable {
    
    init(unboxer: Unboxer) throws {
        self.trackID = try unboxer.unbox(key: "id")
        self.tempo = try unboxer.unbox(key: "tempo")
    }
    
}

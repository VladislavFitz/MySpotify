//
//  AudioFeaturesListWrapper.swift
//  MySpotify
//
//  Created by Vladislav Fitc on 26.10.16.
//  Copyright © 2016 Fitc. All rights reserved.
//

import Foundation
import Unbox

struct AudioFeaturesListWrapper {
    
    let audioFeatures: [AudioFeatures]
    
}

extension AudioFeaturesListWrapper: Unboxable {
    
    init(unboxer: Unboxer) throws {
        self.audioFeatures = try unboxer.unbox(key: "audio_features")
    }
    
}

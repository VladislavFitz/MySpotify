//
//  VKTracksSource.swift
//  MySpotify
//
//  Created by Vladislav Fitc on 13.11.16.
//  Copyright © 2016 Fitc. All rights reserved.
//

import Foundation

class VKTracksSource: RefreshableTracksSource {
    
    typealias ItemType = VKTrack
    
    let ownerID: String
    let albumID: String?

    var items: [VKTrack] = []
    
    init(ownerID: String, albumID: String? = .none) {
        self.ownerID = ownerID
        self.albumID = albumID
    }
    
    func refresh(completion: @escaping (Error?) -> Void) {
        
        VKTracksRequest(ownerID: ownerID, albumID: albumID).perform() { result in
            switch result {
            case .failure(let error):
                completion(error)
            case .success(let tracks):
                self.items.removeAll()
                self.items = tracks
                completion(.none)
            }
        }

    }
    
}

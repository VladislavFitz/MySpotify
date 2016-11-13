//
//  TracksSource.swift
//  MySpotify
//
//  Created by Vladislav Fitc on 26.10.16.
//  Copyright © 2016 Fitc. All rights reserved.
//

import Foundation

class TracksSource: RefreshableItemsSource {
    
    typealias ItemType = SPTTrack
    
    let playlistID: String
    
    var items: [SPTTrack] {
        return Storage.sharedInstance.tracks(forPlaylistWithID: playlistID)
    }
    
    init(playlistID: String) {
        self.playlistID = playlistID
    }
    
    func refresh(completion: @escaping (Error?) -> Void) {
        Storage.sharedInstance.refreshTracks(forPlaylistWithID: playlistID) { error in
            completion(error)
        }
    }
    
}

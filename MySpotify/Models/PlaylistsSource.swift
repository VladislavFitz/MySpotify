//
//  PlaylistsSource.swift
//  MySpotify
//
//  Created by Vladislav Fitc on 26.10.16.
//  Copyright © 2016 Fitc. All rights reserved.
//

import Foundation

class PlaylistsSource: RefreshableItemsSource {
    
    typealias ItemType = Playlist
    
    var items: [Playlist] {
        return Storage.sharedInstance.playlists
    }
    
    func refresh(completion: @escaping (Error?) -> Void) {
        Storage.sharedInstance.refreshPlaylists() { error in
            completion(error)
        }
    }
    
    func moveItem(fromSourceIndex sourceIndex: Int, toTargetIndex targetIndex: Int) {
        Storage.sharedInstance.movePlaylist(fromSourceIndex: sourceIndex, toTargetIndex: targetIndex)
    }
    
}



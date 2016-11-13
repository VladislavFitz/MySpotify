//
//  Playlist.swift
//  MySpotify
//
//  Created by Vladislav Fitc on 13.11.16.
//  Copyright © 2016 Fitc. All rights reserved.
//

import Foundation

protocol Playlist {
    
    associatedtype TrackType: Track
    
    var id: String { get }
    var title: String { get }
    var tracks: [TrackType] { get }
    
}

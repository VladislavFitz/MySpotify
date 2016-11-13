//
//  RefreshableTracksSource.swift
//  MySpotify
//
//  Created by Vladislav Fitc on 13.11.16.
//  Copyright © 2016 Fitc. All rights reserved.
//

import Foundation

protocol RefreshableTracksSource: RefreshableItemsSource {
    
    associatedtype ItemType: Track
    
}

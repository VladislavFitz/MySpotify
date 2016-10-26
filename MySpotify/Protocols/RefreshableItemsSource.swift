//
//  RefreshableItemsSource.swift
//  MySpotify
//
//  Created by Vladislav Fitc on 26.10.16.
//  Copyright © 2016 Fitc. All rights reserved.
//

import Foundation

protocol RefreshableItemsSource {
    
    associatedtype ItemType
    
    var items: [ItemType] { get }
    
    func refresh(completion: @escaping (Error?) -> Void)
    
}

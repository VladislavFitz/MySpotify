//
//  DictionaryRepresentable.swift
//  MySpotify
//
//  Created by Vladislav Fitc on 26.10.16.
//  Copyright © 2016 Fitc. All rights reserved.
//

import Foundation

protocol DictionaryRepresentable {
    
    init?(dictionary: NSDictionary)
    
    var dictionary: NSDictionary { get }
    
}

//
//  NSError+Description.swift
//  MySpotify
//
//  Created by Vladislav Fitc on 26.10.16.
//  Copyright © 2016 Fitc. All rights reserved.
//

import Foundation

extension NSError {
    
    open override var description: String {
        return localizedDescription
    }
    
}

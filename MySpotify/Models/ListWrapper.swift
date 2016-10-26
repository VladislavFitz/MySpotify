//
//  ListWrapper.swift
//  MySpotify
//
//  Created by Vladislav Fitc on 26.10.16.
//  Copyright © 2016 Fitc. All rights reserved.
//

import Foundation
import Unbox

struct ListWrapper<Element: Unboxable> {
    let href: String
    let items: [Element]
}

extension ListWrapper: Unboxable {
    
    init(unboxer: Unboxer) throws {
        self.href = try unboxer.unbox(keyPath: "href")
        self.items = try unboxer.unbox(keyPath: "items")
    }
    
}

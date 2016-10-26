//
//  UserTests.swift
//  MySpotify
//
//  Created by Vladislav Fitc on 26.10.16.
//  Copyright © 2016 Fitc. All rights reserved.
//

import Foundation
import XCTest
import Unbox
@testable import MySpotify

class UserTests: XCTestCase {
    
    func testUnbox() {
        
        let userDictionary: [String: Any] = [
            "id": "1",
            "display_name": "Username",
        ]
        
        do {
            let user: User = try unbox(dictionary: userDictionary)
            
            XCTAssertEqual(user.id, "1")
            XCTAssertEqual(user.name, "Username")
            
        } catch let error {
            XCTFail("\(error)")
        }
        
    }
}

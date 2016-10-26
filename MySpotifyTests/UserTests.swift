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
    
    func testDictionaryRepresentable() {
        
        let user = User(id: "userID", name: "userName", playlists: [])
        
        let userDictionary = user.dictionary
        
        XCTAssertEqual(userDictionary.value(forKey: "id") as? String, "userID")
        XCTAssertEqual(userDictionary.value(forKey: "name") as? String, "userName")
        
        let decodedUser = User(dictionary:userDictionary)
        
        XCTAssertNotNil(decodedUser)
        XCTAssertEqual(decodedUser?.id, "userID")
        XCTAssertEqual(decodedUser?.name, "userName")
        
        XCTAssertNil(User(dictionary: [:]))
        
    }
    
}

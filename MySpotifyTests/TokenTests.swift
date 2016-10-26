//
//  TokenTests.swift
//  MySpotify
//
//  Created by Vladislav Fitc on 26.10.16.
//  Copyright © 2016 Fitc. All rights reserved.
//

import Foundation
import XCTest
import Unbox
@testable import MySpotify

class TokenTests: XCTestCase {
    
    func testUnbox() {
        
        let tokenDictionary: [String: Any] = [
            "token_type": "tokenType",
            "access_token": "12345",
            "refresh_token": "54321",
            "expires_in": 3600
        ]
        
        do {
            let token: Token = try unbox(dictionary: tokenDictionary)
            
            XCTAssertEqual(token.type, "tokenType")
            XCTAssertEqual(token.accessToken, "12345")
            XCTAssertEqual(token.refreshToken, "54321")

        } catch let error {
            XCTFail("\(error)")
        }
        
    }
    
    func testHeaderValue() {
        
        let token = Token(type: "tokenType", accessToken: "12345", refreshToken: "54321", expirationDate: Date())
        
        XCTAssertEqual(token.headerValue, "Bearer \(token.accessToken)")
        
    }
    
    func testExpiration() {
        
        let now = Date()
        
        let validToken = Token(type: "tokenType", accessToken: "12345", refreshToken: "54321", expirationDate: now.addingTimeInterval(10))
        
        XCTAssertFalse(validToken.expired)
        
        let expiredToken = Token(type: "tokenType", accessToken: "12345", refreshToken: "54321", expirationDate: now.addingTimeInterval(-10))
        
        XCTAssertTrue(expiredToken.expired)
    }
    
    func testDictionaryRepresentable() {
        
        let date = Date()
        let token = Token(type: "tokenType", accessToken: "12345", refreshToken: "54321", expirationDate: date)
        
        let tokenDictionary = token.dictionary
        
        XCTAssertEqual(tokenDictionary.value(forKey: "token_type") as? String, "tokenType")
        XCTAssertEqual(tokenDictionary.value(forKey: "access_token") as? String, "12345")
        XCTAssertEqual(tokenDictionary.value(forKey: "refresh_token") as? String, "54321")
        XCTAssertEqual(tokenDictionary.value(forKey: "expiration_date") as? Date, date)
        
        let decodedToken = Token(dictionary: tokenDictionary)
        
        XCTAssertNotNil(decodedToken)
        XCTAssertEqual(decodedToken?.type, "tokenType")
        XCTAssertEqual(decodedToken?.accessToken, "12345")
        XCTAssertEqual(decodedToken?.refreshToken, "54321")
        XCTAssertEqual(decodedToken?.expirationDate, date)


        XCTAssertNil(Token(dictionary: [:]))

        
    }
    
}

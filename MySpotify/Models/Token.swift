//
//  Token.swift
//  MySpotify
//
//  Created by Vladislav Fitc on 26.10.16.
//  Copyright © 2016 Fitc. All rights reserved.
//

import Foundation
import Unbox

struct Token {
    
    let type: String
    let accessToken: String
    let refreshToken: String
    let expirationDate: Date
    
    var headerValue: String {
        return "Bearer \(accessToken)"
    }
    
    var expired: Bool {
        return Date().timeIntervalSince1970 >= expirationDate.timeIntervalSince1970
    }
    
}


extension Token: Unboxable {
    
    init(unboxer: Unboxer) throws {
        self.type = try unboxer.unbox(key: "token_type")
        self.accessToken = try unboxer.unbox(key: "access_token")
        self.refreshToken = try unboxer.unbox(key: "refresh_token")
        let expiresIn: TimeInterval = try unboxer.unbox(key: "expires_in")
        self.expirationDate = Date(timeIntervalSinceNow: expiresIn)
    }
    
}

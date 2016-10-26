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

extension Token: DictionaryRepresentable {
    
    init?(dictionary: NSDictionary) {
        if
            let type = dictionary.value(forKey: "token_type") as? String,
            let accessToken = dictionary.value(forKey: "access_token") as? String,
            let refreshToken = dictionary.value(forKey: "refresh_token") as? String,
            let expirationDate = dictionary.value(forKey: "expiration_date") as? Date
        {
            self.type = type
            self.accessToken = accessToken
            self.refreshToken = refreshToken
            self.expirationDate = expirationDate
        } else {
            return nil
        }
    }
    
    var dictionary: NSDictionary {
        let dictionary = NSMutableDictionary()
        dictionary.setValue(type, forKey: "token_type")
        dictionary.setValue(accessToken, forKey: "access_token")
        dictionary.setValue(refreshToken, forKey: "refresh_token")
        dictionary.setValue(expirationDate, forKey: "expiration_date")
        return dictionary
    }
    
}

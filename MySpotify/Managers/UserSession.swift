//
//  UserSession.swift
//  MySpotify
//
//  Created by Vladislav Fitc on 26.10.16.
//  Copyright © 2016 Fitc. All rights reserved.
//

import Foundation


import Foundation

class UserSession {
    
    static let TokenUpdatedNotification = "Token.Updated"
    
    static let session = UserSession()
    
    var user: User? {
        didSet {
            if let user = user {
                Storage.sharedInstance.playlists = user.playlists
                UserDefaults.standard.setValue(user.dictionary, forKey: "lastUser")
            } else {
                Storage.sharedInstance.playlists = []
                UserDefaults.standard.removeObject(forKey: "lastUser")
            }
            
            UserDefaults.standard.synchronize()
        }
    }
    
    var currentToken: Token? {
        didSet {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: UserSession.TokenUpdatedNotification), object: nil, userInfo: nil)
            
            if let token = currentToken {
                UserDefaults.standard.setValue(token.dictionary, forKey: "token")
            } else {
                UserDefaults.standard.removeObject(forKey: "token")
            }
            
            UserDefaults.standard.synchronize()

        }
    }
    
    private init() {}
    
}

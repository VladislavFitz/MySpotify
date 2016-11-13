//
//  PlaylistsRequest.swift
//  MySpotify
//
//  Created by Vladislav Fitc on 26.10.16.
//  Copyright © 2016 Fitc. All rights reserved.
//

import Foundation
import Alamofire

struct PlaylistsRequest: ServiceRequest {
    
    typealias ResultType = ListWrapper<SPTPlaylist>
    
    let url: String
    let method: Alamofire.HTTPMethod
    let headers: Alamofire.HTTPHeaders
    
    init() {
        self.url = "https://api.spotify.com/v1/me/playlists"
        self.method = .get
        self.headers = ["Authorization": UserSession.session.currentToken!.headerValue]
    }
    
    init(user: User) {
        self.url = "https://api.spotify.com/v1/users/\(user.id)/playlists"
        self.method = .get
        self.headers = ["Authorization": UserSession.session.currentToken!.headerValue]
    }
    
}

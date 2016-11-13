//
//  SPTTracksRequest.swift
//  MySpotify
//
//  Created by Vladislav Fitc on 26.10.16.
//  Copyright © 2016 Fitc. All rights reserved.
//

import Foundation
import Alamofire
import Unbox

struct SPTTracksRequest: ServiceRequest {
    
    typealias ResultType = ListWrapper<SPTTrack>
    
    let url: String
    let method: Alamofire.HTTPMethod
    let headers: Alamofire.HTTPHeaders
    
    init?(playlist: SPTPlaylist) {
        if case .url(let tracksURL, count: _) = playlist.tracksRepresentation {
            self.url = tracksURL
            self.method = .get
            self.headers =  ["Authorization": UserSession.session.currentToken!.headerValue]
        } else {
            return nil
        }
    }
    
    
    init(userID: String, playlistID: String) {
        self.url = "https://api.spotify.com/v1/users/\(userID)/playlists/\(playlistID)/tracks"
        self.method = .get
        self.headers = ["Authorization": UserSession.session.currentToken!.headerValue]
    }
    
}

//
//  AudioFeaturesRequest.swift
//  MySpotify
//
//  Created by Vladislav Fitc on 26.10.16.
//  Copyright © 2016 Fitc. All rights reserved.
//

import Foundation
import Alamofire
import Unbox

struct AudioFeaturesRequest: ServiceRequest {
    
    typealias ResultType = AudioFeaturesListWrapper
    
    let url: String
    let method: Alamofire.HTTPMethod
    let headers: Alamofire.HTTPHeaders
    let parameters: Alamofire.Parameters
    
    init(trackIDs: [String]) {
        self.url = "https://api.spotify.com/v1/audio-features/"
        self.method = .get
        self.headers = ["Authorization": UserSession.session.currentToken!.headerValue]
        self.parameters = ["ids": trackIDs.joined(separator: ",")]
    }
    
}

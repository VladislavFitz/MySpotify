//
//  UserRequest.swift
//  MySpotify
//
//  Created by Vladislav Fitc on 26.10.16.
//  Copyright © 2016 Fitc. All rights reserved.
//

import Foundation
import Alamofire

struct UserRequest: ServiceRequest {
    
    typealias ResultType = User
    
    let url: String
    let method: Alamofire.HTTPMethod
    let headers: Alamofire.HTTPHeaders
    
    init() {
        self.url = "https://api.spotify.com/v1/me"
        self.method = .get
        self.headers = ["Authorization": UserSession.session.currentToken!.headerValue]
    }
    
}

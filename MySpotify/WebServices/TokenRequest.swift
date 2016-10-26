//
//  TokenRequest.swift
//  MySpotify
//
//  Created by Vladislav Fitc on 26.10.16.
//  Copyright © 2016 Fitc. All rights reserved.
//

import Foundation
import Alamofire

struct TokenRequest: ServiceRequest {
    
    typealias ResultType = Token
    
    let url: String
    let method: Alamofire.HTTPMethod
    let headers: Alamofire.HTTPHeaders
    let parameters: Alamofire.Parameters
    
    init(code: String) {
        self.url = "https://accounts.spotify.com/api/token"
        self.method = .post
        
        let authorizationString = "\(AppConstants.clientID):\(AppConstants.clientSecret)".data(using: .utf8)?.base64EncodedString() ?? ""
        
        self.headers = [
            "Authorization": "Basic \(authorizationString)"
        ]
        
        self.parameters = [
            "grant_type": "authorization_code",
            "code": code,
            "redirect_uri": AppConstants.redirectURI
        ]
    }
    
}

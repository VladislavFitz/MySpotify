//
//  VKTracksRequest.swift
//  MySpotify
//
//  Created by Vladislav Fitc on 13.11.16.
//  Copyright © 2016 Fitc. All rights reserved.
//

import Foundation
import VK_ios_sdk
import Unbox

struct VKTracksRequest: ConvenienceServiceRequest {
    
    typealias ResultType = [VKTrack]
    
    let ownerID: String
    let albumID: String?
    
    init(ownerID: String, albumID: String? = .none) {
        self.ownerID = ownerID
        self.albumID = albumID
    }
    
    func perform(resultHandler: @escaping (ServiceRequestResult<Array<VKTrack>>) -> Void) {
        
        var parameters = [AnyHashable : Any]()
        
        parameters["owner_id"] = ownerID
        
        if let albumID = albumID {
            parameters["album_id"] = albumID
        }
        
        VKApi.request(withMethod: "audio.get", andParameters: parameters).execute(
            resultBlock: { result in
                if let resultJSON = result?.json as? UnboxableDictionary {
                    do {
                        let tracks: [VKTrack] = try unbox(dictionary: resultJSON, atKeyPath: "items")
                        resultHandler(.success(tracks))
                    } catch let error {
                        resultHandler(.failure(error))
                    }
                } else {
                    let error = NSError(domain: "Service", code: 1, userInfo: [NSLocalizedDescriptionKey: "JSON parsing error"])
                    resultHandler(.failure(error))
                }
            },
            errorBlock: { error in
                if let error = error {
                    resultHandler(.failure(error))
                }
            }
        )
        
    }
    
}

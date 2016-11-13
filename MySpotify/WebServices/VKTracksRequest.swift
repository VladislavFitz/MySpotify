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
    
    init(ownerID: String) {
        self.ownerID = ownerID
    }
    
    func perform(resultHandler: @escaping (ServiceRequestResult<Array<VKTrack>>) -> Void) {
        
        VKApi.request(withMethod: "audio.get", andParameters: ["owner_id": ownerID]).execute(
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

//
//  ServiceRequest.swift
//  MySpotify
//
//  Created by Vladislav Fitc on 26.10.16.
//  Copyright © 2016 Fitc. All rights reserved.
//

import Foundation
import Alamofire
import Unbox

enum ServiceRequestResult<ResultType> {
    case success(ResultType)
    case failure(Error)
}

protocol ServiceRequest {
    
    associatedtype ResultType
    
    var url: String { get }
    var method: Alamofire.HTTPMethod { get }
    var headers: Alamofire.HTTPHeaders { get }
    var parameters: Alamofire.Parameters { get }
    
    func perform(resultHandler: @escaping (ServiceRequestResult<ResultType>) -> Void)
    
}

extension ServiceRequest {
    var headers: Alamofire.HTTPHeaders { return [:] }
    var parameters: Alamofire.Parameters { return [:] }
}

extension ServiceRequest where ResultType: Unboxable {
    
    func perform(resultHandler: @escaping (ServiceRequestResult<ResultType>) -> Void) {
        Alamofire.request(url, method: method, parameters: parameters, headers: headers).responseJSON() { response in
            
            if let error = response.result.error {
                resultHandler(.failure(error))
            }
            
            if let json = response.result.value as? [String: Any] {
                
                if let error = json["error"] as? String {
                    let error = NSError(domain: "Web Service", code: 100, userInfo: [NSLocalizedDescriptionKey: error])
                    resultHandler(.failure(error))
                    return
                }
                
                do {
                    let result: ResultType = try unbox(dictionary: json)
                    resultHandler(.success(result))
                } catch let error {
                    resultHandler(.failure(error))
                }
                
            } else {
                let error = NSError(domain: "Web Service", code: 101, userInfo: [NSLocalizedDescriptionKey: "Cast value to json failed"])
                resultHandler(.failure(error))
            }
        }
    }
    
}

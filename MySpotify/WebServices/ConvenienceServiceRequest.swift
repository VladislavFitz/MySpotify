//
//  ConvenienceServiceRequest.swift
//  MySpotify
//
//  Created by Vladislav Fitc on 13.11.16.
//  Copyright © 2016 Fitc. All rights reserved.
//

import Foundation

enum ServiceRequestResult<ResultType> {
    case success(ResultType)
    case failure(Error)
}

protocol ConvenienceServiceRequest {

    associatedtype ResultType

    func perform(resultHandler: @escaping (ServiceRequestResult<ResultType>) -> Void)
    
}

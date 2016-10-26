//
//  UIViewController+Error.swift
//  MySpotify
//
//  Created by Vladislav Fitc on 26.10.16.
//  Copyright © 2016 Fitc. All rights reserved.
//

import Foundation

extension UIViewController {
    
    func presentErrorController(error: Error, retryHandler: ((Void) -> Void)? = .none, animated: Bool = true, completion: ((Void) -> Void)? = .none) {
        let errorAlertController = UIAlertController(title: "Error", message: "\(error)", preferredStyle: .alert)
        
        if let retryHandler = retryHandler {
            errorAlertController.addAction(UIAlertAction(title: "Retry", style: .default, handler: { _ in retryHandler() }))
        }
        
        errorAlertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: .none))
        
        present(errorAlertController, animated: animated, completion: completion)
    }
    
}

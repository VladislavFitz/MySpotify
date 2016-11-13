//
//  UIViewController+NavigationController.swift
//  MySpotify
//
//  Created by Vladislav Fitc on 13.11.16.
//  Copyright © 2016 Fitc. All rights reserved.
//

import Foundation

extension UIViewController {
    
    var embeddedInNavigationController: UINavigationController {
        return embeddedInNavigationController(modalPresentationStyle: .overFullScreen)
    }
    
    func embeddedInNavigationController(modalPresentationStyle: UIModalPresentationStyle) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: self)
        navigationController.modalPresentationStyle = modalPresentationStyle
        return navigationController
    }
    
}

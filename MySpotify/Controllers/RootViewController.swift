//
//  RootViewController.swift
//  MySpotify
//
//  Created by Vladislav Fitc on 13.11.16.
//  Copyright © 2016 Fitc. All rights reserved.
//

import Foundation

class RootViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        configureTabs()
    }
    
    func configureTabs() {
        viewControllers?.removeAll()
        
        let vkController = VKController().embeddedInNavigationController
        vkController.view.backgroundColor = .green
        vkController.tabBarItem.image = UIImage(named: "vk")
        
        let spotifyController = UIStoryboard(name: "Spotify", bundle: .none).instantiateInitialViewController()
        spotifyController?.tabBarItem.image = UIImage(named: "spotify")
        
        viewControllers = [vkController, spotifyController].flatMap({ $0 })
        
    }
    
    
}

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
        
        let vkController = VKController()
        vkController.tabBarItem.image = UIImage(named: "vk")
        viewControllers = [vkController]
        
        
    }
    
    
}

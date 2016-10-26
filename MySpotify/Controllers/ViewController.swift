//
//  ViewController.swift
//  MySpotify
//
//  Created by Vladislav Fitc on 26.10.16.
//  Copyright © 2016 Fitc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        requestToken()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func requestToken() {
        if let requestTokenURL = SPTAuth.loginURL(forClientId: AppConstants.clientID, withRedirectURL: URL(string: AppConstants.redirectURI)!, scopes: [], responseType: "code", allowNativeLogin: true) {
            UIApplication.shared.openURL(requestTokenURL)
        }
    }


}


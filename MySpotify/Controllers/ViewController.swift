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
        
        if let token = UserSession.session.currentToken, !token.expired {
            requestUser(successCompletion: presentUserPlaylists)
            
        } else {
            requestTokenCode()
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func requestTokenCode() {
        if let requestTokenURL = SPTAuth.loginURL(forClientId: AppConstants.clientID, withRedirectURL: URL(string: AppConstants.redirectURI)!, scopes: [], responseType: "code", allowNativeLogin: true) {
            UIApplication.shared.openURL(requestTokenURL)
        }
    }
    
    func requestUser(successCompletion: @escaping (Void) -> Void) {
        UserRequest().perform() { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let user):
                UserSession.session.user = user
                successCompletion()
            }
        }
    }
    
    func presentUserPlaylists() {
        print("Should present playlists")
    }


}


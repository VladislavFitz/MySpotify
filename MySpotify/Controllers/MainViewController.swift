//
//  MainViewController.swift
//  MySpotify
//
//  Created by Vladislav Fitc on 26.10.16.
//  Copyright © 2016 Fitc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(tokenUpdated), name: Notification.Name(rawValue: UserSession.TokenUpdatedNotification), object: .none)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let token = UserSession.session.currentToken, !token.expired {
            requestUser(successCompletion: presentUserPlaylists)
            
        } else {
            requestTokenCode()
        }

    }
    
    func tokenUpdated() {
        requestUser(successCompletion: presentUserPlaylists)
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
                DispatchQueue.main.async {
                    self.presentErrorController(error: error, retryHandler: {
                        self.requestUser(successCompletion: successCompletion)
                    })
                }
                
            case .success(let user):
                UserSession.session.user = user
                successCompletion()
            }
        }
    }
    
    func presentUserPlaylists() {
        performSegue(withIdentifier: "PresentPlaylists", sender: self)
    }


}


//
//  AppDelegate.swift
//  MySpotify
//
//  Created by Vladislav Fitc on 26.10.16.
//  Copyright © 2016 Fitc. All rights reserved.
//

import UIKit
import Alamofire

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        
        if
            let storedTokenDictionary = UserDefaults.standard.object(forKey: "token") as? NSDictionary ,
            let storedToken = Token(dictionary: storedTokenDictionary)
        {
            UserSession.session.currentToken = storedToken
        }
        
        if
            let storedUserDictionary = UserDefaults.standard.object(forKey: "lastUser") as? NSDictionary,
            let storedUser = User(dictionary: storedUserDictionary)
        {
            UserSession.session.user = storedUser
        }
        
        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        
        URLComponents(url: url, resolvingAgainstBaseURL: true)?.queryItems?.forEach { item in
            
            switch item.name {
            case "code":
                if let code = item.value {
                    TokenRequest(code: code).perform() { result in
                        switch result {
                        case .failure(let error):
                            print(error)
                            
                        case .success(let token):
                            UserSession.session.currentToken = token
                        }
                    }
                }
                
            case "error":
                if let error = item.value {
                    print(error)
                }
                
            default:
                break
            }

        }
        
        
        return true
    }
    

}


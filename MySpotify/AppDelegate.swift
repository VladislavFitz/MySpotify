//
//  AppDelegate.swift
//  MySpotify
//
//  Created by Vladislav Fitc on 26.10.16.
//  Copyright © 2016 Fitc. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        if
            let storedTokenDictionary = UserDefaults.standard.object(forKey: "token") as? NSDictionary ,
            let storedToken = Token(dictionary: storedTokenDictionary),
            !storedToken.expired
        {
            UserSession.session.currentToken = storedToken
        }
        
        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        
        URLComponents(url: url, resolvingAgainstBaseURL: true)?.queryItems?.forEach { item in
            
            switch item.name {
            case "code":
                if let code = item.value {
                    print(code)
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


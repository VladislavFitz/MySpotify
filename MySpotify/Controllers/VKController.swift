//
//  VKController.swift
//  MySpotify
//
//  Created by Vladislav Fitc on 13.11.16.
//  Copyright © 2016 Fitc. All rights reserved.
//

import Foundation
import VK_ios_sdk
import Unbox

class VKController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        VKSdk.instance().register(self)
        VKSdk.instance().uiDelegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        VKSdk.wakeUpSession(["audio"]) { (authorizationState, error) in
            if let error = error {
                print(error)
            } else {
                switch authorizationState {
                case .authorized:
                    break
                default:
                    VKSdk.authorize(["audio"])
                }
            }
        }
        
    }
    
    
}

extension VKController: VKSdkDelegate {
    
    public func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {

    }
    
    func vkSdkAuthorizationStateUpdated(with result: VKAuthorizationResult!) {
        guard let userID = result?.user?.id?.intValue else {
            return
        }
        
        let tracksSource = VKTracksSource(ownerID: String(userID))
        let tracksViewController = TracksViewController(source: tracksSource)
        tracksViewController.title = "All audios"
        tracksViewController.source = tracksSource
        navigationController?.pushViewController(tracksViewController, animated: true)
        
    }
    
    public func vkSdkUserAuthorizationFailed() {
        
    }
    
}

extension VKController: VKSdkUIDelegate {
    
    
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        present(controller, animated: true, completion: .none)
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        
    }
    
    func vkSdkWillDismiss(_ controller: UIViewController!) {
        
    }
    
    func vkSdkDidDismiss(_ controller: UIViewController!) {
        
    }
}


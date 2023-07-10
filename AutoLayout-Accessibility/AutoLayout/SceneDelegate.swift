//
//  SceneDelegate.swift
//  AutoLayout
//
//  Created by ROHIT MISHRA on 09/05/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    let viewController = BullEyeViewController()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        window = UIWindow(windowScene: windowScene)
        
        // Configure view controller for bull eye game.
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        viewController.appDidBecomeActive()
    }
}


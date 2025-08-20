//
//  SceneDelegate.swift
//  NiteFan
//
//  Created by Shana Russell on 9/27/19.
//  Copyright © 2019 HiTechMom. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        // Use storyboard for now until ModernViewController is added to the project
        // To use the modern UI, add ModernViewController.swift, FanAnimationView.swift, 
        // and UIColor+NiteFan.swift to your Xcode project target
        
        // For now, use the storyboard-based UI
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let rootViewController = storyboard.instantiateInitialViewController() else { return }
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
        
        // Uncomment these lines after adding the new files to your Xcode project:
        // window = UIWindow(windowScene: windowScene)
        // window?.rootViewController = ModernViewController()
        // window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
    }
}
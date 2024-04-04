//
//  SceneDelegate.swift
//  ProjectDescriptionHelpers
//
//  Created by 새미 on 1/10/24.
//

import UIKit
import Feature

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
<<<<<<< HEAD
        window?.rootViewController = UINavigationController(rootViewController: UserProfileViewController())
=======
        window?.rootViewController = UINavigationController(rootViewController: IntroViewController())
        /*UINavigationController(rootViewController: OutingStatusViewController())*/
>>>>>>> 59a9fc6ec5d0382bcee1b8632fdd07f25c712966
        window?.makeKeyAndVisible()
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {}
}

//
//  SceneDelegate.swift
//  SocialFeed
//
//  Created by Rachmat Wahyu Pramono on 29/03/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.windowScene = windowScene
        window?.overrideUserInterfaceStyle = .light
        
        let vc = PostsListFactory.makePostsListVC()
        let navigationController = UINavigationController(rootViewController: vc)
        navigationController.navigationBar.prefersLargeTitles = true

        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
    }
}


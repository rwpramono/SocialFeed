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
        
        let jsonDecoder = JSONDecoder()
        let urlSession = URLSession(configuration: .ephemeral)
        let networkService = URLSessionCoreDataCacheService(session: urlSession, decoder: jsonDecoder)

        let vm = PostsListVM(networkService: networkService)
        let navigationController = UINavigationController(rootViewController: PostsListVC(viewModel: vm))
        navigationController.navigationBar.prefersLargeTitles = true

        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
    }
}


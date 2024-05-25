//
//  SceneDelegate.swift
//  MovieAPP
//
//  Created by Michael Alexander Rodriguez Urbina on 25/05/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let rootMovieViewController = storyboard.instantiateViewController(identifier: "RootMovieViewController") as? RootMovieViewController else {
            fatalError("Unable to instantiate RootMovieViewController from Main storyboard")
        }
        
        let interactor = RootMovieInteractor()
        let router = RootMovieRouter()
        let presenter = RootMoviePresenter(interactor: interactor, router: router)
        
        rootMovieViewController.presenter = presenter
        presenter.view = rootMovieViewController
        router.viewController = rootMovieViewController
        
        let navigationController = UINavigationController(rootViewController: rootMovieViewController)
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}


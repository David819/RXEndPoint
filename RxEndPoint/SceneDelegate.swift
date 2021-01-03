//
//  SceneDelegate.swift
//  RxEndPoint
//
//  Created by David on 1/2/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowSence = (scene as? UIWindowScene) else { return }
        configureView(windowsSence: windowSence)
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.

        // Save changes in the application's managed object context when the application transitions to the background.
        PersistentController.shared.saveContext()
    }

    private func configureView(windowsSence: UIWindowScene) {
        let window = UIWindow(windowScene: windowsSence)
        let mainTab = UITabBarController()
        mainTab.viewControllers = [UINavigationController(rootViewController: CurrentViewController()),
                                   UINavigationController(rootViewController: HistoryListViewController())]
        
        let item0 = mainTab.tabBar.items?[0]
        let item1 = mainTab.tabBar.items?[1]
        item0?.title = "Current"
        item0?.image = UIImage(systemName: "house.fill")
        item1?.title = "History"
        item1?.image = UIImage(systemName: "doc.plaintext.fill")
        
        window.rootViewController = mainTab
        self.window = window
        window.makeKeyAndVisible()
    }
}


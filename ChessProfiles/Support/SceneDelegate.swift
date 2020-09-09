//
//  SceneDelegate.swift
//  ChessProfiles
//
//  Created by Shawn Bierman on 9/9/20.
//  Copyright © 2020 Shawn Bierman. All rights reserved.
//

import os.log
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }

        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = TabBarViewController()
        window?.makeKeyAndVisible()

        os_log(#function, log: .viewCycle, type: .debug)
    }

    func       sceneDidDisconnect (_ scene: UIScene) { os_log(#function, log: .viewCycle, type: .debug) }
    func     sceneDidBecomeActive (_ scene: UIScene) { os_log(#function, log: .viewCycle, type: .debug) }
    func    sceneWillResignActive (_ scene: UIScene) { os_log(#function, log: .viewCycle, type: .debug) }
    func  sceneDidEnterBackground (_ scene: UIScene) { os_log(#function, log: .viewCycle, type: .debug) }
    func sceneWillEnterForeground (_ scene: UIScene) { os_log(#function, log: .viewCycle, type: .debug) }
}

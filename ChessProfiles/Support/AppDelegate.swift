//
//  AppDelegate.swift
//  ChessProfiles
//
//  Created by Shawn Bierman on 9/9/20.
//  Copyright © 2020 Shawn Bierman. All rights reserved.
//

import os.log
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        os_log(#function, log: .viewCycle, type: .info)

        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {

        os_log(#function, log: .viewCycle, type: .info)

        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
}

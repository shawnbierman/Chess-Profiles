//
//  TabBarViewController.swift
//  ChessProfiles
//
//  Created by Shawn Bierman on 9/9/20.
//  Copyright © 2020 Shawn Bierman. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = createViewControllers()
    }

    private func createViewControllers() -> [UIViewController] {

        let home = HomeViewController()
        let players = UINavigationController(rootViewController: PlayersTableViewController())

        home.tabBarItem    = UITabBarItem(title: "Home",    image: UIImage(systemName: "house.fill"),    selectedImage: nil)
        players.tabBarItem = UITabBarItem(title: "Players", image: UIImage(systemName: "person.2.fill"), selectedImage: nil)

        return [home, players]
    }
}

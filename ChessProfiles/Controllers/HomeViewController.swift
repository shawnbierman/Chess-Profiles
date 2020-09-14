//
//  HomeViewController.swift
//  ChessProfiles
//
//  Created by Shawn Bierman on 9/9/20.
//  Copyright © 2020 Shawn Bierman. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {

    let profileVC = ProfileViewController()

    var player: String? {
        didSet {
            
            guard let player = player, player != "" else { return }

            Network.shared.fetchProfile(for: player) { (result) in

                switch result {

                case .success(let player):
                    self.profileVC.configure(for: player)

                case .failure(let error):
                    dump(error.localizedDescription)
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchRandomTitledPlayer()
    }

    private func fetchRandomTitledPlayer() {

        // pick a random title
        guard let title = Title.allCases.randomElement() else { return }

        Network.shared.fetchPlayers(with: title) { (result) in

            switch result {

            case .success(let player):

                // choose a random player with that title
                self.player = player.players.randomElement()

            case .failure(let error):
                dump(error.localizedDescription)
            }
        }
    }

    private func setup() {

        let headerPadding: CGFloat = 20

        add(profileVC)

        profileVC.view.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([

            profileVC.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: headerPadding),
            profileVC.view.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: headerPadding),
            profileVC.view.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -headerPadding),
            profileVC.view.heightAnchor.constraint(equalToConstant: 150)

        ])
    }
}

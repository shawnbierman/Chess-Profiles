//
//  HomeViewController.swift
//  ChessProfiles
//
//  Created by Shawn Bierman on 9/9/20.
//  Copyright © 2020 Shawn Bierman. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {

    var player: String? {
        didSet {
            
            guard let player = player, player != "" else { return }

            Network.shared.fetchProfile(for: player) { (result) in

                switch result {

                case .success(let profile):

                    if let title = profile.title {
                        print("Randomly chosen titled player is \"\(profile.username)\" with a title of \"\(title)\".")
                    } else {
                        print("Fetching again...")
                        self.fetchRandomTitledPlayer()
                    }

                case .failure(let error):
                    dump(error.localizedDescription)
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
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
}

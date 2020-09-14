//
//  ProfileDetailViewController.swift
//  ChessProfiles
//
//  Created by Shawn Bierman on 9/10/20.
//  Copyright © 2020 Shawn Bierman. All rights reserved.
//

import Kingfisher
import UIKit

class ProfileDetailViewController: BaseViewController {

    @objc let dismissButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Dismiss", for: .normal)
        return button
    }()

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

    // MARK: - Lifecycle Methods.

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetch()
    }

    // MARK: - Private Methods.

    @objc func dismissButtonTapped() {
        self.dismiss(animated: true)
    }

    private func fetch() {

        guard let player = player else { return }
        Network.shared.fetchProfile(for: player) { (result) in
            switch result {

            case .success(let player):
                self.profileVC.configure(for: player)

            case .failure(let error):
                dump(error.localizedDescription)
            }
        }
    }

    private func setup() {

        let padding: CGFloat = 20

        dismissButton.addTarget(self, action: #selector(dismissButtonTapped), for: .touchUpInside)

        view.addSubview(dismissButton)

        add(profileVC)

        profileVC.view.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([

            dismissButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            dismissButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            profileVC.view.topAnchor.constraint(equalTo: dismissButton.bottomAnchor, constant: padding),
            profileVC.view.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            profileVC.view.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            profileVC.view.heightAnchor.constraint(equalToConstant: 150)

        ])
    }
}

//
//  ProfileViewController.swift
//  ChessProfiles
//
//  Created by Shawn Bierman on 9/10/20.
//  Copyright © 2020 Shawn Bierman. All rights reserved.
//

import Kingfisher
import UIKit

class ProfileViewController: BaseViewController {

    let dismissButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Dismiss", for: .normal)
        return button
    }()

    let profileImage: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = UIImage(systemName: "questionmark.circle.fill")
        iv.layer.cornerRadius = 4
        iv.clipsToBounds = true
        return iv
    }()

    let usernameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
//        label.backgroundColor = .orange
        label.font = .preferredFont(forTextStyle: .largeTitle)
        label.adjustsFontSizeToFitWidth = true
        label.adjustsFontForContentSizeCategory = true
        return label
    }()

    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
//        label.backgroundColor = .yellow
        label.font = .preferredFont(forTextStyle: .headline)
        label.adjustsFontSizeToFitWidth = true
        label.adjustsFontForContentSizeCategory = true
        label.textColor = .secondaryLabel
        return label
    }()

    let locationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
//        label.backgroundColor = .green
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.adjustsFontSizeToFitWidth = true
        label.adjustsFontForContentSizeCategory = true
        label.textColor = .tertiaryLabel
        return label
    }()

    var player: String!

    // MARK: - Lifecycle Methods.

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetch(self.player)
    }

    // MARK: - Private Methods.

    @objc func dismissButtonTapped() {
        self.dismiss(animated: true)
    }

    func configure(for player: Player) {

        // this is displaying too slow.

        if let avatar = player.avatar {
            DispatchQueue.main.async {
                self.profileImage.kf.setImage(with: URL(string: avatar)!)
            }
        }

        DispatchQueue.main.async {
            self.usernameLabel.text = player.username
            self.nameLabel.text = player.name ?? ""
            self.locationLabel.text = player.location ?? ""
        }
    }

    private func fetch(_ player: String) {

        showLoadingView()

        Network.shared.fetchProfile(for: player) { [weak self] (result) in
            guard let self = self else { return }

            switch result {

            case .success(let player):
                dump(player)
                self.configure(for: player)
                self.dismissLoadingView()

            case .failure(let error):
                dump(error.localizedDescription)
            }
        }
    }

    private func setup() {

        // likely with switch to UIStackViews

        dismissButton.addTarget(self, action: #selector(dismissButtonTapped), for: .touchUpInside)

        [dismissButton, profileImage, usernameLabel, nameLabel, locationLabel].forEach(view.addSubview(_:))

        let padding: CGFloat = 20

        NSLayoutConstraint.activate([

            dismissButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dismissButton.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),

            profileImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            profileImage.topAnchor.constraint(equalTo: dismissButton.bottomAnchor, constant: padding),
            profileImage.heightAnchor.constraint(equalToConstant: 100),
            profileImage.widthAnchor.constraint(equalToConstant: 100),

            usernameLabel.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: padding),
            usernameLabel.topAnchor.constraint(equalTo: profileImage.topAnchor),
            usernameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            usernameLabel.heightAnchor.constraint(equalToConstant: 40),

            nameLabel.leadingAnchor.constraint(equalTo: usernameLabel.leadingAnchor),
            nameLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: usernameLabel.trailingAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 20),

            locationLabel.leadingAnchor.constraint(equalTo: usernameLabel.leadingAnchor),
            locationLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: padding),
            locationLabel.trailingAnchor.constraint(equalTo: usernameLabel.trailingAnchor),
            locationLabel.heightAnchor.constraint(equalToConstant: 20),

        ])
    }
}

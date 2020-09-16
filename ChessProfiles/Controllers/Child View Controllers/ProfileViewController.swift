//
//  ProfileViewController.swift
//  ChessProfiles
//
//  Created by Shawn Bierman on 9/13/20.
//  Copyright © 2020 Shawn Bierman. All rights reserved.
//

import SafariServices
import UIKit

class ProfileViewController: BaseViewController {

    let profileImage: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image?.withRenderingMode(.alwaysOriginal)
        iv.image = #imageLiteral(resourceName: "noavatar")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 4
        return iv
    }()

    let usernameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
//        label.backgroundColor = .systemPink
        label.font = .preferredFont(forTextStyle: .largeTitle)
        label.adjustsFontSizeToFitWidth = true
        label.adjustsFontForContentSizeCategory = true
        return label
    }()

    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
//        label.backgroundColor = .systemPurple
        label.font = .preferredFont(forTextStyle: .headline)
        label.adjustsFontSizeToFitWidth = true
        label.adjustsFontForContentSizeCategory = true
        label.textColor = .secondaryLabel
        return label
    }()

    let locationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
//        label.backgroundColor = .systemTeal
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.adjustsFontSizeToFitWidth = true
        label.adjustsFontForContentSizeCategory = true
        label.textColor = .tertiaryLabel
        return label
    }()

    let titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .systemRed
        label.textColor = .white
        label.font = .preferredFont(forTextStyle: .headline)
        label.adjustsFontSizeToFitWidth = true
        label.adjustsFontForContentSizeCategory = true
        label.layer.cornerRadius = 4
        label.clipsToBounds = true
        label.textAlignment = .center
        label.baselineAdjustment = .alignCenters
        return label
    }()

    // MARK: - Lifecycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        prepareForReuse()
    }

    private func prepareForReuse() {
        self.profileImage.image = nil
        self.usernameLabel.text = nil
        self.nameLabel.text = nil
        self.locationLabel.text = nil
        self.titleLabel.text = nil
    }

    var player: Player!

    // MARK: - Member Methods

    func configure(for player: Player) {

        self.player = player

        DispatchQueue.main.async {

            if let avatar = player.avatar {
                self.profileImage.kf.indicatorType = .activity
                self.profileImage.kf.setImage(with: URL(string: avatar)!, options: [.transition(.fade(0.3))])
            } else {
                self.profileImage.image = #imageLiteral(resourceName: "noavatar")
            }

            self.usernameLabel.text = player.username
            self.nameLabel.text = player.name ?? ""
            self.locationLabel.text = player.location ?? ""
            self.titleLabel.text = player.title?.rawValue ?? ""
        }
    }

    @objc func handleTapGesture() {

        if let url = URL(string: player.url) {
            let config = SFSafariViewController.Configuration()
            config.entersReaderIfAvailable = true

            let vc = SFSafariViewController(url: url, configuration: config)
            present(vc, animated: true)
        }
    }

    // MARK : - Configure UI

    private func setup() {

        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
        view.addGestureRecognizer(tapGestureRecognizer)

        [profileImage, usernameLabel, nameLabel, locationLabel, titleLabel].forEach(view.addSubview(_:))

        NSLayoutConstraint.activate([

            profileImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileImage.topAnchor.constraint(equalTo: view.topAnchor),
            profileImage.heightAnchor.constraint(equalToConstant: 100),
            profileImage.widthAnchor.constraint(equalToConstant: 100),

            usernameLabel.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 15),
            usernameLabel.topAnchor.constraint(equalTo: profileImage.topAnchor),
            usernameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            usernameLabel.heightAnchor.constraint(equalToConstant: 40),

            nameLabel.leadingAnchor.constraint(equalTo: usernameLabel.leadingAnchor),
            nameLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: usernameLabel.trailingAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 20),

            locationLabel.leadingAnchor.constraint(equalTo: usernameLabel.leadingAnchor),
            locationLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
            locationLabel.trailingAnchor.constraint(equalTo: usernameLabel.trailingAnchor),
            locationLabel.heightAnchor.constraint(equalToConstant: 20),

            titleLabel.centerXAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: -5),
            titleLabel.topAnchor.constraint(equalTo: profileImage.topAnchor, constant: 5),
            titleLabel.heightAnchor.constraint(equalToConstant: 18),
            titleLabel.widthAnchor.constraint(equalToConstant: 30)


        ])
    }
}

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

    let dismissButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Dismiss", for: .normal)
        return button
    }()

    var player: String!

    // MARK: - Lifecycle Methods.

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Private Methods.

    @objc func dismissButtonTapped() {
        self.dismiss(animated: true)
    }
}

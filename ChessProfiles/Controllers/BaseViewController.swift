//
//  BaseViewController.swift
//  ChessProfiles
//
//  Created by Shawn Bierman on 9/11/20.
//  Copyright © 2020 Shawn Bierman. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    private var containerView: UIView!

    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Customize colors for navBar
        navigationController?.navigationBar.tintColor = .label
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.label]

        // Make the navigation bar background clear
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        // Restore colors for navBar
        navigationController?.navigationBar.tintColor = nil
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.label]

        // Restore the navigation bar to default
        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        navigationController?.navigationBar.shadowImage = nil
    }

    func showLoadingView() {

        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)

        containerView.backgroundColor = .systemBackground

        let activityIndicator = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activityIndicator)

        activityIndicator.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])

        activityIndicator.startAnimating()
    }

    func dismissLoadingView() {

        DispatchQueue.main.async {
            self.containerView.removeFromSuperview()
            self.containerView = nil
        }
    }
}

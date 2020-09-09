//
//  PlayersTableViewController.swift
//  ChessProfiles
//
//  Created by Shawn Bierman on 9/9/20.
//  Copyright © 2020 Shawn Bierman. All rights reserved.
//

import UIKit

class PlayersTableViewController: UITableViewController {

    var players = [String]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Lifecycle Methods.

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        fetch()
    }

    // MARK: - Private Methods.

    private func setup() {
        view.backgroundColor = .systemBackground

        let image = UIImage(systemName: "slider.horizontal.3")
        let btn = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(filterByTitle))

        navigationItem.rightBarButtonItem = btn
    }

    private func fetch() {

        Network.shared.fetch(title: .GM) { [weak self] (result) in
            guard let self = self else { return }

            switch result {
            case .success(let success):
                self.players = success.players
            case .failure(let error):
                dump(error.localizedDescription)
            }
        }

    }

    @objc func filterByTitle() {

        // GM, WGM, IM, WIM, FM, WFM, NM, WNM, CM, WCM
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        alert.addAction(UIAlertAction(title: "Grandmasters", style: .default))
        alert.addAction(UIAlertAction(title: "International Masters", style: .default))
        alert.addAction(UIAlertAction(title: "Fide Masters", style: .default))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))

        present(alert, animated: true, completion: nil)
    }
}

extension PlayersTableViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        players.count
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let player = players[indexPath.row]

        cell.textLabel?.text = player

        return cell
    }
}

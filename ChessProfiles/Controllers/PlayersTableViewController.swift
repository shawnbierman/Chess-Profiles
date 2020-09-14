//
//  PlayersTableViewController.swift
//  ChessProfiles
//
//  Created by Shawn Bierman on 9/9/20.
//  Copyright © 2020 Shawn Bierman. All rights reserved.
//

import UIKit

class PlayersTableViewController: UITableViewController {

    let searchController = UISearchController()

    var isSearching: Bool = false { didSet { if !isSearching { updateData() }}}
    var players = [String]() { didSet { updateData() }}
    var filteredPlayers = [String]() { didSet { updateData() }}

    // MARK: - Lifecycle Methods.

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        fetchPlayers(withTitle: .GM) // a default offering of data
    }

    // MARK: - Private Methods.

    private func setup() {

        view.backgroundColor = .systemBackground

        let image = UIImage(systemName: "slider.horizontal.3")
        let btn = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(filterByTitle))

        searchController.searchResultsUpdater                 = self
        searchController.searchBar.delegate                   = self
        searchController.searchBar.placeholder                = "Search for a player"
        searchController.obscuresBackgroundDuringPresentation = false

        navigationItem.rightBarButtonItem = btn
        navigationItem.searchController   = searchController

        navigationController?.navigationBar.prefersLargeTitles = true

    }

    private func fetchPlayers(withTitle title: Title) {

        Network.shared.fetchPlayers(with: title) { [weak self] (result) in
            guard let self = self else { return }

            switch result {

            case .success(let success):

                self.players = success.players
                DispatchQueue.main.async {
                    self.title = title.localizedName
                    self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
                }

            case .failure(let error):
                dump(error.localizedDescription)
            }
        }
    }

    private func updateData() {

        // There will likely be more here soon.

        DispatchQueue.main.async {
            self.tableView.reloadData()
        }

    }

    @objc func filterByTitle() {

        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        for title in Title.allCases {

            let action = UIAlertAction(title: title.localizedName, style: .default) { [weak self] _ in
                guard let self = self else { return }
                self.fetchPlayers(withTitle: title)
            }

            alert.addAction(action)
        }

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))

        present(alert, animated: true, completion: nil)
    }
}

// MARK: - TableView datasource and delegate methods.

extension PlayersTableViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        isSearching ? filteredPlayers.count : players.count
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let vc = ProfileDetailViewController()
        vc.modalPresentationStyle = .popover
        vc.player = isSearching ? filteredPlayers[indexPath.row] : players[indexPath.row]
        navigationController?.present(vc, animated: true, completion: nil)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let model = isSearching ? filteredPlayers : players
        let player = model[indexPath.row]

        cell.textLabel?.text = player

        return cell
    }
}

// MARK: - SearchBar datasource and delegate methods.

extension PlayersTableViewController: UISearchResultsUpdating, UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count == 0 {
            isSearching = false
        }
    }

    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else { return }

        isSearching = true
        filteredPlayers = players.filter { $0.lowercased().contains(filter.lowercased()) }
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
    }
}

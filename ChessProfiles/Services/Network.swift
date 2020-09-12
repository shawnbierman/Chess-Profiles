//
//  Network.swift
//  ChessProfiles
//
//  Created by Shawn Bierman on 9/9/20.
//  Copyright © 2020 Shawn Bierman. All rights reserved.
//

import Foundation
import os.log

class Network {

    static let shared = Network()

    private func buildUrl(with path: String) -> URL {

        var urlComponents = URLComponents()
            urlComponents.scheme = "https"
            urlComponents.host = "api.chess.com"
            urlComponents.path = "/pub/\(path)"

        return urlComponents.url!
    }

    // fetch player profiles by username
    func fetchProfile(for player: String, completion: @escaping (Result<Player, Error>) -> Void) {
        let url = buildUrl(with: "player/\(player)")
        fetchJSONDecodable(url: url, completion: completion)
    }

    // fetch titled users by title
    func fetchPlayers(with title: Title, completion: @escaping (Result<Players, Error>) -> Void) {
        let url = buildUrl(with: "titled/\(title)")
        fetchJSONDecodable(url: url, completion: completion)
    }

    private func fetchJSONDecodable<T: Decodable>(url: URL, completion: @escaping (Result<T, Error>) -> Void) {

        os_log("%{PUBLIC}@", log: .networking, type: .info, url.absoluteString)

        let task = URLSession.shared.dataTask(with: url) { data, response, error in

            guard error == nil else { return }
            guard let data = data else { return }

            do {
                let objects = try JSONDecoder().decode(T.self, from: data)
                completion(.success(objects))
            } catch let error {
                completion(.failure(error))
            }

        }

        task.resume()
    }
}

//200 = "enjoy your JSON"
//301 = if the URL you requested is bad, but we know where it should be; your client should remember and correct this to use the new URL in future requests
//304 = if your client supports "ETag/If-None-Match" or "Last-Modified/If-Modified-Since" caching headers and the data have not changed since the last request
//404 = we try to tell you if the URL is malformed or the data requested is just not available (e.g., a username for a user that does not exist)
//410 = we know for certain that no data will ever be available at the URL you requested; your client should not request this URL again
//429 = we are refusing to interpret your request due to rate limits; see "Rate Limiting" above

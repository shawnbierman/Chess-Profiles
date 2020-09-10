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

    private let url = "https://api.chess.com/pub/titled/"

    func fetch(title: Title, completion: @escaping (Result<Players, Error>) -> Void) {
        fetchJSONDecodable(title: title, completion: completion)
    }

    private func fetchJSONDecodable<T: Decodable>(title: Title, completion: @escaping (Result<T, Error>) -> Void) {

        let baseURLString = url.appending(title.rawValue)

        os_log("%{PUBLIC}@", log: .networking, type: .info, baseURLString)

        guard let url = URL(string: baseURLString) else { fatalError("URL Failure") }

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

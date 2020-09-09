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

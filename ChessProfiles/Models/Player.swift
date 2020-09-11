//
//  Player.swift
//  ChessProfiles
//
//  Created by Shawn Bierman on 9/10/20.
//  Copyright © 2020 Shawn Bierman. All rights reserved.
//

import Foundation

struct Player: Codable {
    let url: String
    let username: String
    let playerID: Int
    let title: Title?
    let status: String
    let name: String?
    let avatar: String?
    let location: String?
    let country: String
    let joined: Int
    let lastOnline: Int
    let followers: Int
    let isStreamer: Bool
    let twitchURL: String?
    let fide: Int?

    enum CodingKeys: String, CodingKey {
        case url
        case username
        case playerID = "player_id"
        case title
        case status
        case name
        case avatar
        case location
        case country
        case joined
        case lastOnline = "last_online"
        case followers
        case isStreamer = "is_streamer"
        case twitchURL = "twitch_url"
        case fide
    }
}

//{
//    "@id": "URL", // the location of this profile (always self-referencing)
//    "url": "URL", // the chess.com user's profile page (the username is displayed with the original letter case)
//    "username": "string", // the username of this player
//    "player_id": 41, // the non-changing Chess.com ID of this player
//    "title": "string", // (optional) abbreviation of chess title, if any
//    "status": "string", // account status: closed, closed:fair_play_violations, basic, premium, mod, staff
//    "name": "string", // (optional) the personal first and last name
//    "avatar": "URL", // (optional) URL of a 200x200 image
//    "location": "string", // (optional) the city or location
//    "country": "URL", // API location of this player's country's profile
//    "joined": 1178556600, // timestamp of registration on Chess.com
//    "last_online": 1500661803, // timestamp of the most recent login
//    "followers": 17 // the number of players tracking this player's activity
//    "is_streamer": "boolean", //if the member is a Chess.com streamer
//    "twitch_url": "Twitch.tv URL",
//    "fide": "integer" // FIDE rating
//}

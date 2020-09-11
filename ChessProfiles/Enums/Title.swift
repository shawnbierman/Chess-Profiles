//
//  Title.swift
//  ChessProfiles
//
//  Created by Shawn Bierman on 9/9/20.
//  Copyright © 2020 Shawn Bierman. All rights reserved.
//

import Foundation

enum Title: String, Codable, CaseIterable {
    case GM, WGM, IM, WIM, FM, WFM, NM, WNM, CM, WCM
}

extension Title {

    var localizedName: String {

        switch self {
        case .GM:
            return "Grandmaster"
        case .WGM:
            return "Woman Grandmaster"
        case .IM:
            return "International Master"
        case .WIM:
            return "Woman International Master"
        case .FM:
            return "FIDE Master"
        case .WFM:
            return "Woman FIDE Master"
        case .NM:
            return "National Master"
        case .WNM:
            return "Woman National Master"
        case .CM:
            return "Candidate Master"
        case .WCM:
            return "Woman Candidate Master"
        }
    }
}

// Dave DeLong's suggestion

//struct Title: RawRepresentable, CaseIterable, Equatable, Hashable, Codable {
//
//    static let allCases = [Title.gm, .wgm]
//
//    static let gm = Title(rawValue: "gm", localizedName: "Grandmaster")
//    static let wgm = Title(rawValue: "wgm", localizedName: "Woman Grandmaster")
//
//    let rawValue: String
//    let localizedName: String
//
//    init?(rawValue: String) {
//        guard let t = Self.allCases.first(where: { $0.rawValue == rawValue }) else { return nil }
//        self = t
//    }
//
//    private init(rawValue: String, localizedName: String) {
//        self.rawValue = rawValue
//        self.localizedName = localizedName
//    }
//
//    static private func dataCorruptedError(in container: SingleValueDecodingContainer, debugDescription: String) -> DecodingError {
//
//    }
//
//    init(from decoder: Decoder) throws {
//        let c = try decoder.singleValueContainer()
//        let rawValue = try c.decode(String.self)
//        guard let value = Title(rawValue: rawValue) else { throw DecodingError() }
//        self = value
//    }
//
//    func encode(to encoder: Encoder) throws {
//        var c = try encoder.singleValueContainer()
//        try c.encode(rawValue)
//    }
//}

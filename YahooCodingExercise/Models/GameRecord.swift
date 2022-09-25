//
//  GameRecord.swift
//  YahooCodingExercise
//
//  Created by Ayren King on 9/23/22.
//

import Foundation

// MARK: - GameRecord
struct GameRecord: Codable, Identifiable {
    let id = UUID()
    let gameID, awayTeamID, awayTeamName, homeTeamID: String
    let homeTeamName: String
    let awayScore, homeScore: Int

    enum CodingKeys: String, CodingKey {
        case gameID = "GameId"
        case awayTeamID = "AwayTeamId"
        case awayTeamName = "AwayTeamName"
        case homeTeamID = "HomeTeamId"
        case homeTeamName = "HomeTeamName"
        case awayScore = "AwayScore"
        case homeScore = "HomeScore"
    }
}

typealias GameRecords = [GameRecord]

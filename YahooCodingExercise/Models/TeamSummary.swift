//
//  TeamSummary.swift
//  YahooCodingExercise
//
//  Created by Ayren King on 9/23/22.
//

import Foundation

struct TeamSummary: Identifiable {
    var id: UUID = UUID()
    var teamId: String = ""
    var teamName: String = ""
    var records: GameRecords = GameRecords()
    var wins: Int = 0
    var losses: Int = 0
    var draws: Int = 0
    
    var total: Int {
        get {
            wins + losses + draws
        }
    }
    var winPercentage: Double {
        get {
            
            round(Double(wins) / Double(total) * 100 * 10) / 10.0
        }
    }
}

typealias TeamSummaries = [TeamSummary]

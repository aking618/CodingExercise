//
//  TeamSpecificStat.swift
//  YahooCodingExercise
//
//  Created by Ayren King on 9/23/22.
//

import Foundation

struct TeamSpecificStat: Identifiable {
    var id = UUID()
    var opponentTeamName: String = ""
    var wins: Int = 0
    var losses: Int = 0
    var draws: Int = 0
    var total: Int {
        get {
            wins + losses + draws
        }
    }
}

typealias TeamSpecificStats = [TeamSpecificStat]

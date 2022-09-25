//
//  TeamDetailsViewModel.swift
//  YahooCodingExercise
//
//  Created by Ayren King on 9/23/22.
//

import Foundation

struct TeamDetailsViewModel {
    var teamName: String
    var gameStats: TeamSpecificStats
}

// MARK: Initializer
extension TeamDetailsViewModel {
    
    init(teamSummary: TeamSummary) {
        self.teamName = teamSummary.teamName
        self.gameStats = TeamSpecificStats()
        
        parseGameRecords(teamSummary: teamSummary)
    }
}

// MARK: TeamSpecificStats Helper Functions
extension TeamDetailsViewModel {
    
    mutating private func parseGameRecords(teamSummary: TeamSummary) {
        let opponentIds = getIds(records: teamSummary.records).filter { $0 != teamSummary.teamId }
        
        for id in opponentIds {
            var stat = TeamSpecificStat()
            
            for record in teamSummary.records {
                guard id == record.homeTeamID || id == record.awayTeamID else { continue }
                
                if record.homeTeamID == id {
                    stat.opponentTeamName = record.homeTeamName
                    
                    if record.homeScore > record.awayScore {
                        stat.losses += 1
                    }
                    else if record.homeScore < record.awayScore {
                        stat.wins += 1
                    }
                    else if record.homeScore == record.awayScore {
                        stat.draws += 1
                    }
                }
                
                if record.awayTeamID == id {
                    stat.opponentTeamName = record.awayTeamName
                    
                    if record.homeScore < record.awayScore {
                        stat.losses += 1
                    }
                    else if record.homeScore > record.awayScore {
                        stat.wins += 1
                    }
                    else if record.homeScore == record.awayScore {
                        stat.draws += 1
                    }
                }
            }
            self.gameStats.append(stat)
        }
    }
    
    private func getIds(records: GameRecords) -> [String] {
        var idList = [String]()
        
        for record in records {
            if !idList.contains(record.homeTeamID) {
                idList.append(record.homeTeamID)
            }
            
            if !idList.contains(record.awayTeamID) {
                idList.append(record.awayTeamID)
            }
        }
        
        return idList
    }
}

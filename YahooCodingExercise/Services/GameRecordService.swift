//
//  GameRecordService.swift
//  YahooCodingExercise
//
//  Created by Ayren King on 9/23/22.
//

import Foundation

protocol GameRecordServer {
    func requestGameRecords (completion: @escaping (GameRecords) -> ())
}

public class GameRecordServerAF: GameRecordServer {
    
    public init () {}
    
    private let gameRecordURL: String = "http://l.yimg.com/re/v2/coding_exercise/soccer_data.json"
    
    func requestGameRecords(completion: @escaping (GameRecords) -> ()) {
        guard let url = URL(string: gameRecordURL) else {
            print("Invalid url...")
            return
        }
        
        let offlineResults = UserDefaults.standard.bool(forKey: "offlineResults")
        
        
        // Load the data locally
        if (offlineResults) {
            do {
                let data = try loadJSON(withFilename: "gamerecords")
                
                completion(data as! GameRecords)
                return;
            }
            catch {
                print("Error loading file...")
            }
        }
        
        
        // Load the data from the server
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let jsonData = data {
                let gameRecords = try! JSONDecoder().decode(GameRecords.self, from: jsonData)
                
                do {
                    try self.save(records: gameRecords, toFilename: "gamerecords")
                    UserDefaults.standard.set(true, forKey: "offlineResults")
                }
                catch {
                    print("Error saving data...")
                }
                
                DispatchQueue.main.async {
                    completion(gameRecords)
                }
            } else {
                print("Error retrieving data...")
            }
            
        }.resume()

    }
}

// MARK: GameRecord Helper Functions
extension GameRecordServerAF {
    
    func parseGameRecords(records: GameRecords) -> TeamSummaries {
        var summaries = TeamSummaries()
        
        let idList = getIds(records: records)
        
        for id in idList {
            var summary = TeamSummary()
            summary.teamId = id
            
            for record in records {
                guard id == record.homeTeamID || id == record.awayTeamID else { continue }
                
                if record.homeTeamID == id {
                    summary.records.append(record)
                    summary.teamName = record.homeTeamName
                    
                    if record.homeScore > record.awayScore {
                        summary.wins += 1
                    }
                    else if record.homeScore < record.awayScore {
                        summary.losses += 1
                    }
                    else if record.homeScore == record.awayScore {
                        summary.draws += 1
                    }
                }
                
                if record.awayTeamID == id {
                    summary.records.append(record)
                    summary.teamName = record.awayTeamName
                    
                    if record.homeScore < record.awayScore {
                        summary.wins += 1
                    }
                    else if record.homeScore > record.awayScore {
                        summary.losses += 1
                    }
                    else if record.homeScore == record.awayScore {
                        summary.draws += 1
                    }
                }
            }
            summaries.append(summary)
        }
        
        return summaries
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


// MARK: Loading / Saving data locally
extension GameRecordServerAF {
    
    private func loadJSON(withFilename filename: String) throws -> Any? {
        let fm = FileManager.default
        let urls = fm.urls(for: .documentDirectory, in: .userDomainMask)
        if let url = urls.first {
            var fileURL = url.appendingPathComponent(filename)
            fileURL = fileURL.appendingPathExtension("json")
            let data = try Data(contentsOf: fileURL)
            let jsonObject = try JSONDecoder().decode(GameRecords.self, from: data)
            return jsonObject
        }
        return nil
    }
    
    private func save(records: GameRecords, toFilename filename: String) throws {
        let fm = FileManager.default
        let urls = fm.urls(for: .documentDirectory, in: .userDomainMask)
        if let url = urls.first {
            var fileURL = url.appendingPathComponent(filename)
            fileURL = fileURL.appendingPathExtension("json")
            let data = try JSONEncoder().encode(records)
            try data.write(to: fileURL, options: [.atomicWrite])
        }
    }
}

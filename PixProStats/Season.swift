//
//  Season.swift
//  PixProStats
//
//  Created by Isaiah Hernandez on 2/22/25.
//

import Foundation

// MARK: - Season
struct Season: Codable, Identifiable {
    let id: Int
    let playoffs: Playoffs
    let regularSeason: [Game]
    let awards: Awards
    let hofClass: [String]
    let teamSeasonPlayers: [String: [String]]
    let teamRecords: [String: Record]
    
    enum CodingKeys: String, CodingKey {
        case id = "year"
        //case year
        case playoffs
        case regularSeason = "regular_season"
        case awards
        case hofClass = "hof_class"
        case teamSeasonPlayers = "team_season_players"
        case teamRecords = "team_records"
    }
    
    func getWorldSeriesIdsList() -> [Int]{
        let worldSeries = playoffs.worldSeries
        let teamOne = worldSeries.teamOne
        let teamTwo = worldSeries.teamTwo
        return [teamOne, teamTwo]
    }
    
    func getTeamRecordById(_ teamId: Int) -> Record {
        let teamIdString = String(teamId)
        let teamRecord: Record  = self.teamRecords[teamIdString] ?? Record(gamesWon: 0, gamesPlayed: 0)
        return teamRecord
    }
    
    func getIsPlayoffTeam(_ teamId: Int) -> Bool {
        let playoffIds: Set<Int> = self.playoffs.getPlayoffTeams()
        return playoffIds.contains(teamId)
        
    }
    
    //Need Season to be Identifiable so I made the id the year
    func getYear() -> Int {
        return self.id
    }
}

//
//  Season.swift
//  PixProStats
//
//  Created by Isaiah Hernandez on 3/4/24.
//
//self.year = year
//self.playoffs = playoffs
//self.regular_season = regular_season
//self.teams = teams
//self.awards = awards
import Foundation

struct SeasonOld: Decodable {
    let year: Int
    let playoffs: PlayoffsOld
    var regular_season: [GameOld]
    let season_team_players : [SeasonTeamPlayers]
    let team_records : [SeasonTeamRecord]
    let awards: AwardsOld
    let hof_class: [String]
    
    func getWordSeriesMatchup() -> (Int, Int) {
        let worldSeries = self.playoffs.world_series
        let teamOne = worldSeries.team_one
        let teamTwo = worldSeries.team_two

        return (teamOne, teamTwo)
    }
    
    
}

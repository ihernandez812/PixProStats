import Foundation

// MARK: - League
struct League: Codable {
    let divisions: [Division]
    let teams: [Team]
    let players: [Player]
    let seasons: [Season]
    let hofers: [String]
    
    func getSeasonByYear(seasonYear: Int) -> Season {
        for season in self.seasons {
            if season.getYear() == seasonYear{
                return season
            }
        }
        return self.seasons[0]
    }
    
    func getUserTeamDivison() -> String {
        let userTeamId: Int = teams.filter({$0.isUserTeam}).first?.id ?? 0
        let userTeamDivisonName: String = divisions.filter({$0.teams.contains(userTeamId)}).first?.name ?? ""
        return userTeamDivisonName
    }
    
    func getPlayerById(playerId: String) -> Player {
        for player in self.players {
            if player.id == playerId{
                return player
            }
        }
        return self.players[0]
    }
    
    func getAllTimeTeamPlayers(teamId: Int) -> [String]{
        var teamPlayers: [String] = []
        for season in seasons {
            let teamIdString = String(teamId)
            let teamSeasonPlayers: [String] = season.teamSeasonPlayers[teamIdString] ?? []
            teamPlayers = Array(Set(teamPlayers + teamSeasonPlayers))
        }
        
        return teamPlayers
    }
    
    func getAllTimeRecords() -> [Int: Record] {
        var allTimeRecordsMap: [Int: Record] = [:]
        for team in self.teams {
            let teamId = team.id
            var wins: Int = 0
            var gamesPlayed: Int = 0
            var teamRecord: Record!
            for season in self.seasons {
                let teamSeasonRecord = season.getTeamRecordById(teamId)
                wins += teamSeasonRecord.gamesWon
                gamesPlayed += teamSeasonRecord.gamesPlayed
            }
            teamRecord = Record(gamesWon: wins, gamesPlayed: gamesPlayed)
            allTimeRecordsMap[teamId] = teamRecord
        }
        return allTimeRecordsMap
    }
    
    func getConferences() -> [Conference] {
        var conferencesMap = [String: [Division]]()
        var conferences: [Conference] = []
        for division in self.divisions {
            let conference = division.conference
            conferencesMap[conference, default: []].append(division)
        }
        
        for (id, divisions) in conferencesMap {
            let conference = Conference(id: id, divisions: divisions)
            conferences.append(conference)
        }
        
        return conferences
    }
    
    
    func getSeasonsToLookFor(player: Player, seasonYear: Int?, teamId: Int?) -> [Int] {
        var seasonsToLookFor: [Int] = []
        
        if teamId != nil {
            for season in self.seasons {
                let teamIdString = String(teamId ?? 0)
                let playersOnTeam = season.teamSeasonPlayers[teamIdString] ?? []
                for playerId in playersOnTeam {
                    if playerId == player.id {
                        seasonsToLookFor.append(season.getYear())
                    }
                }
                
            }
        }
        if seasonYear != nil {
            let unwrappedSeason: Int = seasonYear ?? 0
            if unwrappedSeason == LeagueViewModel.ALL_TIME {
                for season in seasons {
                    seasonsToLookFor.append(season.getYear())
                }
                
            }
            else {
                seasonsToLookFor.append(seasonYear ?? 0)
            }
        }
        
        return seasonsToLookFor
    }
    
    func getPlayerBattingStats(player: Player, seasonYear: Int?, teamId: Int?) -> [BattingStats] {
        var playerBattingStats: [BattingStats] = []
        let seasonsToLookFor: [Int] = self.getSeasonsToLookFor(player: player, seasonYear: seasonYear, teamId: teamId)
        
        for battingStat in player.battingStats {
            if seasonsToLookFor.contains(battingStat.season) {
                playerBattingStats.append(battingStat)
            }
        }
        
        return playerBattingStats
    }
    
    func getPlayerPitchingStats(player: Player, seasonYear: Int?, teamId: Int?) -> [PitchingStats] {
        var playerPitchingStats: [PitchingStats] = []
        let seasonsToLookFor: [Int] = self.getSeasonsToLookFor(player: player, seasonYear: seasonYear, teamId: teamId)
        
        for pitchingStat in player.pitchingStats {
            if seasonsToLookFor.contains(pitchingStat.season) {
                playerPitchingStats.append(pitchingStat)
            }
        }
        
        return playerPitchingStats
    }
    
    func getWorldSeriesWinCount(teamId: Int) -> Int {
        var winCount: Int = 0
        for season in seasons {
            let playoffs = season.playoffs
            let worldSeries = playoffs.worldSeries
            if worldSeries.winner == teamId {
                winCount += 1
            }
        }
        return winCount
    }
}

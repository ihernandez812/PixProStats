//
//  Series.swift
//  PixProStats
//
//  Created by Isaiah Hernandez on 2/22/25.
//

import Foundation

// MARK: - Series
struct Series: Codable, Identifiable {
    let id: String
    let teamOne, teamTwo, winner: Int
    let games: [Game]
    let seriesLength: Int
    let seriesType: SeriesType.RawValue
    
    enum CodingKeys: String, CodingKey {
        case id
        case teamOne = "team_one"
        case teamTwo = "team_two"
        case winner, games
        case seriesLength = "series_length"
        case seriesType = "name"
    }
    
    func getWinCountById(_ teamId: Int) -> Int {
        var winCount = 0
        for game in games {
            
            if game.getWinner() == teamId {
                winCount+=1
            }
        }
        return winCount
    }
}

enum SeriesType: String {
    case WORLD_SERIES="final"
    case AL_CHAMPIONSHIP="confOneFinal"
    case NL_CHAMPIONSHIP="confTwoFinal"
    case AL_DIVISIONAL="confOneSemi{series}"
    case NL_DIVISONAL="confTwoSemi{series}"
    case AL_WILDCARD="confOneWildcard"
    case NL_WILDCARD="confTwoWildcard"
    
    static func description(rawValue: String) -> String {
        switch rawValue {
        case SeriesType.NL_WILDCARD.rawValue:
            return "NL Wildcard"
        case SeriesType.AL_WILDCARD.rawValue:
            return "AL Wildcard"
        case SeriesType.NL_DIVISONAL.rawValue:
            return "NL Divisional"
        case SeriesType.AL_DIVISIONAL.rawValue:
            return "AL Divisional"
        case SeriesType.NL_CHAMPIONSHIP.rawValue:
            return "NL Championship"
        case SeriesType.AL_CHAMPIONSHIP.rawValue:
            return "AL Championship"
        case SeriesType.WORLD_SERIES.rawValue:
            return "World Series"
        default:
            return "N/A"
        }
    }
}

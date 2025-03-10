//
//  Playoffs.swift
//  PixProStats
//
//  Created by Isaiah Hernandez on 2/22/25.
//

import Foundation

// MARK: - Playoffs
struct Playoffs: Codable {
    let nlWildcard, alWildcard, nlDivisionalOne, alDivisionalOne: Series
    let nlDivisionalTwo, alDivisionalTwo, nlChampionship, alChampionship: Series
    let worldSeries: Series
    
    enum CodingKeys: String, CodingKey {
        case nlWildcard = "nl_wildcard"
        case alWildcard = "al_wildcard"
        case nlDivisionalOne = "nl_divisional_one"
        case alDivisionalOne = "al_divisional_one"
        case nlDivisionalTwo = "nl_divisional_two"
        case alDivisionalTwo = "al_divisional_two"
        case nlChampionship = "nl_championship"
        case alChampionship = "al_championship"
        case worldSeries = "world_series"
    }
    
    func getPlayoffTeams() -> Set<Int> {
        let teams: Set<Int> = [
            nlWildcard.teamOne,
            nlWildcard.teamTwo,
            alWildcard.teamOne,
            alWildcard.teamTwo,
            nlDivisionalOne.teamOne,
            nlDivisionalOne.teamTwo,
            nlDivisionalTwo.teamOne,
            nlDivisionalTwo.teamTwo,
            alDivisionalOne.teamOne,
            alDivisionalOne.teamTwo,
            alDivisionalTwo.teamOne,
            alDivisionalTwo.teamTwo,
            ]
        return teams
    }
}

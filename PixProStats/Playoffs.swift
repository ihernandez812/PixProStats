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
        case nlWildcard = "confTwoWildcard"
        case alWildcard = "confOneWildcard"
        case nlDivisionalOne = "confTwoSemi0"
        case alDivisionalOne = "confOneSemi0"
        case nlDivisionalTwo = "confTwoSemi1"
        case alDivisionalTwo = "confOneSemi1"
        case nlChampionship = "confTwoFinal"
        case alChampionship = "confOneFinal"
        case worldSeries = "final"
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

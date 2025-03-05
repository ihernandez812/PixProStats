//
//  Game.swift
//  PixProStats
//
//  Created by Isaiah Hernandez on 2/22/25.
//

import Foundation


// MARK: - RegularSeason
struct Game: Codable, Identifiable {
    let id: String
    let teamOne, teamTwo, teamOneScore, teamTwoScore: Int
    let winner: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case teamOne = "team_one"
        case teamTwo = "team_two"
        case teamOneScore = "team_one_score"
        case teamTwoScore = "team_two_score"
        case winner
    }
    
    func getWinner() -> Int{
        let winnerId: Int
        if teamOneScore > teamTwoScore{
            winnerId = teamOne
        }else if teamOneScore < teamTwoScore{
            winnerId = teamTwo
        }
        else{
            winnerId = 0
        }
        
        return winnerId
    }
}

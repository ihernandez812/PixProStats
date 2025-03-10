//
//  PitchingStats.swift
//  PixProStats
//
//  Created by Isaiah Hernandez on 2/21/25.
//

import Foundation

struct PitchingStats: Codable, Identifiable {
    let id: String
    let strikeouts: Int
    let atBats: Int
    let walks: Int
    let homeRuns: Int
    let numGames: Int
    let strikes: Int
    let hits: Int
    let balls: Int
    let runs: Int
    let inningsOuts: Int
    let pitches: Int
    let earnedRuns: Int
    let season: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case strikeouts = "strike_outs"
        case atBats = "at_bats"
        case walks
        case homeRuns = "home_runs"
        case numGames = "num_games"
        case strikes = "strikes"
        case hits, balls, runs
        case inningsOuts = "innings_outs"
        case pitches
        case earnedRuns = "earned_runs"
        case season
        
    }
    
    func toPitchingStatsTupleList() -> [(String, Int)] {
        return [
            ("Strikeouts", self.strikeouts),
            ("At Bats", self.atBats),
            ("Walks", self.walks),
            ("Home Runs", self.homeRuns),
            ("Games Played", self.numGames),
            ("Strikes", self.strikes),
            ("Hits", self.hits),
            ("Balls", self.balls),
            ("Runs", self.runs),
            ("Inngings Outs", self.inningsOuts),
            ("Pitches", self.pitches),
            ("Earned Runs", self.earnedRuns),
            
        ]
    }
    
    func getCalculatedStats() -> [(String, Double)] {
        return [
            ("AVG", self.getAverage()),
            ("ERA", self.getEra()),
            ("K/9", self.calculateStrikeoutsPerInning()),
            ("WHIP", self.getWHIP()),
        ]
    }
    
    func getAverage() -> Double {
        var result: Double = 0
        if self.atBats > 0 && self.hits > 0 {
            let avg: Double = Double(self.hits) / Double(self.atBats)
            result = Double(round(1000 * avg) / 1000)
        }
        return result
    }
    
    func getEra() -> Double {
        var result: Double = 0
        if self.inningsOuts > 0 && self.earnedRuns > 0 {
            let inningsPitched: Double = Double(self.inningsOuts) / 3
            let era: Double = (Double(self.earnedRuns) / inningsPitched) * 9
            result = Double(round(1000 * era) / 1000)
        }
        return result
    }
    
    func calculateStrikeoutsPerInning() -> Double {
        var result: Double = 0
        if self.inningsOuts > 0 && self.strikeouts > 0 {
            let inningsPitched: Double = Double(self.inningsOuts) / 3
            let strikeoutsPerInning: Double = Double(self.strikeouts) / inningsPitched
            result =  Double(round(1000 * strikeoutsPerInning) / 1000)
        }
        return result
    }
    
    func getWHIP() -> Double {
        var result: Double = 0
        if self.inningsOuts > 0 && self.walks > 0 && self.hits > 0 {
            let inningsPitched: Double = Double(self.inningsOuts) / 3
            let walksPlusHits: Double = Double(self.walks + self.hits)
            let whip: Double = walksPlusHits / inningsPitched
            result =  Double(round(1000 * whip) / 1000)
        }
        return result
        
    }
}

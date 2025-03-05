//
//  BattingStats.swift
//  PixProStats
//
//  Created by Isaiah Hernandez on 2/21/25.
//

import Foundation

struct BattingStats: Codable, Identifiable {
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
    let singles: Int
    let doubles: Int
    let triples: Int
    let contact: Int
    let sacrificeFlys: Int
    let stolenBases: Int
    let plateAppearances: Int
    let rbis: Int
    let hitByPitch: Int
    let season: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case strikeouts = "strike_outs"
        case atBats = "at_bats"
        case walks
        case homeRuns = "home_runs"
        case numGames = "num_games"
        case strikes, hits, balls, runs
        case singles, doubles, triples, contact
        case sacrificeFlys = "sacrifice_flys"
        case stolenBases = "stolen_bases"
        case plateAppearances = "plate_apperances"
        case rbis
        case hitByPitch = "hit_by_pitch"
        case season
        
    }
    
    func toBattingStatsTupleList() -> [(String, Int)] {
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
            ("Singles", self.singles),
            ("Doubles", self.doubles),
            ("Triples", self.triples),
            ("Contact", self.contact),
            ("Sacrifice Flies", self.sacrificeFlys),
            ("Stolen Bases", self.stolenBases),
            ("Plate Apperances", self.plateAppearances),
            ("RBIs", self.rbis),
            ("Hit By Pitch", self.hitByPitch),
        ]
    }
    
    func getCalculatedStats() -> [(String, Double)] {
        return [
            ("AVG", self.getAverage()),
            ("OBP", self.getOnBasePercentage()),
            ("SLUG", self.getSluggingPercentage()),
            ("OPS", self.getOnBasePlusSlugging()),
        ]
    }
    
    func getAverage() -> Double {
        let avg: Double = Double(self.hits) / Double(self.atBats)
        return  Double(round(1000 * avg) / 1000)
    }
    
    func getOnBasePercentage() -> Double {
        let obp: Double = Double(self.hits + self.walks + self.hitByPitch) / Double(self.atBats + self.walks + self.hitByPitch + self.sacrificeFlys)
        return  Double(round(1000 * obp) / 1000)
    }
    
    func getSluggingPercentage() -> Double {
        let slg: Double = Double(self.singles + self.doubles * 2 + self.triples * 3 + self.homeRuns * 4) / Double(self.atBats)
        return  Double(round(1000 * slg) / 1000)
    }
    
    func getOnBasePlusSlugging() -> Double {
        let ops: Double = self.getOnBasePercentage() + self.getSluggingPercentage()
        return  Double(round(1000 * ops) / 1000)
    }
    
}

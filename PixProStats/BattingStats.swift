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
        case strikeouts = "strikeOuts"
        case atBats
        case walks
        case homeRuns
        case numGames
        case strikes, hits, balls, runs
        case singles = "base1"
        case doubles = "base2"
        case triples = "base3"
        case contact
        case sacrificeFlys = "sacrifices"
        case stolenBases = "stolen"
        case plateAppearances = "plateApp"
        case rbis = "runsBattedIn"
        case hitByPitch
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
        var result: Double = 0
        if self.hits >= 0 && self.atBats >= 0 {
            let avg: Double = Double(self.hits) / Double(self.atBats)
            result = Double(round(1000 * avg) / 1000)
        }
        return result
    }
    
    func getOnBasePercentage() -> Double {
        var result: Double = 0
        if self.hits >= 0 && self.walks >= 0 && self.hitByPitch >= 0 && self.atBats >= 0 && self.sacrificeFlys >= 0 {
            let obp: Double = Double(self.hits + self.walks + self.hitByPitch) / Double(self.atBats + self.walks + self.hitByPitch + self.sacrificeFlys)
            result = Double(round(1000 * obp) / 1000)
        }
        return result
       
    }
    
    func getSluggingPercentage() -> Double {
        var result: Double = 0
        if self.atBats >= 0 && self.singles >= 0 && self.doubles >= 0 && self.triples >= 0 && self.homeRuns >= 0{
            let slg: Double = Double(self.singles + self.doubles * 2 + self.triples * 3 + self.homeRuns * 4) / Double(self.atBats)
            result = Double(round(1000 * slg) / 1000)
        }
        return result
        
    }
    
    func getOnBasePlusSlugging() -> Double {
        var result: Double = 0
        let ops: Double = self.getOnBasePercentage() + self.getSluggingPercentage()
        if ops >= 0 {
            result = Double(round(1000 * ops) / 1000)
        }
        return result
    }
    
}

//
//  Player.swift
//  PixProStats
//
//  Created by Isaiah Hernandez on 2/22/25.
//

import Foundation

// MARK: - Player
struct Player: Codable, Identifiable {
    let id, name: String
    let handedness: HandednessType.RawValue
    let posistion: PositionType.RawValue
    let pitcherType: PitcherType.RawValue
    let designatedHitter: Bool
    let pitchingStats: [PitchingStats]
    let battingStats: [BattingStats]
    let isHof: Bool
    
    enum CodingKeys: String, CodingKey {
        case id, name, handedness, posistion
        case pitcherType = "pitcher_type"
        case designatedHitter = "designated_hitter"
        case pitchingStats = "pitching_stats"
        case battingStats = "batting_stats"
        case isHof = "is_hof"
    }
    
    func getFullPosition() -> String {
        var fullPosition = PositionType.description(rawValue: self.posistion)
        if self.posistion == PositionType.PITCHER.rawValue {
            fullPosition += ": " + PitcherType.description(rawValue: self.pitcherType)
        }
        else if self.designatedHitter == true{
            fullPosition += ": DH"
        }
        return fullPosition
    }
    
    func getHandedness() -> String {
        return HandednessType.description(rawValue: self.handedness)
    }
    
    func getBattingStats(forSeason: Int) -> BattingStats {
        var foundBattingStats: BattingStats!
        for battingStatsYear in self.battingStats {
            if battingStatsYear.season == forSeason{
                foundBattingStats = battingStatsYear
            }
        }
        return foundBattingStats
    }
    
    func getBattingStatsSpan(seasonsToLookFor: [Int]) -> BattingStats {
        var strikeouts: Int = 0
        var atBats: Int = 0
        var walks: Int = 0
        var homeRuns: Int = 0
        var numGames: Int = 0
        var strikes: Int = 0
        var hits: Int = 0
        var balls: Int = 0
        var runs: Int = 0
        var singles: Int = 0
        var doubles: Int = 0
        var triples: Int = 0
        var contact: Int = 0
        var sacrificeFlys: Int = 0
        var stolenBases: Int = 0
        var plateApp: Int = 0
        var rbis: Int = 0
        var hitByPitch: Int = 0
        for battingStatsYear in self.battingStats {
            if seasonsToLookFor.contains(battingStatsYear.season){
                strikeouts += battingStatsYear.strikeouts
                atBats += battingStatsYear.atBats
                walks += battingStatsYear.walks
                homeRuns += battingStatsYear.homeRuns
                numGames += battingStatsYear.numGames
                strikes += battingStatsYear.strikes
                hits += battingStatsYear.hits
                balls += battingStatsYear.balls
                runs += battingStatsYear.runs
                singles += battingStatsYear.singles
                doubles += battingStatsYear.doubles
                triples += battingStatsYear.triples
                contact += battingStatsYear.contact
                sacrificeFlys += battingStatsYear.sacrificeFlys
                stolenBases += battingStatsYear.stolenBases
                plateApp += battingStatsYear.plateAppearances
                rbis += battingStatsYear.rbis
                hitByPitch += battingStatsYear.hitByPitch
            }
        }
        
        return BattingStats(id: "allTime", strikeouts: strikeouts, atBats: atBats, walks: walks, homeRuns: homeRuns, numGames: numGames, strikes: strikes, hits: hits, balls: balls, runs: runs, singles: singles, doubles: doubles, triples: triples, contact: contact, sacrificeFlys: sacrificeFlys, stolenBases: stolenBases, plateAppearances: plateApp, rbis: rbis, hitByPitch: hitByPitch, season: -1)
    }
    
    func getPitchingStats(forSeason: Int) -> PitchingStats {
        var foundPitchingStats: PitchingStats!
        for pitchingStatsYear in self.pitchingStats {
            if pitchingStatsYear.season == forSeason{
                foundPitchingStats = pitchingStatsYear
            }
        }
        return foundPitchingStats
    }
    
    func getPitchingStatsSpan(seasonsToLookFor: [Int]) -> PitchingStats {
        var strikeouts: Int = 0
        var atBats: Int = 0
        var walks: Int = 0
        var homeRuns: Int = 0
        var numGames: Int = 0
        var strikes: Int = 0
        var hits: Int = 0
        var balls: Int = 0
        var runs: Int = 0
        var inningsOuts: Int = 0
        var pitches: Int = 0
        var earnedRuns: Int = 0
        
        for pitchingStat in pitchingStats {
            if seasonsToLookFor.contains(pitchingStat.season){
                strikeouts += pitchingStat.strikeouts
                atBats += pitchingStat.atBats
                walks += pitchingStat.walks
                homeRuns += pitchingStat.homeRuns
                numGames += pitchingStat.numGames
                strikes += pitchingStat.strikes
                hits += pitchingStat.hits
                balls += pitchingStat.balls
                runs += pitchingStat.runs
                inningsOuts += pitchingStat.inningsOuts
                pitches += pitchingStat.pitches
                earnedRuns += pitchingStat.earnedRuns
            }
        }
        
        return PitchingStats(id: "allTime", strikeouts: strikeouts, atBats: atBats, walks: walks, homeRuns: homeRuns, numGames: numGames, strikes: strikes, hits: hits, balls: balls, runs: runs, inningsOuts: inningsOuts, pitches: pitches, earnedRuns: earnedRuns, season: -1)
    }
    
}

enum HandednessType: Int, Codable {
    case LEFT = -1
    case RIGHT = 1
    
    static func description(rawValue: Int) -> String {
        switch rawValue {
        case HandednessType.LEFT.rawValue:
            return "Left Handed"
        case HandednessType.RIGHT.rawValue:
            return "Right Handed"
        default:
            return "N/A"
        }
    }
}

enum PositionType: Int, Codable {
    case PITCHER = 0
    case CATCHER = 1
    case FIRST_BASE = 2
    case SECOND_BASE = 3
    case THIRD_BASE = 4
    case SHORT_STOP = 5
    case LEFT_FIELD = 6
    case CENTER_FIELD = 7
    case RIGHT_FIELD = 8
    
    static func description(rawValue: Int) -> String {
        switch rawValue {
        case PositionType.PITCHER.rawValue:
            return "Pitcher"
        case PositionType.CATCHER.rawValue:
            return "Catcher"
        case PositionType.FIRST_BASE.rawValue:
            return "First Base"
        case PositionType.SECOND_BASE.rawValue:
            return "Second Base"
        case PositionType.THIRD_BASE.rawValue:
            return "Third Base"
        case PositionType.SHORT_STOP.rawValue:
            return "Short Stop"
        case PositionType.LEFT_FIELD.rawValue:
            return "Left Field"
        case PositionType.CENTER_FIELD.rawValue:
            return "Center Field"
        case PositionType.RIGHT_FIELD.rawValue:
            return "Right Field"
        default:
            return "N/A"
        }
    }
    
}



enum PitcherType: Int, Codable {
    case NOT_PITCHER = -1
    case STARTER = 0
    case RELIEVER = 1
    case CLOSER = 2
    
    static func description(rawValue: Int) -> String {
        switch rawValue {
        case PitcherType.STARTER.rawValue:
            return "Starter"
        case PitcherType.RELIEVER.rawValue:
            return "Reliever"
        case PitcherType.CLOSER.rawValue:
            return "Closer"
        default:
            return "N/A"
        }
    }
}

//
//  PreviewData.swift
//  PixProStats
//
//  Created by Isaiah Hernandez on 2/21/25.
//

import Foundation
import SwiftUI

var pitchingStatsPreviewData = PitchingStats(id: "fdsatery", strikeouts: 32, atBats: 0, walks: 0, homeRuns: 0, numGames: 45, strikes: 192, hits: 0, balls: 72, runs: 0, inningsOuts: 2, pitches: 300, earnedRuns: 20, season: 2023)
var battingStatsPreviewData = BattingStats(id: "fjkl-fd", strikeouts: 20, atBats: 150, walks: 10, homeRuns: 43, numGames: 162, strikes: 0, hits: 92, balls: 0, runs: 100, singles: 40, doubles: 40, triples: 12, contact: 150, sacrificeFlys: 0, stolenBases: 0, plateAppearances: 150, rbis: 150, hitByPitch: 0, season: 2023)
var battingStatsPreviewData2024 = BattingStats(id: "fjkl-fdf", strikeouts: 24, atBats: 69, walks: 12, homeRuns: 69, numGames: 162, strikes: 0, hits: 92, balls: 0, runs: 100, singles: 40, doubles: 40, triples: 12, contact: 150, sacrificeFlys: 0, stolenBases: 0, plateAppearances: 150, rbis: 150, hitByPitch: 0, season: 2024)

var playerPreviewData = Player(id: "dfasfsafa", name: "Bryce Harper", age: 32, overalls: ["2023": 99.0], handedness: HandednessType.LEFT.rawValue, position: PositionType.PITCHER.rawValue, pitcherType: PitcherType.STARTER.rawValue, pitchTypes: [PitchTypes.FBSinker, PitchTypes.CUCircle, PitchTypes.CB], designatedHitter: false, pitchingStats: [pitchingStatsPreviewData], battingStats: [battingStatsPreviewData, battingStatsPreviewData2024], isHof: true)

var playerListPreviewData = [Player](repeating: playerPreviewData, count: 3)

var recordPreviewData = Record(gamesWon: 112, gamesPlayed: 162)

var teamPreviewData = Team(name: "Cleveland Guardians", id: 13, isUserTeam: true)

var teamListPreviewData = [Team](repeating: teamPreviewData, count: 5)

var gamePreviewData = Game(id: "fdsafa", teamOne: teamPreviewData.id, teamTwo: teamPreviewData.id, teamOneScore: 1, teamTwoScore: 2, winner: teamPreviewData.id)

var gameListPreviewData = [Game](repeating: gamePreviewData, count: 7)

var seriesPreviewData = Series(id: "fdasfafas", teamOne: teamPreviewData.id, teamTwo: teamPreviewData.id, winner: teamPreviewData.id, games: gameListPreviewData, seriesLength: gameListPreviewData.count, seriesType: SeriesType.WORLD_SERIES.rawValue)




var seriesListPreviewData =  [Series](repeating: seriesPreviewData, count: 5)

var playoffsPreviewData = Playoffs(nlWildcard: seriesPreviewData, alWildcard: seriesPreviewData, nlDivisionalOne: seriesPreviewData, alDivisionalOne: seriesPreviewData, nlDivisionalTwo: seriesPreviewData, alDivisionalTwo: seriesPreviewData, nlChampionship: seriesPreviewData, alChampionship: seriesPreviewData, worldSeries: seriesPreviewData)

var awardsPreviewData = Awards(cyYoung: playerPreviewData.id, mvp: playerPreviewData.id, battingTitle: playerPreviewData.id, homeRunLeader: playerPreviewData.id)


var seasonTeamPlayersData = [String: [String]]()

var recordData = Record(gamesWon: 120, gamesPlayed: 162)
var teamRecordsData = ["13": recordData]


var seasonPreviewData = Season(id: 2022, playoffs: playoffsPreviewData, regularSeason: gameListPreviewData, awards: awardsPreviewData, hofClass: [playerPreviewData.id], teamSeasonPlayers: seasonTeamPlayersData,  teamRecords: teamRecordsData)

var divisionPreivewData = Division(id: "1", name: "NL East", teams: [13], conference: "NL")



var leaguePreviewData = League(divisions: [divisionPreivewData],teams: teamListPreviewData, players: playerListPreviewData, seasons:[seasonPreviewData], hofers: [playerPreviewData.id])






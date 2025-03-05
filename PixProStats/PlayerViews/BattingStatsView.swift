//
//  BattingStatsView.swift
//  PixProStats
//
//  Created by Isaiah Hernandez on 2/26/25.
//

import SwiftUI

struct BattingStatsView: View {
    var player: Player
    var seasonYear: Int?
    var teamId: Int?
    @EnvironmentObject var leagueListVM: LeagueViewModel
    @State private var selectedOption = LeagueViewModel.ALL_TIME
    
    var body: some View {
        
        let avaiblableBattingStats: [BattingStats] = leagueListVM.league?.getPlayerBattingStats(player: player, seasonYear: seasonYear, teamId: teamId) ?? []
        let availableSeasons: [Int] = leagueListVM.league?.getSeasonsToLookFor(player: player, seasonYear: seasonYear, teamId: teamId) ?? []
        VStack(alignment: .leading, spacing: 2){
            HStack(spacing: 10) {
                Menu{
                    //MARK Picker for stats year
                    Picker("Season:", selection: $selectedOption) {
                        ForEach(avaiblableBattingStats) {
                            battingStats in
                            Text(String(battingStats.season)).tag(battingStats.season)
                        }
                        Text("All Time").tag(LeagueViewModel.ALL_TIME)
                    }
                } label: {
                    battingStatsLabel
                }
            }
            
            let currBattingStats: BattingStats = (selectedOption > 0) ? player.getBattingStats(forSeason: selectedOption) : player.getBattingStatsSpan(seasonsToLookFor: availableSeasons)
            
            let calculatedBattingStatsTuplesList: [(String, Double)] = currBattingStats.getCalculatedStats()
            //MARK Calculated Stats
            CalculatedStatsView(statsList: calculatedBattingStatsTuplesList)
            
            let battingStatsTupleList: [(String, Int)] = currBattingStats.toBattingStatsTupleList()
            //MARK Raw Stats
            StatsListView(statsList: battingStatsTupleList)
            
            
        }
        .padding()
        .background(Color.rowColor)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: Color.primary.opacity(0.2), radius: 10, x: 0, y:5)
        
        
        
    }
    
    var battingStatsLabel: some View {
        HStack {
            let seasonString: String = selectedOption > 0 ? String(selectedOption) : "All Time"
            //MARK Title For Picker
            Text("Batting Stats: " + seasonString)
            Spacer()
            Text("⌵")
                .offset(y: -4)
        }
        .foregroundColor(Color.textColor)
        .font(.headline)
        .padding()
        .frame(height: 32)
        .cornerRadius(16)
        .opacity(0.7)
    }
}

#Preview {
    BattingStatsView(player: playerPreviewData)
}

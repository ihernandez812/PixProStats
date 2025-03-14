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
    @EnvironmentObject var leagueVM: LeagueViewModel
    @State private var selectedOption = LeagueViewModel.START_STATE
    
    var body: some View {
        
        let avaiblableBattingStats: [BattingStats] = leagueVM.league?.getPlayerBattingStats(player: player, seasonYear: seasonYear, teamId: teamId) ?? []
        let availableSeasons: [Int] = leagueVM.league?.getSeasonsToLookFor(player: player, seasonYear: seasonYear, teamId: teamId) ?? []
        VStack(alignment: .leading, spacing: 2){
            HStack(spacing: 10) {
                Menu{
                    //MARK Picker for stats year
                    Picker("Season:", selection: $selectedOption) {
                        ForEach(avaiblableBattingStats.indices, id: \.self) {
                            i in
                            let battingStats: BattingStats = avaiblableBattingStats[i]
                            Text(String(battingStats.season)).tag(i)
                        }
                        if seasonYear ?? -1 == LeagueViewModel.ALL_TIME {
                            Text("All Time").tag(LeagueViewModel.ALL_TIME)
                        }
                        
                    }
                } label: {
                    battingStatsLabel
                }
            }
            
            let selectedYear = (selectedOption != LeagueViewModel.ALL_TIME) ? avaiblableBattingStats[selectedOption].season : LeagueViewModel.ALL_TIME
            
            let currBattingStats: BattingStats = (selectedYear > LeagueViewModel.START_STATE) ? player.getBattingStats(forSeason: selectedYear) : player.getBattingStatsSpan(seasonsToLookFor: availableSeasons)
            
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
            let avaiblableBattingStats: [BattingStats] = leagueVM.league?.getPlayerBattingStats(player: player, seasonYear: seasonYear, teamId: teamId) ?? []
            let seasonString: String = (selectedOption != LeagueViewModel.ALL_TIME) ? String(avaiblableBattingStats[selectedOption].season) : "All Time"
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

struct BattingStatsView_Previews: PreviewProvider {
    static let leagueViewModel : LeagueViewModel = {
        let leagueViewModel = LeagueViewModel()
        leagueViewModel.league = leaguePreviewData
        return leagueViewModel
    }()
    
    static var previews: some View {
        BattingStatsView(player: playerPreviewData)
            .environmentObject(leagueViewModel)
    }
}

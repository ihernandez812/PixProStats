//
//  PitchingStatsView.swift
//  PixProStats
//
//  Created by Isaiah Hernandez on 2/27/25.
//

import SwiftUI


struct PitchingStatsView: View {
    var player: Player
    var seasonYear: Int?
    var teamId: Int?
    @EnvironmentObject var leagueVM: LeagueViewModel
    @State private var selectedOption = LeagueViewModel.START_STATE
    
    var body: some View {
        let avaiblablePitchingStats: [PitchingStats] = leagueVM.league?.getPlayerPitchingStats(player: player, seasonYear: seasonYear, teamId: teamId) ?? []
        let availableSeasons: [Int] = leagueVM.league?.getSeasonsToLookFor(player: player, seasonYear: seasonYear, teamId: teamId) ?? []
        VStack(alignment: .leading, spacing: 2){
            HStack(spacing: 0) {
                Menu {
                    //MARK Picker for stats year
                    Picker("Season:", selection: $selectedOption) {
                        ForEach(avaiblablePitchingStats.indices, id: \.self) {
                            i in
                            let pitchingStats: PitchingStats = player.pitchingStats[i]
                            Text(String(pitchingStats.season)).tag(i)
                        }
                        if seasonYear ?? -1 == LeagueViewModel.ALL_TIME {
                            Text("All Time").tag(LeagueViewModel.ALL_TIME)
                        }
                    }
                } label: {
                    pitchingStatsLabel
                    
                }
            }
            
            let selectedYear = (selectedOption != LeagueViewModel.ALL_TIME) ? avaiblablePitchingStats[selectedOption].season : LeagueViewModel.ALL_TIME
            
            let currPitchingStats: PitchingStats = selectedYear > LeagueViewModel.START_STATE ? player.getPitchingStats(forSeason: selectedYear) :
            player.getPitchingStatsSpan(seasonsToLookFor: availableSeasons)
            
            //MARK Calculated Stats
            let calculatedPitchingStatsTuplesList: [(String, Double)] = currPitchingStats.getCalculatedStats()
            CalculatedStatsView(statsList: calculatedPitchingStatsTuplesList)
            
            //MARK Stats View
            let pitchingStatsTupleList: [(String, Int)] = currPitchingStats.toPitchingStatsTupleList()
            StatsListView(statsList: pitchingStatsTupleList)
            
            
        }
        .padding()
        .background(Color.rowColor)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: Color.primary.opacity(0.2), radius: 10, x: 0, y:5)
        
        
    }
    
    var pitchingStatsLabel: some View {
        HStack {
            
            let avaiblablePitchingStats: [PitchingStats] = leagueVM.league?.getPlayerPitchingStats(player: player, seasonYear: seasonYear, teamId: teamId) ?? []
            let seasonString: String = (selectedOption != LeagueViewModel.ALL_TIME) ? String(avaiblablePitchingStats[selectedOption].season) : "All Time"
            
            Text("Pitching Stats: " + seasonString)
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

struct PitchingStatsView_Previews: PreviewProvider {
    static let leagueViewModel : LeagueViewModel = {
        let leagueViewModel = LeagueViewModel()
        leagueViewModel.league = leaguePreviewData
        return leagueViewModel
    }()
    
    static var previews: some View {
        PitchingStatsView(player: playerPreviewData)
            .environmentObject(leagueViewModel)
    }
}

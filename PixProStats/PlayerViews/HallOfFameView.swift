//
//  HallOfFameView.swift
//  PixProStats
//
//  Created by Isaiah Hernandez on 3/1/25.
//

import SwiftUI

struct HallOfFameView: View {
    @EnvironmentObject var leagueListVM: LeagueViewModel
    @State private var selectedOption = LeagueViewModel.ALL_TIME
    
    var body: some View {
        VStack(alignment: .leading){
            if let league: League = leagueListVM.league {
                let seasons: [Season] = league.seasons
                //MARK Hall Of Fame Year Picker
                HStack(spacing: 10) {
                    Menu{
                        Picker("Season:", selection: $selectedOption) {
                            ForEach(seasons) {
                                season in
                                Text(String(season.getYear()))
                            }
                            Text("All Time").tag(LeagueViewModel.ALL_TIME)
                        }
                    } label: {
                        battingStatsLabel
                    }
                }
                
                //MARK Hall of Fame Players
                let playerIds: [String] = (selectedOption > 0) ? league.getSeasonByYear(seasonYear: selectedOption).hofClass : league.hofers
                if playerIds.isEmpty {
                    Text("No Hall Of Famers")
                        .padding(.top, 10)
                        .font(.subheadline)
                        .padding(.horizontal, 50)
                        .foregroundColor(Color.textColor)
                        .opacity(0.5)
                }
                else{
                    let players: [Player] = league.players.filter { playerIds.contains($0.id) }
                    ForEach(players) { player in
                        PlayerRow(player: player)
                    }
                }
            }
            
            
            
        }
        .padding()
        .frame(maxHeight: .infinity, alignment: .top)
        .background(Color.rowColor)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: Color.primary.opacity(0.2), radius: 10, x: 0, y:5)
        .background(Color.backgroundColor)
        
        
        
        
    }
    
    var battingStatsLabel: some View {
        HStack {
            
            let seasonString: String = selectedOption > 0 ? String(selectedOption) : "All Time"
            
            Text("Hall Of Fame Class: " + seasonString)
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

struct HallOfFameView_Previews: PreviewProvider {
    static let leagueListViewModel : LeagueViewModel = {
        let leagueListViewModel = LeagueViewModel()
        leagueListViewModel.league = leaguePreviewData
        return leagueListViewModel
    }()
    
    static var previews: some View {
        HallOfFameView()
            .environmentObject(leagueListViewModel)
    }
}


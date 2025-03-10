//
//  HallOfFameView.swift
//  PixProStats
//
//  Created by Isaiah Hernandez on 3/1/25.
//

import SwiftUI

struct HallOfFameView: View {
    @EnvironmentObject var leagueVM: LeagueViewModel
    @State private var selectedOption = LeagueViewModel.ALL_TIME
    
    var body: some View {
        VStack(alignment: .leading){
            if let league: League = leagueVM.league {
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
                .padding()
                .background(Color.rowColor)
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                .shadow(color: Color.primary.opacity(0.2), radius: 10, x: 0, y:5)
                ScrollView{
                    //MARK Hall of Fame Players
                    let playerIds: [String] = (selectedOption > 0) ? league.getSeasonByYear(seasonYear: selectedOption).hofClass : league.hofers
                    if playerIds.isEmpty {
                        HStack{
                            Text("No Hall Of Famers")
                                
                        }
                        .padding(.top, 10)
                        .frame(maxWidth: .infinity)
                        .font(.subheadline)
                        .foregroundColor(Color.textColor)
                        .opacity(0.5)
                        
                    }
                    else{
                        let players: [Player] = league.players.filter { playerIds.contains($0.id) }
                        ForEach(players) { player in
                            PlayerRow(player: player)
                            
                            Divider()
                        }
                    }
                }
                .padding()
                .background(Color.rowColor)
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                .shadow(color: Color.primary.opacity(0.2), radius: 10, x: 0, y:5)
            }
            
            
            
        }
        .padding()
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
        //.opacity(0.7)
    }
}

struct HallOfFameView_Previews: PreviewProvider {
    static let leagueViewModel : LeagueViewModel = {
        let leagueViewModel = LeagueViewModel()
        leagueViewModel.league = leaguePreviewData
        return leagueViewModel
    }()
    
    static var previews: some View {
        HallOfFameView()
            .environmentObject(leagueViewModel)
    }
}


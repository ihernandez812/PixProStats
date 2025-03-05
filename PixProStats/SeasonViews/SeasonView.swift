//
//  SeasonView.swift
//  PixProStats
//
//  Created by Isaiah Hernandez on 3/2/25.
//

import SwiftUI

struct SeasonView: View {
    var seasonYear: Int
    @EnvironmentObject var leaugeListVM: LeagueViewModel
    
    var body: some View {
        VStack{
            HStack{
                Text(String(seasonYear) + " Season")
                    .bold()
                    .foregroundColor(Color.textColor)
                
                Spacer()
                
                HStack{
                    
                    NavigationLink(destination: AwardsView(seasonYear: seasonYear)){
                        Text("Awards")
                        
                    }
                    
                    NavigationLink(destination: PlayoffsBracketView(seasonYear: seasonYear)){
                        Text("Post Season")
                    }
                    
                    let games: [Game] = leaugeListVM.league?.getSeasonByYear(seasonYear: seasonYear).regularSeason ?? []
                    let label: String = String(seasonYear) + " Regular Season"
                    NavigationLink(destination: GameList(games: games, label: label)) {
                        Text("Games")
                    }
                }
                .buttonStyle(.bordered)
                .foregroundColor(Color.iconColor)
            }
            .padding(.bottom,0)
            
            //MARK Seasons List
            TeamList(seasonYear: seasonYear)
        }
        .padding()
        .background(Color.rowColor)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: Color.primary.opacity(0.2), radius: 10, x: 0, y:5)
        .background(Color.backgroundColor)
        
        
        
        
        
    }
}


struct Season_Previews: PreviewProvider {
    static let leagueListViewModel : LeagueViewModel = {
        let leagueListViewModel = LeagueViewModel()
        leagueListViewModel.league = leaguePreviewData
        return leagueListViewModel
    }()
    
    static var previews: some View {
        SeasonView(seasonYear: 2023)
            .environmentObject(leagueListViewModel)
    }
}

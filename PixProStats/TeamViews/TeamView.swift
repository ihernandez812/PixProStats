//
//  TeamView.swift
//  PixProStats
//
//  Created by Isaiah Hernandez on 3/2/25.
//

import SwiftUI

struct TeamView: View {
    var seasonYear: Int
    var teamId: Int
    @EnvironmentObject var leagueListVM: LeagueViewModel
    
    var body: some View {
        
        VStack{
            let teams: [Team] = leagueListVM.league?.teams ?? []
            let teamName: String = teams.first(where: { $0.id == teamId })?.name ?? "Unknown"
            HStack{
                if seasonYear == LeagueViewModel.ALL_TIME && teamId == LeagueViewModel.ALL_TIME {
                    Text("All Players")
                        .bold()
                    
                }
                else if seasonYear == LeagueViewModel.ALL_TIME {
                    Text("All Time " + String(teamName))
                        .bold()
                }
                else{
                    Text(String(seasonYear) + " " + String(teamName))
                        .bold()
                }
                Spacer()
                HStack{
                    //Currently not supporting viewing all teams games
                    if(seasonYear != LeagueViewModel.ALL_TIME){
                        let games: [Game] = leagueListVM.league?.getSeasonByYear(seasonYear: seasonYear).regularSeason ?? []
                        let teamGames: [Game] = games.filter({ $0.teamOne == teamId || $0.teamTwo == teamId })
                        let label: String = String(seasonYear) + " " + teamName + " Season"
                        NavigationLink(destination: GameList(games: teamGames, label: label)) {
                            Text("Games")
                        }
                    }
                }
                .buttonStyle(.bordered)
                .foregroundColor(Color.iconColor)
                
            }
            .padding()
            .foregroundColor(Color.textColor)
            .background(Color.rowColor)
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .shadow(color: Color.primary.opacity(0.2), radius: 10, x: 0, y:5)
            
            //MARK Seasons List
            //            guard let seasons: [Season] = leaugeListVM.league?.seasons else {
            //                return EmptyView()
            //            }
            //            guard let teams: [Team] = leaugeListVM.league?.teams else {
            //                return EmptyView()
            //            }
            PlayerList(seasonYear: seasonYear, teamId: teamId)
            
        }
        .background(Color.backgroundColor)
        
    }
}


struct TeamView_Previews: PreviewProvider {
    static let leagueListViewModel : LeagueViewModel = {
        let leagueListViewModel = LeagueViewModel()
        leagueListViewModel.league = leaguePreviewData
        return leagueListViewModel
    }()
    
    static var previews: some View {
        TeamView(seasonYear: 2023, teamId: 13)
            .environmentObject(leagueListViewModel)
    }
}


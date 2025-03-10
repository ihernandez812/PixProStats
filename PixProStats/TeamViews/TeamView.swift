//
//  TeamView.swift
//  PixProStats
//
//  Created by Isaiah Hernandez on 3/2/25.
//

import SwiftUI
import SwiftUIFontIcon

struct TeamView: View {
    var seasonYear: Int
    var teamId: Int
    @EnvironmentObject var leagueVM: LeagueViewModel
    
    var body: some View {
        
        VStack{
            let teams: [Team] = leagueVM.league?.teams ?? []
            let teamName: String = teams.first(where: { $0.id == teamId })?.name ?? "Unknown"
            HStack{
                if seasonYear == LeagueViewModel.ALL_TIME {
                    Text("All Time " + String(teamName))
                        .bold()
                }
                else{
                    Text(String(seasonYear) + " " + String(teamName))
                        .bold()
                }
                
                let worldSeriesWinCount: Int = leagueVM.league?.getWorldSeriesWinCount(teamId: teamId) ?? 0
                if worldSeriesWinCount > 0{
                    HStack(spacing: 2){
                        //MARK HOF Badge
                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                            .fill(Color.iconColor.opacity(0.3))
                            .frame(width: 20, height: 20)
                            .overlay{
                                FontIcon.text(.awesome5Solid(code: .trophy), fontsize: 10, color: Color.iconColor)
                            }
                            
                        if seasonYear == LeagueViewModel.ALL_TIME {
                            Text("x \(worldSeriesWinCount)")
                                .baselineOffset(1.0)
                                .font(.caption)
                        }
                        
                        
                    }
                }
                Spacer()
                HStack{
                    //Currently not supporting viewing all teams games
                    if(seasonYear != LeagueViewModel.ALL_TIME){
                        let games: [Game] = leagueVM.league?.getSeasonByYear(seasonYear: seasonYear).regularSeason ?? []
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
            PlayerList(seasonYear: seasonYear, teamId: teamId)
            
        }
        .background(Color.backgroundColor)
        
    }
}


struct TeamView_Previews: PreviewProvider {
    static let leagueViewModel : LeagueViewModel = {
        let leagueViewModel = LeagueViewModel()
        leagueViewModel.league = leaguePreviewData
        return leagueViewModel
    }()
    
    static var previews: some View {
        TeamView(seasonYear: -1, teamId: 13)
            .environmentObject(leagueViewModel)
    }
}


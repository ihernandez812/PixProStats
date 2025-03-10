//
//  SeasonView.swift
//  PixProStats
//
//  Created by Isaiah Hernandez on 3/2/25.
//

import SwiftUI

struct SeasonView: View {
    var seasonYear: Int
    @State private var sortType: LeagueSortType = .division
    @EnvironmentObject var leagueVM: LeagueViewModel
    
    var body: some View {
        VStack{
            HStack{
                Text(String(seasonYear) + " Season")
                    .bold()
                    .foregroundColor(Color.textColor)
                
                Picker("Season:", selection: $sortType) {
                    ForEach(LeagueSortType.allCases){ leagueSortType in
                        Text(leagueSortType.rawValue.capitalized)
                            .foregroundColor(Color.textColor)
                    }
                }
                
                Spacer()
                
                HStack{
                    
                    NavigationLink(destination: AwardsView(seasonYear: seasonYear)){
                        Text("Awards")
                        
                    }
                    
                    NavigationLink(destination: PlayoffsBracketView(seasonYear: seasonYear)){
                        Text("Post Season")
                    }
                    
                    let games: [Game] = leagueVM.league?.getSeasonByYear(seasonYear: seasonYear).regularSeason ?? []
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
            if sortType == .division{
                TeamListDivisionView(seasonYear: seasonYear)
            }
            else if sortType == .conference{
                TeamListConferenceView(seasonYear: seasonYear)
            }
            else if sortType == .all{
                TeamListAllView(seasonYear: seasonYear)
            }
            
        }
        .padding()
        .background(Color.rowColor)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: Color.primary.opacity(0.2), radius: 10, x: 0, y:5)
        .background(Color.backgroundColor)
        
        
        
        
        
    }
}


struct Season_Previews: PreviewProvider {
    static let leagueViewModel : LeagueViewModel = {
        let leagueViewModel = LeagueViewModel()
        leagueViewModel.league = leaguePreviewData
        return leagueViewModel
    }()
    
    static var previews: some View {
        SeasonView(seasonYear: 2023)
            .environmentObject(leagueViewModel)
    }
}

//
//  AwardsView.swift
//  PixProStats
//
//  Created by Isaiah Hernandez on 2/27/25.
//

import SwiftUI

struct AwardsView: View {
    var seasonYear: Int
    @EnvironmentObject var leagueListVM: LeagueViewModel
    
    var body: some View {
        VStack{
            VStack{
                //MARK Title
                Text(String(seasonYear) + " Awards")
                    .bold()
                    .padding(.bottom, 0)
                    .foregroundColor(Color.textColor)
                
                Spacer()
                
                if let season: Season = leagueListVM.league?.getSeasonByYear(seasonYear: seasonYear) {
                    let cyYoung: String = season.awards.cyYoung
                    if let player: Player = leagueListVM.league?.getPlayerById(playerId: cyYoung) {
                        Text("Cy Young")
                            .font(.headline)
                            .foregroundStyle(Color.textColor)
                            .opacity(0.7)
                        //MARK Link to Player Stats for season
                        NavigationLink(destination: {
                            PlayerInfo(playerId: cyYoung, seasonYear: seasonYear)
                        }){
                            PlayerRow(player: player)
                        }
                        Divider()
                    }
                    
                    let mvp: String = season.awards.mvp
                    if let player: Player = leagueListVM.league?.getPlayerById(playerId: mvp) {
                        Text("MVP")
                            .font(.headline)
                            .foregroundStyle(Color.textColor)
                            .opacity(0.7)
                        //MARK Link to Player Stats for season
                        NavigationLink(destination: {
                            PlayerInfo(playerId: mvp, seasonYear: seasonYear)
                        }){
                            PlayerRow(player: player)
                        }
                        Divider()
                    }
                }
                
            }
        }
        .padding()
        .padding(.top)
        .background(Color.rowColor)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: Color.primary.opacity(0.2), radius: 10, x: 0, y:5)
        .background(Color.backgroundColor)
        
    }
}

struct AwardsView_Previews: PreviewProvider {
    static let leagueViewModel : LeagueViewModel = {
        let leagueListViewModel = LeagueViewModel()
        leagueListViewModel.league = leaguePreviewData
        return leagueListViewModel
    }()
    
    static var previews: some View {
        AwardsView(seasonYear: 2023)
            .environmentObject(leagueViewModel)
    }
}

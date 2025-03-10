//
//  AwardsView.swift
//  PixProStats
//
//  Created by Isaiah Hernandez on 2/27/25.
//

import SwiftUI

struct AwardsView: View {
    var seasonYear: Int
    @EnvironmentObject var leagueVM: LeagueViewModel
    
    var body: some View {
        
        VStack{
            HStack{
                Text(String(seasonYear) + " Awards")
                    .bold()

                Spacer()
                
            }
            .padding([.top, .bottom, .horizontal], 20)
            .foregroundColor(Color.textColor)
            .background(Color.rowColor)
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .shadow(color: Color.primary.opacity(0.2), radius: 10, x: 0, y:5)
            ScrollView(){
                    if let season: Season = leagueVM.league?.getSeasonByYear(seasonYear: seasonYear) {
                        let cyYoung: String = season.awards.cyYoung
                        if let player: Player = leagueVM.league?.getPlayerById(playerId: cyYoung) {
                            Text("Cy Young")
                                .font(.subheadline)
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
                        if let player: Player = leagueVM.league?.getPlayerById(playerId: mvp) {
                            Text("MVP")
                                .font(.subheadline)
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
                        
                        let battingTitle: String = season.awards.battingTitle
                        if let player: Player = leagueVM.league?.getPlayerById(playerId: battingTitle) {
                            Text("Batting Title")
                                .font(.subheadline)
                                .foregroundStyle(Color.textColor)
                                .opacity(0.7)
                            //MARK Link to Player Stats for season
                            NavigationLink(destination: {
                                PlayerInfo(playerId: battingTitle, seasonYear: seasonYear)
                            }){
                                PlayerRow(player: player)
                            }
                            Divider()
                        }
                        
                        let homeRunLeader: String = season.awards.homeRunLeader
                        if let player: Player = leagueVM.league?.getPlayerById(playerId: homeRunLeader) {
                            Text("Home Run Leader")
                                .font(.subheadline)
                                .foregroundStyle(Color.textColor)
                                .opacity(0.7)
                            //MARK Link to Player Stats for season
                            NavigationLink(destination: {
                                PlayerInfo(playerId: homeRunLeader, seasonYear: seasonYear)
                            }){
                                PlayerRow(player: player)
                            }
                            Divider()
                        }
                    }
                }
                .padding()
                .padding(.top)
                .background(Color.rowColor)
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                .shadow(color: Color.primary.opacity(0.2), radius: 10, x: 0, y:5)

        }
        .padding()
        .background(Color.backgroundColor)
        
    }
}

struct AwardsView_Previews: PreviewProvider {
    static let leagueViewModel : LeagueViewModel = {
        let leagueViewModel = LeagueViewModel()
        leagueViewModel.league = leaguePreviewData
        return leagueViewModel
    }()
    
    static var previews: some View {
        AwardsView(seasonYear: 2023)
            .environmentObject(leagueViewModel)
    }
}

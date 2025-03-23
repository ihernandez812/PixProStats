//
//  PlayerList.swift
//  PixProStats
//
//  Created by Isaiah Hernandez on 2/23/25.
//

import SwiftUI

struct PlayerList: View {
    var seasonYear: Int
    var teamId: Int
    @EnvironmentObject var leagueVM: LeagueViewModel
    
    var body: some View {
        
        VStack{
            ScrollView {
                if seasonYear == LeagueViewModel.ALL_TIME && teamId == LeagueViewModel.ALL_TIME {
                    let allPlayers = leagueVM.league?.players ?? []
                    ForEach(allPlayers){ player in
                        let playerId: String = player.id
                        
                        NavigationLink(destination: PlayerInfo(playerId: playerId, seasonYear: seasonYear, teamId: teamId)){
                            PlayerRow(player: player, overall: Float(LeagueViewModel.ALL_TIME))
                        }
                        Divider()
                    }
                }
                else if seasonYear == LeagueViewModel.ALL_TIME  && teamId != LeagueViewModel.ALL_TIME {
                    if let allTimeTeamPlayers: [String] = leagueVM.league?.getAllTimeTeamPlayers(teamId: teamId) {
                        ForEach(allTimeTeamPlayers.indices, id: \.self) { i in
                            let playerId = allTimeTeamPlayers[i]
                            if let player: Player = leagueVM.league?.getPlayerById(playerId: playerId) {
                                NavigationLink(destination: PlayerInfo(playerId: playerId, seasonYear: seasonYear, teamId: teamId)){
                                    PlayerRow(player: player, overall: Float(LeagueViewModel.ALL_TIME))
                                }
                                Divider()
                            }
                        }
                    }
                }
                else{
                    if let season: Season = leagueVM.league?.getSeasonByYear(seasonYear: seasonYear) {
                        if let teamSeasonPlayers: [String] = season.teamSeasonPlayers[String(teamId)] {
                            ForEach(teamSeasonPlayers.indices, id: \.self){ i in
                                let playerId = teamSeasonPlayers[i]
                                if let player: Player = leagueVM.league?.getPlayerById(playerId: playerId) {
                                    NavigationLink(destination: PlayerInfo(playerId: playerId, seasonYear: seasonYear, teamId: teamId)){
                                        let overall: Float = player.getOverallByYear(forSeason: String(seasonYear))
                                        PlayerRow(player: player, overall: overall)
                                    }
                                    Divider()
                                }
                            }
                        }
                    }
                }
                
            }
            .padding()
            .background(Color.rowColor)
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .shadow(color: Color.primary.opacity(0.2), radius: 10, x: 0, y:5)
            .background(Color.backgroundColor)
            
        }
        
    }
}


struct PlayerList_Previews: PreviewProvider {
    static let leagueViewModel : LeagueViewModel = {
        let leagueViewModel = LeagueViewModel()
        leagueViewModel.league = leaguePreviewData
        return leagueViewModel
    }()
    
    static var previews: some View {
        PlayerList(seasonYear: 2023, teamId: 13)
            .environmentObject(leagueViewModel)
    }
}

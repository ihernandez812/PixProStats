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
                    let sortedPlayers = allPlayers.sorted { (player1, player2) -> Bool in
                        return sortPlayers(p1: player1, p2: player2, seasonYear: LeagueViewModel.ALL_TIME)
                    }
                    ForEach(sortedPlayers){ player in
                        let playerId: String = player.id
                        
                        NavigationLink(destination: PlayerInfo(playerId: playerId, seasonYear: seasonYear, teamId: teamId)){
                            PlayerRow(player: player, overall: Float(LeagueViewModel.ALL_TIME))
                        }
                        Divider()
                    }
                }
                else if seasonYear == LeagueViewModel.ALL_TIME  && teamId != LeagueViewModel.ALL_TIME {
                    if let allTimeTeamPlayers: Set<Player> = leagueVM.league?.getAllTimeTeamPlayers(teamId: teamId) {
                        let sortedPlayers = allTimeTeamPlayers.sorted { (player1, player2) -> Bool in
                            return sortPlayers(p1: player1, p2: player2, seasonYear: LeagueViewModel.ALL_TIME)
                        }
                        ForEach(sortedPlayers) { player in
                            NavigationLink(destination: PlayerInfo(playerId: player.id, seasonYear: seasonYear, teamId: teamId)){
                                PlayerRow(player: player, overall: Float(LeagueViewModel.ALL_TIME))
                            }
                            Divider()
                            
                        }
                    }
                }
                else{
                    
                    if let season: Season = leagueVM.league?.getSeasonByYear(seasonYear: seasonYear) {
                        if let teamSeasonPlayersIds: [String] = season.teamSeasonPlayers[String(teamId)] {
                            let teamSeasonPlayers = leagueVM.league?.getPlayersByIds(playerIds: teamSeasonPlayersIds) ?? []
                            let sortedPlayers = teamSeasonPlayers.sorted { (player1, player2) -> Bool in
                                return sortPlayers(p1: player1, p2: player2, seasonYear: season.getYear())
                            }
                            ForEach(sortedPlayers){ player in
                                NavigationLink(destination: PlayerInfo(playerId: player.id, seasonYear: seasonYear, teamId: teamId)){
                                    let overall: Float = player.getOverallByYear(forSeason: String(seasonYear))
                                    PlayerRow(player: player, overall: overall)
                                }
                                Divider()
                                
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
    
    func sortPlayers(p1: Player, p2: Player, seasonYear: Int) -> Bool {
        var res : Bool = p1.position < p2.position
        if p1.position == p2.position {
            res = p1.pitcherType < p2.pitcherType
            if p1.pitcherType == p2.pitcherType && seasonYear != LeagueViewModel.ALL_TIME {
                let seasonString: String = String(seasonYear)
                let p1Overall: Float = p1.overalls[seasonString] ?? 0
                let p2Overall: Float = p2.overalls[seasonString] ?? 0
                res = p1Overall > p2Overall
            }
        }
        return res
       
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

//
//  PlayerInfoView.swift
//  PixProStats
//
//  Created by Isaiah Hernandez on 2/26/25.
//

import SwiftUI

import Foundation
import SwiftUI
import SwiftUIFontIcon


struct PlayerInfo: View {
    var playerId: String
    var seasonYear: Int?
    var teamId: Int?
    @EnvironmentObject var leagueVM: LeagueViewModel
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 2){
            
            //MARK Player Row
            if let player: Player = self.leagueVM.league?.getPlayerById(playerId: self.playerId) {
                PlayerRow(player: player)
                    .padding()
                    .background(Color.rowColor)
                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                    .shadow(color: Color.primary.opacity(0.2), radius: 10, x: 0, y:5)
                
                //MARK Player Stats
                if(player.posistion == PositionType.PITCHER.rawValue){
                    PitchingStatsView(player: player, seasonYear: self.seasonYear, teamId: self.teamId)
                    
                }
                else {
                    BattingStatsView(player: player, seasonYear: self.seasonYear, teamId: self.teamId)
                    
                }
            }
            
        }
        .background(Color.backgroundColor)
    }
    
}


struct PlayerInfo_Previews: PreviewProvider {
    static let leagueViewModel : LeagueViewModel = {
        let leagueViewModel = LeagueViewModel()
        leagueViewModel.league = leaguePreviewData
        return leagueViewModel
    }()
    
    static var previews: some View {
        PlayerInfo(playerId: "mpYQS49IkiYBhrjt")
            .environmentObject(leagueViewModel)
    }
}

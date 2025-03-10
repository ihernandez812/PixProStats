//
//  SeasonsList.swift
//  PixProStats
//
//  Created by Isaiah Hernandez on 2/23/25.
//

import SwiftUI

struct SeasonsList: View {
    @EnvironmentObject var leagueVM: LeagueViewModel
    
    var body: some View {
        
        //MARK Seasons List
        let seasons: [Season] = leagueVM.league?.seasons ?? []
        let teams: [Team] = leagueVM.league?.teams ?? []
        ForEach(seasons){
            season in
            NavigationLink(destination: SeasonView(seasonYear: season.getYear())) {
                SeasonRow(season: season, teams: teams)
                    .padding()
                    .background(Color.rowColor)
                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                    .shadow(color: Color.primary.opacity(0.2), radius: 10, x: 0, y:5)
                
            }
            Divider()
        }
        
        
        
        
        
        
    }
}


struct SeasonsList_Previews: PreviewProvider {
    static let leagueViewModel : LeagueViewModel = {
        let leagueViewModel = LeagueViewModel()
        leagueViewModel.league = leaguePreviewData
        return leagueViewModel
    }()
    
    static var previews: some View {
        SeasonsList()
            .environmentObject(leagueViewModel)
    }
}

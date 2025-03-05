//
//  SeasonsList.swift
//  PixProStats
//
//  Created by Isaiah Hernandez on 2/23/25.
//

import SwiftUI

struct SeasonsList: View {
    @EnvironmentObject var leaugeListVM: LeagueViewModel
    
    var body: some View {
        
        //MARK Seasons List
        let seasons: [Season] = leaugeListVM.league?.seasons ?? []
        let teams: [Team] = leaugeListVM.league?.teams ?? []
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
    static let leagueListViewModel : LeagueViewModel = {
        let leagueListViewModel = LeagueViewModel()
        leagueListViewModel.league = leaguePreviewData
        return leagueListViewModel
    }()
    
    static var previews: some View {
        SeasonsList()
            .environmentObject(leagueListViewModel)
    }
}

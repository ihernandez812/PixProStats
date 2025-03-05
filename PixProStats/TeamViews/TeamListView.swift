//
//  TeamListView.swift
//  PixProStats
//
//  Created by Isaiah Hernandez on 3/4/25.
//

import SwiftUI

struct TeamListView: View {
    @EnvironmentObject var leagueListVM: LeagueViewModel
    var body: some View {
        
        VStack(alignment: .leading){
            Text("All Time Teams")
                .bold()
                .padding()
                .foregroundColor(Color.textColor)
            
            TeamList(seasonYear: LeagueViewModel.ALL_TIME)
        }
        .padding()
        .background(Color.rowColor)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: Color.primary.opacity(0.2), radius: 10, x: 0, y:5)
        .background(Color.backgroundColor)
    }
}

struct TeamListView_Previews: PreviewProvider {
    static let leagueListViewModel : LeagueViewModel = {
        let leagueListViewModel = LeagueViewModel()
        leagueListViewModel.league = leaguePreviewData
        return leagueListViewModel
    }()
    
    static var previews: some View {
        TeamListView()
            .environmentObject(leagueListViewModel)
    }
}

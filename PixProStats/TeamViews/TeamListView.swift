//
//  TeamListView.swift
//  PixProStats
//
//  Created by Isaiah Hernandez on 3/4/25.
//

import SwiftUI

struct TeamListView: View {
    @EnvironmentObject var leagueVM: LeagueViewModel
    @State private var sortType: LeagueSortType = .division
    var body: some View {
        
        VStack(alignment: .leading){
            HStack{
                Text("All Time Teams")
                    .bold()
                    .padding()
                    .foregroundColor(Color.textColor)
                
                Picker("Season:", selection: $sortType) {
                    ForEach(LeagueSortType.allCases){ leagueSortType in
                        Text(leagueSortType.rawValue.capitalized)
                            .foregroundColor(Color.textColor)
                    }
                }
            }
            
            //MARK Seasons List
            if sortType == .division{
                TeamListDivisionView(seasonYear: LeagueViewModel.ALL_TIME)
            }
            else if sortType == .conference{
                TeamListConferenceView(seasonYear: LeagueViewModel.ALL_TIME)
            }
            else if sortType == .all{
                TeamListAllView(seasonYear: LeagueViewModel.ALL_TIME)
            }
        }
        .padding()
        .background(Color.rowColor)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: Color.primary.opacity(0.2), radius: 10, x: 0, y:5)
        .background(Color.backgroundColor)
    }
}

struct TeamListView_Previews: PreviewProvider {
    static let leagueViewModel : LeagueViewModel = {
        let leagueViewModel = LeagueViewModel()
        leagueViewModel.league = leaguePreviewData
        return leagueViewModel
    }()
    
    static var previews: some View {
        TeamListView()
            .environmentObject(leagueViewModel)
    }
}

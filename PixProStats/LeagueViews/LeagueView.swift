//
//  LeagueView.swift
//  PixProStats
//
//  Created by Isaiah Hernandez on 3/2/25.
//

import SwiftUI


struct LeagueView: View {
    @EnvironmentObject var leagueListVM: LeagueViewModel
    
    var body: some View {
        VStack{
            //MARK Title
            HStack{
                Text("Pix Pro Baseball")
                    .bold()
                    .foregroundColor(Color.textColor)
                
                Spacer()
                
                HStack{
                    //MARK Hall of Fame button
                    NavigationLink(destination: HallOfFameView()){
                        Text("HOF")
                        
                    }
                    //MARK All Players button
                    NavigationLink(destination: PlayerList(seasonYear: LeagueViewModel.ALL_TIME, teamId: LeagueViewModel.ALL_TIME)){
                        Text("All Players")
                    }
                    //Mark All Time Teams button
                    NavigationLink(destination: TeamListView()) {
                        Text("All Time Teams")
                    }
                }
                .buttonStyle(.bordered)
                .foregroundColor(Color.iconColor)
            }
            .padding(.bottom)
            
            //MARK Seasons List
            SeasonsList()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(Color.rowColor)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: Color.primary.opacity(0.2), radius: 10, x: 0, y:5)
        .background(Color.backgroundColor)
        
        
        
        
        
    }
}


struct League_Previews: PreviewProvider {
    static let leagueListViewModel : LeagueViewModel = {
        let leagueListViewModel = LeagueViewModel()
        leagueListViewModel.league = leaguePreviewData
        return leagueListViewModel
    }()
    
    static var previews: some View {
        LeagueView()
            .environmentObject(leagueListViewModel)
    }
}

//
//  GameList.swift
//  PixProStats
//
//  Created by Isaiah Hernandez on 3/2/25.
//

import SwiftUI


struct GameList: View {
    var games: [Game] = []
    var label: String = ""
    @EnvironmentObject var leagueListVM: LeagueViewModel
    
    var body: some View {
        
        VStack{
            let teams: [Team] = leagueListVM.league?.teams ?? []
            //MARK Title
            HStack{
                Text(label)
                    .bold()
                    .foregroundColor(Color.textColor)
                
                Spacer()
                
            }
            .padding(.bottom)
            
            //Mark Game List
            ScrollView {
                ForEach(games){
                    game in
                    GameRow(game: game, teams: teams)
                    
                    Divider()
                }
            }
            .padding()
            .background(Color.rowColor)
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .shadow(color: Color.primary.opacity(0.2), radius: 10, x: 0, y:5)
            
            
        }
        .padding()
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: Color.primary.opacity(0.2), radius: 10, x: 0, y:5)
        .background(Color.backgroundColor)
        
    }
}


struct GameList_Previews: PreviewProvider {
    static let leagueListViewModel : LeagueViewModel = {
        let leagueListViewModel = LeagueViewModel()
        leagueListViewModel.league = leaguePreviewData
        return leagueListViewModel
    }()
    
    static var previews: some View {
        GameList(games: gameListPreviewData, label: "2023 Season")
            .environmentObject(leagueListViewModel)
    }
}

//
//  ContentView.swift
//  PixProStats
//
//  Created by Isaiah Hernandez on 3/4/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 10){
                    //MARK Title
                    Text("Pixel Pro Stats")
                        .font(.title2)
                        .bold()
                        .foregroundColor(Color.textColor)
                        .opacity(0.8)
                }
                .padding()
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                //MARK Seasons
                LeagueView()
            }
            .background(Color.backgroundColor)
            .navigationBarTitleDisplayMode(.inline)
            
        }
        .navigationViewStyle(.stack)
        .accentColor(Color.iconColor)
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static let leagueListViewModel : LeagueViewModel = {
        let leagueListViewModel = LeagueViewModel()
        leagueListViewModel.league = leaguePreviewData
        return leagueListViewModel
    }()
    
    static var previews: some View {
        ContentView()
            .environmentObject(leagueListViewModel)
        
    }
}

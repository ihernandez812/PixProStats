//
//  AllPlayersView.swift
//  PixProStats
//
//  Created by Isaiah Hernandez on 3/6/25.
//

import SwiftUI
import SwiftUIFontIcon

struct AllPlayersView: View {
    
    var body: some View {
        
        VStack{
            HStack{
                    Text("All Time Players")
                        .bold()
                Spacer()
                
            }
            .padding([.top, .bottom, .horizontal], 20)
            .foregroundColor(Color.textColor)
            .background(Color.rowColor)
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .shadow(color: Color.primary.opacity(0.2), radius: 10, x: 0, y:5)
            
            //MARK Seasons List
            PlayerList(seasonYear: LeagueViewModel.ALL_TIME, teamId: LeagueViewModel.ALL_TIME)
            
        }
        .padding()
        .background(Color.backgroundColor)
        
        
    }
}


struct AllPlayersView_Previews: PreviewProvider {

    static var previews: some View {
        AllPlayersView()
    }
}


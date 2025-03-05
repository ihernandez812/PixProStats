//
//  StatsListView.swift
//  PixProStats
//
//  Created by Isaiah Hernandez on 2/27/25.
//

import SwiftUI

struct StatsListView: View {
    var statsList: [(String, Int)]
    @EnvironmentObject var leagueListVM: LeagueViewModel
    
    var body: some View {
        ScrollView {
            VStack{
                //MARK Stats List view
                ForEach(statsList.indices, id: \.self){ i in
                    let stats: (String, Int) = statsList[i]
                    let statsName: String = stats.0
                    let statsValue: Int = stats.1
                    StatRow(statName: statsName, statValue: statsValue)
                    Divider()
                    
                }
            }
            
        }
        
    }
}


struct StatsListView_Previews: PreviewProvider {
    
    static var previews: some View {
        StatsListView(statsList: [("Home Runs", 140)])
    }
}

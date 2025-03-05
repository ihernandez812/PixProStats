//
//  CalculatedStatsView.swift
//  PixProStats
//
//  Created by Isaiah Hernandez on 2/27/25.
//

import SwiftUI


struct CalculatedStatsView: View {
    var statsList: [(String, Double)]
    @EnvironmentObject var leagueListVM: LeagueViewModel
    
    var body: some View {
        HStack{
            //MARK Calculated Stats
            ForEach(statsList.indices, id: \.self){ i in
                let stats: (String, Double) = statsList[i]
                let statsName: String = stats.0
                let statsValue: Double = stats.1
                StatRow(statName: statsName, statValueDouble: statsValue, addSpacing: false)
                Spacer()
                
            }
        }
        .padding(.horizontal, 50)
        
        
        
    }
}


struct CalculatedStatsView_Previews: PreviewProvider {
    
    static var previews: some View {
        CalculatedStatsView(statsList: [("Home Runs", 0.369)])
    }
}

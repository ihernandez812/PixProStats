//
//  ScoreView.swift
//  PixProStats
//
//  Created by Isaiah Hernandez on 2/25/25.
//

import SwiftUI

struct ScoreView: View {
    
    var team : Team?
    var score : Int
    
    var body: some View {
        HStack{
            
            if let _team = team{
                
                
                Text(_team.name)
                    .font(.footnote)
                    .lineLimit(1)
                    .foregroundStyle(Color.textColor)
                Spacer()
                Text("\(score)")
                    .font(.subheadline)
                    .lineLimit(1)
                    .foregroundStyle(Color.textColor)
            }else{
                
                
                Text("TBD")
                    .padding(.vertical,5)
            }
        }
        
    }
}

#Preview {
    ScoreView(team: teamPreviewData, score: 3)
    
    
}

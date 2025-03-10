//
//  StatRow.swift
//  PixProStats
//
//  Created by Isaiah Hernandez on 2/26/25.
//

import Foundation
import SwiftUI


struct StatRow: View {
    var statName: String
    var statValue: Int?
    var statValueDouble: Double?
    var addSpacing: Bool = true
    var body: some View {
        
        HStack(spacing: 10) {
            VStack(alignment: .leading, spacing: 2){
                //MARK Season Year
                Text(statName)
                    .font(.subheadline)
                    .opacity(0.5)
                    .lineLimit(1)
                    .foregroundColor(Color.textColor)
                
                
                
            }
            
            if addSpacing {
                Spacer()
            }
            
            
            VStack(alignment: .leading, spacing: 2){
                if let statValueDouble = self.statValueDouble {
                    let formattedStat = statValueDouble.deleteLeadingZeros()
                    Text(formattedStat.addTrailingZeros(4))
                        .font(.subheadline)
                        .opacity(0.5)
                        .lineLimit(1)
                        .foregroundColor(Color.textColor)
                }
                else if let statValue = self.statValue{
                    Text(String(statValue))
                        .font(.subheadline)
                        .opacity(0.5)
                        .lineLimit(1)
                        .foregroundColor(Color.textColor)
                }
                
                
                
            }
        }
        .padding([.top, .bottom], 8)
        .padding(.horizontal, 16)
    }
}


struct StatRow_Previews: PreviewProvider {
    static var previews: some View {
        StatRow(statName: "Home Runs: ", statValue: 142, addSpacing: true)
    }
}

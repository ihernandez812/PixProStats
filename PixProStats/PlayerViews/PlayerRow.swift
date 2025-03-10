////
////  PlayerRow.swift
////  PixProStats
////
////  Created by Isaiah Hernandez on 2/21/25.
////
//
import Foundation
import SwiftUI
import SwiftUIFontIcon


struct PlayerRow: View {
    var player: Player
    var body: some View {
        HStack(spacing: 10) {
            VStack(alignment: .leading, spacing: 2){
                //MARK Player Name
                HStack{
                    Text(String(player.name))
                        .font(.headline)
                        .bold()
                        .lineLimit(1)
                    if(player.isHof){
                        VStack(alignment: .leading, spacing: 2){
                            //MARK HOF Badge
                            RoundedRectangle(cornerRadius: 20, style: .continuous)
                                .fill(Color.iconColor.opacity(0.3))
                                .frame(width: 15, height: 15)
                                .overlay{
                                    FontIcon.text(.awesome5Solid(code: .star), fontsize: 9, color: Color.iconColor)
                                }
                            
                            
                            
                        }
                    }
                }
                HStack {
                    let fullPosition: String = player.getFullPosition()
                    Text(String(fullPosition))
                        .font(.footnote)
                        .opacity(0.7)
                    
                    let handedness = player.getHandedness()
                    Text(String(handedness))
                        .font(.caption2)
                        .opacity(0.7)
                }
                
                
                
                
            }
            
            Spacer()
            
            
        }
        .padding([.top, .bottom], 1)
        .foregroundColor(Color.textColor)
    }
}


struct PlayerRow_Previews: PreviewProvider {
    static var previews: some View {
        PlayerRow(player: playerPreviewData)
    }
}

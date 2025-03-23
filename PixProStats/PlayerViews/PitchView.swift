//
//  PitchView.swift
//  PixProStats
//
//  Created by Isaiah Hernandez on 3/13/25.
//

import SwiftUI
import SwiftUIFontIcon


struct PitchView: View {
    let player: Player
    var body: some View {
        HStack{
            ForEach(player.pitchTypes.indices, id: \.self){
                i in
                let pitchType:PitchTypes = player.pitchTypes[i]
                ZStack{
                    Ball(color: pitchType.pitchColor)
                    let leftCount: Int = PitchTypes.pitchHorizontalCount(direction: -1, handedness: player.handedness, pitchType: pitchType)
                    let rightCount: Int = PitchTypes.pitchHorizontalCount(direction: 1, handedness: player.handedness, pitchType: pitchType)
                    let downCount: Int = PitchTypes.pitchVerticalCount(pitchType: pitchType)
                    if leftCount > 0 {
                        ForEach((1...leftCount), id: \.self){ i in
                            FontIcon.text(.awesome5Solid(code: .chevron_left), fontsize: 7, color: Color.iconColor)
                                
                                .offset(x: CGFloat(Double(i)+0.5) * -5)
                        }
                    }
                    if rightCount > 0 {
                        ForEach((1...rightCount), id: \.self){ i in
                            FontIcon.text(.awesome5Solid(code: .chevron_right), fontsize: 7, color: Color.iconColor)
                                .offset(x: CGFloat(Double(i)+0.5) * 5)
                        }
                    }
                    if downCount > 0{
                        ForEach((1...downCount), id: \.self){ i in
                            FontIcon.text(.awesome5Solid(code: .chevron_down), fontsize: 7, color: Color.iconColor)
                                .offset(y: CGFloat(Double(i)+0.5) * 5)
                        }
                    }
                }
                .padding(.horizontal, 5)
                
                
            }
        }
    }
}

#Preview {
    PitchView(player: playerPreviewData)
}

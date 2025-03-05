//
//  LineView.swift
//  PixProStats
//
//  Created by Isaiah Hernandez on 2/25/25.
//

import SwiftUI

struct SleepingLine: View {
    var body: some View {
        Rectangle()
            .frame(width: 25,height: 1)
    }
}

struct StandingLine: View {
    var height : CGFloat = 60
    
    var body: some View {
        Rectangle()
            .frame(width: 1,height: height)
    }
}




#Preview {
    SleepingLine()
}

#Preview {
    StandingLine()
}

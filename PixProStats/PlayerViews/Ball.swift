//
//  Ball.swift
//  PixProStats
//
//  Created by Isaiah Hernandez on 3/13/25.
//

import SwiftUI

struct Ball: View {
    let color: Color
    var body: some View {
        Circle()
            .fill(color)
            .frame(width: 7, height: 7)
    }
}

#Preview {
    Ball(color: .red)
}

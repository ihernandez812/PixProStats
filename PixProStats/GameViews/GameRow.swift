////
////  GameRow.swift
////  PixProStats
////
////  Created by Isaiah Hernandez on 2/21/25.
////
//
import SwiftUI

struct GameRow: View {
    var game: Game
    var teams: [Team]
    var body: some View {
        HStack(spacing: 20) {
            let teamOne = game.teamOne
            let teamTwo = game.teamTwo
            
            let teamOneName: String = teams.first(where: { $0.id == teamOne })?.name ?? "Unknown"
            let teamTwoName: String = teams.first(where: { $0.id == teamTwo })?.name ?? "Unknown"
            //MARK Team One Name
            Text(teamOneName)
                .font(.title2)
                .lineLimit(1)
                .frame(width: 200)
            Spacer()
            //MARK Scores
            Text("\(game.teamOneScore) : \(game.teamTwoScore)")
                .font(.title3)
                .bold()
                .lineLimit(1)
            Spacer()
            //MARK Team Two Name
            Text(teamTwoName)
                .font(.title2)
                .lineLimit(1)
                .frame(width: 200)
            
        }
        .foregroundColor(Color.textColor)
        .padding([.top, .bottom], 8)
    }
}


struct GameRow_Previews: PreviewProvider {
    static var previews: some View {
        GameRow(game: gamePreviewData, teams: teamListPreviewData)
    }
}

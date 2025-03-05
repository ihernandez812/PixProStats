//
//  SeasonRow.swift
//  PixProStats
//
//  Created by Isaiah Hernandez on 2/21/25.
//
//
import SwiftUI

struct SeasonRow: View {
    var season: Season
    var teams: [Team]
    var body: some View {
        HStack(spacing: 10) {
            VStack(alignment: .leading, spacing: 2){
                //MARK Season Year
                Text("Year: " + String(season.getYear()))
                    .font(.subheadline)
                    .bold()
                    .lineLimit(1)
                    .foregroundColor(Color.textColor)
                
                //MARK Season Length
                let teamGameCount: Int = season.teamRecords.first?.value.gamesPlayed ?? 0
                Text("Games: " + String(teamGameCount))
                    .font(.footnote)
                    .opacity(0.7)
                    .lineLimit(1)
                
            }
            .foregroundColor(Color.textColor)
            
            Spacer()
            VStack(alignment: .leading, spacing: 2){
                Text("World Series")
                    .font(.caption)
                    .bold()
                    .lineLimit(1)
                    .foregroundColor(Color.textColor)
                
                // MARK World Series Matchup
                let worldSeriesTeamIds = season.getWorldSeriesIdsList()
                let teamOne = worldSeriesTeamIds[0]
                let teamTwo = worldSeriesTeamIds[1]
                let teamOneName = teams.first(where: { $0.id == teamOne })?.name ?? "Unknown"
                let teamTwoName = teams.first(where: { $0.id == teamTwo })?.name ?? "Unknown"
                let worldSeriesMatchup: String = "\(teamOneName) vs \(teamTwoName)"
                Text(worldSeriesMatchup)
                    .font(.footnote)
                    .foregroundColor(Color.textColor)
                    .opacity(0.7)
            }
        }
        .padding([.top, .bottom], 8)
        .foregroundColor(Color.textColor)
    }
}





struct SeasonRow_Previews: PreviewProvider {
    static var previews: some View {
        SeasonRow(season: seasonPreviewData, teams: teamListPreviewData)
    }
}

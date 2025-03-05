////
////  TeamRow.swift
////  PixProStats
////
////  Created by Isaiah Hernandez on 2/21/25.
////
//
import Foundation
import SwiftUI


struct TeamRow: View {
    var team: Team
    var season: Season?
    var record: Record?
    var body: some View {
        let teamRecord: Record = getTeamRecord()
        
        
        
        let gamesWon: Int = teamRecord.gamesWon
        let gamesLost: Int = teamRecord.gamesPlayed - gamesWon
        HStack(spacing: 10) {
            VStack(alignment: .leading, spacing: 2){
                //MARK Season Year
                Text(String(team.name))
                    .font(.headline)
                    .bold()
                    .lineLimit(1)
                //MARK Season Length
                
                let formatedRecord = "\(gamesWon)-\(gamesLost)"
                Text(formatedRecord)
                    .font(.caption)
                    .opacity(0.7)
                    .lineLimit(1)
                
            }
            
            Spacer()
            HStack{
                let formatedPercentageRecord = teamRecord.getFormatedPercentageRecord()
                VStack(alignment: .leading, spacing: 2){
                    Text(String(formatedPercentageRecord))
                        .font(.subheadline)
                        .lineLimit(1)
                    
                    
                }
                
                let seasonYear = season?.getYear() ?? LeagueViewModel.ALL_TIME
                NavigationLink(destination: TeamView(seasonYear: seasonYear, teamId: team.id)){
                    Text("Select")
                    
                }
                .buttonStyle(.bordered)
                .foregroundColor(Color.iconColor)
            }
            
        }
        .padding([.top, .bottom], 2)
        .foregroundColor(Color.textColor)
    }
    
    func getTeamRecord() -> Record {
        var teamRecord: Record?
        if record == nil {
            teamRecord = season?.getTeamRecordById(team.id)
        }
        else {
            teamRecord = record
        }
        
        return teamRecord ?? Record(gamesWon: 0, gamesPlayed: 0)
    }
}


struct TeamRow_Previews: PreviewProvider {
    static var previews: some View {
        TeamRow(team: teamPreviewData, season: seasonPreviewData)
    }
}

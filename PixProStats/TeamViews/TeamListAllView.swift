//
//  TeamListAllView.swift
//  PixProStats
//
//  Created by Isaiah Hernandez on 3/6/25.
//

import SwiftUI


struct TeamListAllView: View {
    var seasonYear: Int
    @EnvironmentObject var leagueVM: LeagueViewModel
    var body: some View {
        VStack{
            //MARK Teams List
            let conferences: [Conference] = leagueVM.league?.getConferences() ?? []
            ScrollView{
                if seasonYear == LeagueViewModel.ALL_TIME {
                    if let allTimeRecords: [Int: Record] = leagueVM.league?.getAllTimeRecords() {
                        let teams: [Team] = leagueVM.league?.teams ?? []
                        let orderedTeams: [Team] = teams.sorted {
                            allTimeRecords[$0.id]?.gamesWon ?? 0 > allTimeRecords[$1.id]?.gamesWon ?? 0
                        }
                        ForEach(orderedTeams){
                            team in
                            TeamRow(team: team, record: allTimeRecords[team.id])
                            
                            Divider()
                            
                        }
                    }
                }
                else {
                    if let season: Season = leagueVM.league?.getSeasonByYear(seasonYear: seasonYear) {
                        let teams: [Team] = leagueVM.league?.teams ?? []
                        let orderedTeams: [Team] = teams.sorted {
                            var teamOneWins: Int = season.getTeamRecordById($0.id).gamesWon
                            var teamTwoWins: Int = season.getTeamRecordById($1.id).gamesWon
                            if teamOneWins == teamTwoWins {
                                teamOneWins += season.getIsPlayoffTeam($0.id) ? 1 : 0
                                teamTwoWins += season.getIsPlayoffTeam($1.id) ? 1 : 0
                                            
                            }
                            return teamOneWins > teamTwoWins
                        }
                        ForEach(orderedTeams){
                            team in
                            let isPlayoffTeam = season.getIsPlayoffTeam(team.id)
                            TeamRow(team: team, season: season, isPlayoffTeam: isPlayoffTeam)

                            Divider()
                            
                        }
                    }
                }
                
            }
            .padding()
            .background(Color.rowColor)
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .shadow(color: Color.primary.opacity(0.2), radius: 10, x: 0, y:5)
            
        }
        
    }
}


struct TeamListAllView_Previews: PreviewProvider {
    static let leagueViewModel : LeagueViewModel = {
        let leagueViewModel = LeagueViewModel()
        leagueViewModel.league = leaguePreviewData
        return leagueViewModel
    }()
    
    static var previews: some View {
        TeamListAllView(seasonYear: 2023)
            .environmentObject(leagueViewModel)
    }
}


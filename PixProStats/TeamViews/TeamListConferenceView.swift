//
//  TeamListConferenceView.swift
//  PixProStats
//
//  Created by Isaiah Hernandez on 3/6/25.
//

import SwiftUI


struct TeamListConferenceView: View {
    var seasonYear: Int
    @EnvironmentObject var leagueVM: LeagueViewModel
    @State private var selectedConferenceId = LeagueViewModel.START_STATE
    
    
    var body: some View {
        VStack{
            //MARK Teams List
            let conferences: [Conference] = leagueVM.league?.getConferences() ?? []
            ScrollView{
                if seasonYear == LeagueViewModel.ALL_TIME {
                    if let allTimeRecords: [Int: Record] = leagueVM.league?.getAllTimeRecords() {
                        let teams: [Team] = leagueVM.league?.teams ?? []
                        let selectedConference: Conference = conferences[selectedConferenceId]
                            let conferenceTeams: [Team] = teams.filter({
                                for division in selectedConference.divisions {
                                    if division.teams.contains($0.id){
                                        return true
                                    }
                                }
                                return false
                            })
                            let orderedTeams: [Team] = conferenceTeams.sorted {
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
                        let selectedConference: Conference = conferences[selectedConferenceId]
                            let conferenceTeams: [Team] = teams.filter({
                                for division in selectedConference.divisions {
                                    if division.teams.contains($0.id){
                                        return true
                                    }
                                }
                                return false
                            })
                            let orderedTeams: [Team] = conferenceTeams.sorted {
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
            .gesture(DragGesture()
                .onEnded({ value in
                    if value.translation.width < 0 {
                        // left
                        handleDragEnded(1, conferences: conferences)
                    }
                    
                    if value.translation.width > 0 {
                        // right
                        handleDragEnded(-1, conferences: conferences)
                    }
                }))
            TabView(selection: $selectedConferenceId) {
                ForEach(conferences.indices, id: \.self) { i in
                    let conference = conferences[i]
                    Text(conference.id).tag(i)
                        .font(.caption)
                        .opacity(0.7)
                        .padding(.top, 15)
                        .foregroundColor(Color.textColor)
                    
                }
            }
            .tabViewStyle(PageTabViewStyle())
            .padding()
            .aspectRatio(1, contentMode: .fit)
            .frame(maxWidth: .infinity, maxHeight: 30)
        }
        
    }
    
    
    func handleDragEnded(_ direction: Int, conferences: [Conference]) {
        withAnimation {
            var conferenceIndex = selectedConferenceId
            conferenceIndex += direction
            if conferenceIndex < 0 {
                conferenceIndex = conferences.count - 1
            }
            else if conferenceIndex >= conferences.count {
                conferenceIndex = 0
                
            }
            selectedConferenceId = conferenceIndex
        }
    }
}


struct TeamListConferenceView_Previews: PreviewProvider {
    static let leagueViewModel : LeagueViewModel = {
        let leagueViewModel = LeagueViewModel()
        leagueViewModel.league = leaguePreviewData
        return leagueViewModel
    }()
    
    static var previews: some View {
        TeamListConferenceView(seasonYear: 2023)
            .environmentObject(leagueViewModel)
    }
}

//
//  TeamList.swift
//  PixProStats
//
//  Created by Isaiah Hernandez on 2/23/25.
//

import SwiftUI

struct TeamList: View {
    var seasonYear: Int
    @EnvironmentObject var leagueListVM: LeagueViewModel
    @State private var selectedDivisionId: String = "NL East"
    var body: some View {
        VStack{
            //MARK Teams List
            let divisions: [Division] = leagueListVM.league?.divisions ?? []
            ScrollView{
                if seasonYear == LeagueViewModel.ALL_TIME {
                    if let allTimeRecords: [Int: Record] = leagueListVM.league?.getAllTimeRecords() {
                        let teams: [Team] = leagueListVM.league?.teams ?? []
                        if let selectedDivision: Division = divisions.first(where: { $0.name == selectedDivisionId}) {
                            let divisionsTeams: [Team] = teams.filter({selectedDivision.teams.contains($0.id)})
                            let orderedTeams: [Team] = divisionsTeams.sorted {
                                allTimeRecords[$0.id]?.gamesWon ?? 0 > allTimeRecords[$1.id]?.gamesWon ?? 0
                            }
                            ForEach(orderedTeams){
                                team in
                                TeamRow(team: team, record: allTimeRecords[team.id])
                                
                                Divider()
                                
                            }
                            
                        }
                    }
                }
                else {
                    if let season: Season = leagueListVM.league?.getSeasonByYear(seasonYear: seasonYear) {
                        let teams: [Team] = leagueListVM.league?.teams ?? []
                        if let selectedDivision: Division = divisions.first(where: { $0.name == selectedDivisionId}) {
                            let divisionsTeams: [Team] = teams.filter({selectedDivision.teams.contains($0.id)})
                            let orderedTeams: [Team] = divisionsTeams.sorted { season.getTeamRecordById($0.id).gamesWon > season.getTeamRecordById($1.id).gamesWon }
                            ForEach(orderedTeams){
                                team in
                                //NavigationLink(destination: TeamView(seasonYear: season.getYear(), teamId: team.id)) {
                                TeamRow(team: team, season: season)
                                
                                //}
                                Divider()
                                
                            }
                            
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
                        handleDragEnded(1, divisions: divisions)
                    }
                    
                    if value.translation.width > 0 {
                        // right
                        handleDragEnded(-1, divisions: divisions)
                    }
                }))
            TabView(selection: $selectedDivisionId) {
                ForEach(divisions) { division in
                    Text(selectedDivisionId).tag(division.name)
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
    
    
    func handleDragEnded(_ direction: Int, divisions: [Division]) {
        withAnimation {
            var divisionIndex = divisions.firstIndex(where: { $0.name == selectedDivisionId }) ?? 0
            divisionIndex += direction
            if divisionIndex < 0 {
                divisionIndex = divisions.count - 1
            }
            else if divisionIndex >= divisions.count {
                divisionIndex = 0
                
            }
            selectedDivisionId = divisions[divisionIndex].name
        }
    }
}


struct TeamList_Previews: PreviewProvider {
    static let leagueListViewModel : LeagueViewModel = {
        let leagueListViewModel = LeagueViewModel()
        leagueListViewModel.league = leaguePreviewData
        return leagueListViewModel
    }()
    
    static var previews: some View {
        TeamList(seasonYear: 2023)
            .environmentObject(leagueListViewModel)
    }
}

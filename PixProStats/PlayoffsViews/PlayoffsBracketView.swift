//
//  PlayoffsBracketView.swift
//  PixProStats
//
//  Created by Isaiah Hernandez on 2/25/25.
//

import SwiftUI




public struct PlayoffsBracketView: View {
    
    var seasonYear: Int
    @EnvironmentObject var leagueVM: LeagueViewModel
    let columnWidth: CGFloat = UIScreen.main.bounds.width * 0.9
    @State var focusedColumnIndex : Int = 0
    @State var offsetX : CGFloat = 0
    
    
    
    var drag : some Gesture{
        DragGesture()
            .onChanged{value in
                offsetX = value.translation.width - CGFloat(focusedColumnIndex) * columnWidth
            }
            .onEnded(handleDragEnded)
    }
    
    public var body: some View {
        ScrollViewReader{
            scrollViewProxy in
            ScrollView(.vertical){
                VStack(spacing : 0){
                    Group{}.id("scroll-to-top-view")
                    ScrollView(.horizontal) {
                        let teams: [Team] = leagueVM.league?.teams ?? []
                        if let season: Season = leagueVM.league?.getSeasonByYear(seasonYear: seasonYear) {
                            //MARK Wild
                            HStack(alignment : .top,spacing : 0){
                                BracketListView(
                                    seriesList: [
                                        season.playoffs.alWildcard,
                                        season.playoffs.alWildcard,
                                        season.playoffs.alWildcard,
                                        season.playoffs.alWildcard,
                                        season.playoffs.alWildcard,
                                        season.playoffs.alWildcard,
                                        season.playoffs.alWildcard,
                                        season.playoffs.nlWildcard
                                    ],
                                    teams: teams,
                                    column: 0,
                                    focusedColumn: focusedColumnIndex,
                                    isLastColumn: false,
                                    isFirstColumn: true,
                                    indicesToSkip: [1,2,3,4,5,6],
                                    indicesWithSeriesSet: []
                                )
                                
                                BracketListView(
                                    seriesList: [
                                        season.playoffs.alDivisionalOne,
                                        season.playoffs.alDivisionalTwo,
                                        season.playoffs.nlDivisionalTwo,
                                        season.playoffs
                                            .nlDivisionalOne
                                    ],
                                    teams: teams,
                                    column: 1,
                                    focusedColumn: focusedColumnIndex,
                                    isLastColumn: false,
                                    isFirstColumn: false,
                                    indicesToSkip: [],
                                    indicesWithSeriesSet: [1,2]
                                )
                                BracketListView(
                                    seriesList: [
                                        season.playoffs.alChampionship,
                                        season.playoffs.nlChampionship
                                    ],
                                    teams: teams,
                                    column: 2,
                                    focusedColumn: focusedColumnIndex,
                                    isLastColumn: false,
                                    isFirstColumn: false,
                                    indicesToSkip: [],
                                    indicesWithSeriesSet: []
                                )
                                BracketListView(
                                    seriesList: [season.playoffs.worldSeries],
                                    teams: teams,
                                    column: 3,
                                    focusedColumn: focusedColumnIndex,
                                    isLastColumn: true,
                                    isFirstColumn: false,
                                    indicesToSkip: [],
                                    indicesWithSeriesSet: []
                                )
                                
                            }
                            .offset(x : offsetX)
                            .animation(.easeInOut,value: offsetX)
                            .scrollTargetLayout()
                        }
                        
                    }
                    .scrollDisabled(false)
                    .scrollTargetBehavior(.viewAligned)
                    .scrollIndicators(.hidden)
                    .contentMargins(15, for: .scrollContent)
                }
            }
            .onChange(of: focusedColumnIndex) { oldValue, newValue in
                scrollViewProxy.scrollTo("scroll-to-top-view",anchor: .top)
            }
            
        }
        .background(Color.backgroundColor)
    }
    
    private func handleDragEnded(_ gestureValue : DragGesture.Value){
        let threshold: CGFloat = 10
        if gestureValue.translation.width < -threshold{
            moveToNextColumn()
        }else if gestureValue.translation.width > threshold{
            moveToPrevColumn()
        }else{
            offsetX = -CGFloat(focusedColumnIndex) * columnWidth
        }
    }
    
    private func moveToNextColumn(_ steps : Int = 1){
        focusedColumnIndex += steps
        offsetX = -CGFloat(focusedColumnIndex) * columnWidth
    }
    
    private func moveToPrevColumn(_ steps : Int = 1){
        focusedColumnIndex -= steps
        offsetX = -CGFloat(focusedColumnIndex) * columnWidth
    }
}


struct PlayoffsBracketView_Previews: PreviewProvider {
    static let leagueViewModel : LeagueViewModel = {
        let leagueViewModel = LeagueViewModel()
        leagueViewModel.league = leaguePreviewData
        return leagueViewModel
    }()
    static var previews: some View {
        PlayoffsBracketView(seasonYear: 2023)
            .environmentObject(leagueViewModel)
    }
}


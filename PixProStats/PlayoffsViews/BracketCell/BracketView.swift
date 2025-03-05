//
//  BracketView.swift
//  PixProStats
//
//  Created by Isaiah Hernandez on 2/25/25.
//

import SwiftUI

struct BracketView: View {
    
    var series : Series
    var teams: [Team]
    var isLastColumn : Bool
    var isFirstColumn : Bool
    var heightExp : Int
    var isTopMatch : Bool
    var isCollapsed : Bool
    var shouldSkip : Bool
    var hideSleepLine : Bool
    
    init(series: Series, teams: [Team], isLastColumn: Bool, isFirstColumn: Bool, heightExp: Int, isTopMatch: Bool, isCollapsed: Bool, shouldSkip: Bool, hideSleepLine: Bool) {
        self.series = series
        self.teams = teams
        self.isLastColumn = isLastColumn
        self.isFirstColumn = isFirstColumn
        self.heightExp = heightExp
        self.isTopMatch = isTopMatch
        self.isCollapsed = isCollapsed
        self.shouldSkip = shouldSkip
        self.hideSleepLine = hideSleepLine
    }
    
    var BracketCellView : some View {
        HStack(spacing : 0){
            let opactity : Double = shouldSkip ? 0.0 : 1
            let sleepLineOpacity: Double = (shouldSkip || hideSleepLine) ? 0.0 : 1
            let backgroundColor : Color = (shouldSkip) ? Color.backgroundColor : Color.rowColor
            leftLineArea
                .opacity(sleepLineOpacity)
                .foregroundColor(Color.iconColor)
            
            VStack(alignment: .leading,spacing: 5) {
                
                if !isCollapsed{
                    //                    HStack{
                    //                        Spacer()
                    //                        Text(matchup.additionalInfo)
                    //                            .customFontStyle(theme.font)
                    //                    }
                }
                
                let seriesType = SeriesType.description(rawValue: series.seriesType)
                
                Text(seriesType)
                    .font(.caption2)
                
                let teamOneWinCount = series.getWinCountById(series.teamOne)
                let teamTwoWinCount = series.getWinCountById(series.teamTwo)
                let teamOne = teams.first(where: { $0.id == series.teamOne })
                let teamTwo = teams.first(where: { $0.id == series.teamTwo })
                ScoreView(team: teamOne, score: teamOneWinCount)
                    .opacity(opactity)
                
                if !isCollapsed{
                    ScoreView(team: teamTwo, score: teamTwoWinCount)
                        .opacity(opactity)
                }
                
            }
            .padding()
            .frame(width: 150,height: isCollapsed ? 25 : 62)
            .cornerRadiusStyle()
            .background(backgroundColor)
            .opacity(opactity)
            .foregroundColor(Color.iconColor)
            
            
            rightLineArea
                .opacity(opactity)
                .foregroundColor(Color.iconColor)
        }
        .frame(height: height)
        .transition(.opacity.combined(with: .scale(1, anchor: .top)))
    }
    
    var body: some View {
        let seriesName = SeriesType.description(rawValue: series.seriesType)
        if shouldSkip{
            BracketCellView
        }
        else{
            
            NavigationLink(destination: GameList(games: series.games, label: seriesName)){
                BracketCellView
            }
        }
        
    }
    
    private var height : CGFloat{
        let cellHeight : CGFloat =  37
        return cellHeight * pow(2, CGFloat(heightExp))
    }
    
    private var leftLineArea : some View{
        Group{
            if !isFirstColumn{
                SleepingLine()
            }else{
                Spacer()
            }
        }
    }
    
    private var rightLineArea : some View{
        Group{
            if !isLastColumn{
                rightLine
            }else{
                Spacer()
                    .frame(width: UIScreen.main.bounds.width * 0.05,height: 2)
            }
        }
    }
    
    private var rightLine : some View{
        HStack(spacing : 0){
            SleepingLine()
            
            if isTopMatch{
                topMatchVerticalLine
            }else{
                bottomMatchVerticalLine
            }
        }
    }
    
    private var topMatchVerticalLine : some View{
        VStack(spacing: 0){
            Spacer()
                .frame(height: height/2 + height/3)
            Rectangle()
                .frame(width : 2,height: height/2 + height/3)
            
        }
    }
    
    private var bottomMatchVerticalLine : some View{
        VStack(spacing: 0){
            Rectangle()
                .frame(width : 2,height: height/2 + height/3)
            Spacer()
                .frame(height: height/2 + height/3)
        }
    }
    
}
#Preview {
    BracketView(series: seriesPreviewData, teams: teamListPreviewData, isLastColumn: false,isFirstColumn: true,heightExp: 0,isTopMatch: true,isCollapsed: false, shouldSkip: false, hideSleepLine: false)
}

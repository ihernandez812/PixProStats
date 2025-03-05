//
//  BracketListView.swift
//  PixProStats
//
//  Created by Isaiah Hernandez on 2/25/25.
//

import SwiftUI

struct BracketListView: View {
    
    var seriesList : [Series]
    var teams: [Team]
    var column : Int
    var focusedColumn : Int
    var isLastColumn : Bool
    var isFirstColumn : Bool
    let cellHeight : CGFloat = 10
    var indicesToSkip: [Int] = []
    var indicesWithSeriesSet: [Int] = []
    
    
    
    init(seriesList: [Series], teams: [Team], column : Int,focusedColumn : Int,isLastColumn: Bool, isFirstColumn: Bool, indicesToSkip: [Int], indicesWithSeriesSet: [Int]) {
        self.seriesList = seriesList
        self.teams = teams
        self.column = column
        self.focusedColumn = focusedColumn
        self.isLastColumn = isLastColumn
        self.isFirstColumn = isFirstColumn
        self.indicesToSkip = indicesToSkip
        self.indicesWithSeriesSet = indicesWithSeriesSet
    }
    
    var body: some View {
        VStack(spacing : 0){
            ForEach(self.seriesList.indices, id: \.self) { i in
                let series = self.seriesList[i]
                BracketView(series: series,
                            teams: teams,
                            isLastColumn: isLastColumn,
                            isFirstColumn: isFirstColumn,
                            heightExp: column - focusedColumn,
                            isTopMatch: isTopMatch(i),
                            isCollapsed: false,
                            shouldSkip: self.indicesToSkip.contains(i),
                            hideSleepLine: self.indicesWithSeriesSet.contains(i)
                )
                
                
            }
        }
        
    }
    
    
    func isTopMatch(_ index : Int) -> Bool{
        if index % 2 == 0{
            return true
        }else{
            return false
        }
    }
}

#Preview {
    BracketListView(seriesList: seriesListPreviewData, teams: teamListPreviewData, column: 0, focusedColumn: 0, isLastColumn: false, isFirstColumn: true, indicesToSkip: [], indicesWithSeriesSet: [])
    
}

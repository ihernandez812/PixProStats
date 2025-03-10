//
//  PixProStatsApp.swift
//  PixProStats
//
//  Created by Isaiah Hernandez on 3/4/24.
//

import SwiftUI

@main
struct PixProStatsApp: App {
    @StateObject var leagueVM = LeagueViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(leagueVM)
        }
    }
}

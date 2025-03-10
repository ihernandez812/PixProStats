//
//  Award.swift
//  PixProStats
//
//  Created by Isaiah Hernandez on 2/22/25.
//

import Foundation

// MARK: - Awards
struct Awards: Codable {
    let cyYoung, mvp, battingTitle, homeRunLeader: String
    
    enum CodingKeys: String, CodingKey {
        case cyYoung = "cy_young"
        case mvp
        case battingTitle = "batting_title"
        case homeRunLeader = "home_run_leader"
    }
}

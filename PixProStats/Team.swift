//
//  Team.swift
//  PixProStats
//
//  Created by Isaiah Hernandez on 2/22/25.
//

import Foundation

// MARK: - Team
struct Team: Codable, Identifiable {
    let name: String
    let id: Int
    let isUserTeam: Bool
    
    enum CodingKeys: String, CodingKey {
        case name, id
        case isUserTeam
    }
}

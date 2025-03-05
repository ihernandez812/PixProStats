//
//  Division.swift
//  PixProStats
//
//  Created by Isaiah Hernandez on 3/1/25.
//

import Foundation

struct Division: Codable, Identifiable {
    let id: String
    let name: String
    let teams: [Int]
    let conference: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case teams
        case conference
    }
}

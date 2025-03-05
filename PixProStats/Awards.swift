//
//  Award.swift
//  PixProStats
//
//  Created by Isaiah Hernandez on 2/22/25.
//

import Foundation

// MARK: - Awards
struct Awards: Codable {
    let cyYoung, mvp: String
    
    enum CodingKeys: String, CodingKey {
        case cyYoung = "cy_young"
        case mvp
    }
}

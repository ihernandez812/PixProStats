//
//  Record.swift
//  PixProStats
//
//  Created by Isaiah Hernandez on 2/22/25.
//

import Foundation


// MARK: - Record
struct Record: Codable {
let gamesWon, gamesPlayed: Int

enum CodingKeys: String, CodingKey {
    case gamesWon
    case gamesPlayed
}

func getFormatedPercentageRecord() -> String {
    let percentageRecord = Double(gamesWon) / Double(gamesPlayed)
    let roundedRecord = Double(round(1000 * percentageRecord) / 1000)
    
    let percentageString = roundedRecord.deleteLeadingZeros()
    return percentageString.addTrailingZeros(4)

}
}

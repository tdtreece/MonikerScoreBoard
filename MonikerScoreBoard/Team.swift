//
//  Team.swift
//  MonikerScoreBoard
//
//  Created by Taylor Treece on 5/14/23.
//

import Foundation

struct Team: Identifiable {
    var id = UUID()
    let teamName: String
    var teamScore: Int
    var roundScores = [Int]()
    
    mutating func addScore(value: Int) {
        teamScore += value
    }
}

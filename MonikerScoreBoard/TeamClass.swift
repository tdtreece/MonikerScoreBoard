//
//  TeamClass.swift
//  MonikerScoreBoard
//
//  Created by Taylor Treece on 5/14/23.
//

import Foundation

class Teams: ObservableObject {
    @Published var teams = [Team]()
    
    func resetTeams() {
        teams = [Team]()
    }
}

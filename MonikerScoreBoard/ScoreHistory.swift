//
//  ScoreHistory.swift
//  MonikerScoreBoard
//
//  Created by Taylor Treece on 5/21/23.
//

import SwiftUI

struct ScoreHistory: View {
    var teams: Teams
    
    var body: some View {
        NavigationView {
            List {
                ForEach(teams.teams.indices, id: \.self) { index in
                    let team = teams.teams[index]
                    let scoreText = team.roundScores.map { String($0) }.joined(separator: ", ")
                    HStack {
                        VStack {
                            Text(team.teamName)
                                .font(.headline)
                            Text(scoreText)
                        }
                        Spacer()
                        
                        VStack {
                            Text("Total Score")
                                .font(.headline)
                            let totalScore = team.teamScore
                            Text("\(totalScore)")
                        }
                    
                    }
                    
                }
            }
            .navigationTitle("Score History")
        }
        
    }
}



struct ScoreHistory_Previews: PreviewProvider {
   
    static var previews: some View {
        let newTeam = Team(teamName: "Testing Team", teamScore: 78, roundScores: [15, 20, 7, 14, 22])
        let newTeamTwo = Team(teamName: "Other Team", teamScore: 78, roundScores: [5, 22, 15, 16, 20])
        let teams = Teams()
        teams.teams.append(newTeam)
        teams.teams.append(newTeamTwo)
        
        return ScoreHistory(teams: teams)
    }
}

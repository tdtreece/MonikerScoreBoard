//
//  RoundScoreBoard.swift
//  MonikerScoreBoard
//
//  Created by Taylor Treece on 5/14/23.
//

import SwiftUI

struct RoundScoreBoard: View {
    @State private var scoreInputs: [String] = Array(repeating: "", count: 5)
    @State private var showHistory = false
    @State private var isShowingAlert = false
    @State private var isShowingDialog = false
    @State private var winningTeam: Team?
    @Environment(\.presentationMode) var presentationMode
    @State private var resetTeam = false
    var teams: Teams
    
    
    var body: some View {
        VStack {
            List {
                    Section("Add scores below") {
                        VStack {
                            ForEach(teams.teams.indices, id: \.self) { index in
                                let team = teams.teams[index]
                                HStack {
                                    Text(team.teamName)
                                    Spacer()
                                    Spacer()
                                    Spacer()
                                    TextField("Enter round points", text: $scoreInputs[index])
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                        .keyboardType(UIKeyboardType.numberPad)
                                }
                            }
                            HStack {
                                Button("Add Points") {
                                    for index in teams.teams.indices {
                                        if let scoreValue = Int(scoreInputs[index]) {
                                            teams.teams[index].addScore(value: scoreValue)
                                            teams.teams[index].roundScores.append(scoreValue)
                                            scoreInputs[index] = ""
                                            print(teams.teams)
                                            // add control logic for bad entries
                                        }
                                        
                                    }
                                    
                                }
                                .padding()
                                .frame(width: 125, height: 50)
                                .border(.blue)
                                Button("End Game", role: .destructive) {
                                   winningTeam = endGame()
                                   isShowingAlert = true
                                }
                                .buttonStyle(.bordered)
                                .controlSize(.large)
                                .alert(isPresented: $isShowingAlert) {
                                    if let teamName = winningTeam?.teamName {
                                        return Alert(
                                            title: Text("Game ended!"),
                                            message: Text("The winning team is \(teamName)!"),
                                            primaryButton: .default(Text("View Scores")) {
                                                showHistory = true
                                            },
                                            secondaryButton: .default(Text("New Game")) {
                                                self.presentationMode.wrappedValue.dismiss()
                                                teams.resetTeams()
                                            }
                                        )
                                    } else {
                                        return Alert(
                                            title: Text("Game ended!"),
                                            message: Text("No winning team found."),
                                            dismissButton: .default(Text("OK"))
                                        )
                                    }
                                }
                            }
                        }
                }
            }
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
                teams.resetTeams()
            }) {
                Text("New Game")
            }
            .tint(.green)
            .buttonStyle(.bordered)
            .buttonBorderShape(.automatic)
            
            
            .navigationTitle("Round Scoreboard")
            .toolbar {
                Button {
                    showHistory = true
                } label: {
                    Image(systemName: "menucard")
                }
            }
        }
        .sheet(isPresented: $showHistory) {
            ScoreHistory(teams: teams)
        }
        
    }
        
        
    func endGame() -> Team? {
        
        var winningTeam: Team?
        var maxScore = Int.min
        
        for team in teams.teams {
            if team.teamScore > maxScore {
                maxScore = team.teamScore
                winningTeam = team
            }
        }
        print("The winning team is \(winningTeam!.teamName)!")
        return winningTeam
//        isShowingAlert = true
    }
    
//    func handleEndGame() {
//        if let winningTeam = endGame() {
//            print("Winning team is: \(winningTeam)")
//        } else {
//            print("No teams found!")
//        }
//    }
}

struct RoundScoreBoard_Previews: PreviewProvider {
    static var previews: some View {
        let newTeam = Team(teamName: "Testing Team", teamScore: 0, roundScores: [15, 20, 7, 14, 22])
        let newTeamTwo = Team(teamName: "Other Team", teamScore: 0, roundScores: [5, 22, 15, 16, 20])
        let teams = Teams()
        teams.teams.append(newTeam)
        teams.teams.append(newTeamTwo)
        
        return RoundScoreBoard(teams: teams)
    }
}

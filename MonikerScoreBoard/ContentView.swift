//
//  ContentView.swift
//  MonikerScoreBoard
//
//  Created by Taylor Treece on 5/14/23.
//

import SwiftUI

struct ContentView: View {
    @State private var teamNameInput = ""
    @ObservedObject var teams = Teams()
    @State private var teamsBinding: Teams?
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 200/255, green: 179/255, blue: 117/255).ignoresSafeArea()
                VStack {
                    Text("MonikerScores")
                        .font(.largeTitle.weight(.bold))
                        .foregroundColor(.white)
                        .fontWeight(.heavy)
                        .fontDesign(.rounded)
                        .padding()
                        .shadow(radius: 50.0)
                    HStack {
                        Spacer()
                        TextField("Enter team name", text: $teamNameInput)
                            .padding()
                            .background(.white)
                        Button("Add Team") {
                            addTeam(newTeam: teamNameInput)
                            print(teams.teams)
                        }
                        .buttonStyle(.bordered)
                        .tint(.black)
                        .foregroundColor(.white)
                        .padding()
                        .fontDesign(.rounded)
                    }
                    Spacer()
                    Text("Current Teams")
                        .font(.title)
                        .foregroundColor(.white)
                        .underline()
                        .bold()
                        .fontDesign(.rounded)
                    
                    List {
                        ForEach(teams.teams) { team in
                            HStack {
                                Spacer()
                                Text("Team: \(team.teamName)")
                                    .bold()
                                Spacer()
                            }
                        }
                        .onDelete(perform: removeTeam)
                        
                        NavigationLink("Go to Round ScoreBoard", destination: RoundScoreBoard(teams: teams))
                            .fontDesign(.rounded)
                            .foregroundColor(.blue)
                            .opacity(teams.teams.count >= 2 ? 1: 0.5)
                            .disabled(teams.teams.count < 2)
                        
                    }
                    .listStyle(.plain)
                    .frame(width: 350)
                }
 
                    
                    
                }
            }
        }
    
        func addTeam(newTeam: String) {
            guard !teamNameInput.isEmpty else { return }
            let newTeam = Team(teamName: teamNameInput, teamScore: 0)
            teams.teams.append(newTeam)
            teamNameInput = ""
            print(teams)
        }
    
    func removeTeam(at offsets: IndexSet) {
        teams.teams.remove(atOffsets: offsets)
        }
    }
    
        
    
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }


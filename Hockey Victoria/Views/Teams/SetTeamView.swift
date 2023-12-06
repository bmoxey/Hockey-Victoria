//
//  SetTeamView.swift
//  Hockey Victoria
//
//  Created by Brett Moxey on 2/12/2023.
//

import SwiftUI
import SwiftData

struct SetTeamView: View {
    @Environment(\.modelContext) var context
    @EnvironmentObject private var sharedData: SharedData
    @Query (sort: \Teams.divType) var teams: [Teams]
    @Query(filter: #Predicate<Teams> {$0.isUsed}) var usedTeams: [Teams]
    @State private var showingConfirmation = false
    @State private var shouldShowNoDataView = false
    var body: some View {
        let currentTeam: Teams = teams.first(where: { $0.isCurrent }) ?? Teams(id: 1234, compName: "", compID: "", divName: "", divID: "", divLevel: "", divType: "", teamName: "", teamID: "", clubName: "SmallLogo", isCurrent: true, isUsed: false)
        let filteredTeams = usedTeams.filter { $0.teamID != currentTeam.teamID }
        NavigationStack {
            List {
                DetailTeamView(team: currentTeam)
                ForEach(filteredTeams) { team in
                    DetailTeamView(team: team)
                        .onTapGesture {
                            for index in 0 ..< teams.count {
                                teams[index].isCurrent = false
                            }
                            if let index = filteredTeams.firstIndex(of: team) {
                                filteredTeams[index].isCurrent = true
                                sharedData.refreshFixture = true
                                sharedData.refreshLadder = true
                                sharedData.refreshRound = true
                                sharedData.refreshStats = true
                                sharedData.activeTabIndex = 0
                            }
                        }
                    }
                .onDelete { indexSet in
                    for index in indexSet {
                        filteredTeams[index].isUsed = false
                    }
                }
            }
            .environment(\.defaultMinListRowHeight, 10)
            .shadow(radius: 5, x: 3, y: 2)
            .background(Color("LightColor"))
            .scrollContentBackground(.hidden)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text("Select team")
                            .foregroundStyle(Color.white)
                            .fontWeight(.semibold)
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink(destination: SelectClubView(isNavigationLink: true, isResetRefresh: true)) {
                        HStack {
                            Text("Add team")
                                .foregroundStyle(Color("AccentColor"))
                            Image(systemName: "chevron.right")
                                .foregroundStyle(Color("AccentColor"))
                                .font(Font.system(size: 17, weight: .semibold))
                                .frame(width: 20, height: 20)
                        }
                    }
                }
                ToolbarItem(placement: .topBarLeading) {
                    HStack {
                        VStack {
                            Image(systemName: "person.crop.circle.badge.questionmark.fill")
                                .symbolRenderingMode(.palette)
                                .foregroundStyle(Color.white, Color("AccentColor"))
                                .font(.title3)
                        }
                        Button(action: {
                            showingConfirmation = true
                        }, label: {
                            VStack {
                                Image(systemName: "arrow.counterclockwise.icloud")
                                    .symbolRenderingMode(.palette)
                                    .foregroundStyle(Color.white, Color("AccentColor"))
                                Text("Rebuild")
                                    .font(.system(size: 12))
                                    .foregroundStyle(Color.white)
                            }
                        })
                        .confirmationDialog("Are you sure?", isPresented: $showingConfirmation)
                        {
                            Button("Rebuild club/team lists from website?", role: .destructive) {
                                do {
                                    try context.delete(model: Teams.self)
                                    try context.save()
                                    try context.delete(model: Teams.self)
                                    try context.save()
                                    shouldShowNoDataView = true
                                } catch {
                                    print("failed to delete")
                                }
                                
                            }
                            .sheet(isPresented: $shouldShowNoDataView) {
                                ContentView()
                            }
                        } message: {
                            Text("This will delete all currently selected teams \n This process will take a minute.")
                        }
                    }
                }
            }
            .padding(.horizontal, -8)
            .toolbarBackground(Color("DarkColor"), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
        .accentColor(Color("AccentColor"))
    }
}

#Preview {
    SetTeamView()
}

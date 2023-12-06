//
//  StatisticsView.swift
//  Hockey Victoria
//
//  Created by Brett Moxey on 4/12/2023.
//

import SwiftUI
import SwiftData

struct StatisticsView: View {
    @Environment(\.modelContext) var context
    @EnvironmentObject private var sharedData: SharedData
    @Environment(\.colorScheme) var colorScheme
    @State private var errMsg = ""
    @State private var players = [Player]()
    @State private var sortedByName = true
    @State private var haveData = false
    @State private var sortedByNameValue: KeyPath<Player, String> = \Player.surname
    @State private var sortedByValue: KeyPath<Player, Int>? = nil
    @State private var sortAscending = true
    @State private var sortMode = 2
    @Query var teams: [Teams]
    var body: some View {
        let currentTeam: Teams = teams.first(where: { $0.isCurrent }) ?? Teams(id: 1234, compName: "", compID: "", divName: "", divID: "", divLevel: "", divType: "", teamName: "", teamID: "", clubName: "SmallLogo", isCurrent: true, isUsed: false)
        NavigationStack {
            VStack {
                if !haveData {
                    LoadingView()
                        .task { await myloadData() }
                } else {
                    if errMsg != "" {
                        ErrorMessage(errMsg: errMsg)
                    } else {
                        List {
                            Section(header: CenterSection(title: "\(currentTeam.teamName) Stats")) {
                                DetailHeaderStatsView(sortMode: $sortMode, sortAscending: $sortAscending, sortedByName: $sortedByName, sortedByNameValue: $sortedByNameValue, sortedByValue: $sortedByValue)
                                    .listRowBackground(Color("DarkColor"))
                                ForEach(players.sorted(by: sortDescriptor)) { player in
                                    NavigationLink(destination: PlayerStatsView(myTeam: currentTeam.teamName, myTeamID: currentTeam.teamID, myCompID: currentTeam.compID,  player: player)) {
                                        DetailStatsView(player: player)
                                    }
                                    .listRowBackground(Color.white)
                                    .overlay(
                                        Image(systemName: "chevron.right")
                                            .font(Font.system(size: 17, weight: .semibold))
                                            .foregroundColor(Color("AccentColor"))
                                            .frame(maxWidth: .infinity, alignment: .trailing)
                                            .padding(.horizontal, -8)
                                    )
                                }
                            }
                        }
                        .environment(\.defaultMinListRowHeight, 5)
                        .shadow(radius: 5, x: 3, y: 2)
                        .scrollContentBackground(.hidden)
                        .background(Color("LightColor"))
                        .padding(.horizontal, -8)
                        .refreshable {
                            sharedData.refreshStats = true
                        }
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(currentTeam.divName)
                        .foregroundStyle(Color.white)
                        .fontWeight(.semibold)
                }
                ToolbarItem(placement: .topBarLeading) {
                    VStack {
                        Image(systemName: "chart.bar.xaxis")
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(Color("AccentColor"), Color.white)
                            .font(.title3)
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Image(ShortClubName(fullName: currentTeam.teamName))
                        .resizable()
                        .frame(width: 45, height: 45)
                }
            }
            .toolbarBackground(Color("DarkColor"), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
        .onAppear() {
            if sharedData.refreshStats {
                haveData = false
            }
        }
        .accentColor(Color("AccentColor"))
    }
        
        
    private var sortDescriptor: (Player, Player) -> Bool {
        let ascending = sortAscending
        if let sortedByValue = sortedByValue {
            return { (player1, player2) in
                if ascending {
                    return player1[keyPath: sortedByValue] < player2[keyPath: sortedByValue]
                } else {
                    return player1[keyPath: sortedByValue] > player2[keyPath: sortedByValue]
                }
            }
        } else if sortedByName {
            return { (player1, player2) in
                if ascending {
                    return player1[keyPath: sortedByNameValue] < player2[keyPath: sortedByNameValue]
                } else {
                    return player1[keyPath: sortedByNameValue] > player2[keyPath: sortedByNameValue]
                }
            }
        } else {
            return { _, _ in true }
        }

    }
    func myloadData() async {
        let currentTeam: Teams = teams.first(where: { $0.isCurrent }) ?? Teams(id: 1234, compName: "", compID: "", divName: "", divID: "", divLevel: "", divType: "", teamName: "", teamID: "", clubName: "SmallLogo", isCurrent: true, isUsed: false)
        (players, errMsg) = GetStatsData(myCompID: currentTeam.compID, myTeamID: currentTeam.teamID)
        sharedData.refreshStats = false
        haveData = true
    }
}

#Preview {
    StatisticsView()
}

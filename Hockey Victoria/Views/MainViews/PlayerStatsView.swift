//
//  PlayerStatsView.swift
//  Hockey Victoria
//
//  Created by Brett Moxey on 4/12/2023.
//

import SwiftUI
import SwiftData

struct PlayerStatsView: View {
    @EnvironmentObject private var sharedData: SharedData
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.modelContext) var context
    @Query var teams: [Teams]
    @State var myTeam: String
    @State var myTeamID: String
    @State var myCompID: String
    @State var errMsg = ""
    @State private var haveData = false
    @State var myStats: [PlayerStat] = []
    @State var player: Player
    var body: some View {
        VStack {
            if !haveData {
                LoadingView()
                    .task { await myloadData() }
            } else {
                if errMsg != "" {
                    ErrorMessage(errMsg: errMsg)
                } else {
                    let uniqueTeamIDs = Array(Set(myStats.map {$0.teamID }))
                    List {
                        let filteredStats = myStats.filter { $0.teamID == myTeamID }
                        if !filteredStats.isEmpty {
                            Section(header: CenterSection(title: "Player Statistics")) {
                                HeaderTextView(text: filteredStats[0].divName)
                                ForEach(filteredStats) {playerStats in
                                    DetailPlayerStatsView(playerStat: playerStats)
                                        .listRowBackground(Color.white)
                                }
                            }
                        }
                        ForEach(uniqueTeamIDs, id: \.self) {uniqueTeamID in
                            if uniqueTeamID != myTeamID {
                            let filteredStats = myStats.filter { $0.teamID == uniqueTeamID }
                                if !filteredStats.isEmpty {
                                    Section() {
                                        HeaderTextView(text: filteredStats[0].divName)
                                        ForEach(filteredStats) {playerStats in
                                            DetailPlayerStatsView(playerStat: playerStats)
                                                .listRowBackground(Color.white)
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .environment(\.defaultMinListRowHeight, 5)
                    .shadow(radius: 5, x: 3, y: 2)
                    .scrollContentBackground(.hidden)
                    .background(Color("LightColor"))
                    .padding(.horizontal, -8)
                    .refreshable {
                        haveData = false
                    }
                }
            }
        }
        .onAppear {
            if sharedData.refreshStats{
                self.presentationMode.wrappedValue.dismiss()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                VStack {
                    Text(player.name)
                        .foregroundStyle(Color.white)
                        .fontWeight(.semibold)
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                Image(ShortClubName(fullName: myTeam))
                    .resizable()
                    .frame(width: 45, height: 45)
            }
        }
        .toolbarBackground(Color("DarkColor"), for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
    }
    
    func myloadData() async {
        (myStats, errMsg) = GetPlayerData(allTeams: teams, ourCompID: myCompID, ourTeam: myTeam, ourTeamID: myTeamID, myURL: player.statsLink)
        haveData = true
    }
    
}


#Preview {
    PlayerStatsView(myTeam: "MHSOB", myTeamID: "12345",  myCompID: "aaaa", player: Player(name: "Brett Moxey", numberGames: 0, goals: 5, greenCards: 1, yellowCards: 2, redCards: 0, goalie: 0, surname: "Moxey", captain: true, fillin: false, us: true, statsLink: ""))
}

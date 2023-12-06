//
//  FixtureView.swift
//  Hockey Victoria
//
//  Created by Brett Moxey on 3/12/2023.
//

import SwiftUI
import SwiftData

struct FixtureView: View {
    @Environment(\.modelContext) var context
    @EnvironmentObject private var sharedData: SharedData
    @State var haveData = false
    @State var errMsg = ""
    @State var fixtures = [Game]()
    @Query var teams: [Teams]
    var body: some View {
        let currentTeam: Teams = teams.first(where: { $0.isCurrent }) ?? Teams(id: 1234, compName: "", compID: "", divName: "", divID: "", divLevel: "", divType: "", teamName: "", teamID: "", clubName: "SmallLogo", isCurrent: true, isUsed: false)
        NavigationView {
            VStack {
                if !haveData {
                    LoadingView()
                } else {
                    if errMsg != "" {
                        ErrorMessage(errMsg: errMsg)
                    } else {
                        List {
                            ForEach(fixtures.indices, id:\.self) {index in
                                let game = fixtures[index]
                                let isWithinOneWeek = Date() < game.date && Calendar.current.date(byAdding: .weekOfYear, value: 1, to: Date()) ?? Date() >= game.date
                                Section(header: FirstSection(index: index, header: "Fixture")) {
                                    HeaderRoundDate(date: game.date, roundNo: game.roundNo, isFullDate: game.opponent == "Nobody" ? false : true)
                                    if game.opponent == "Nobody"{
                                        NoGameView(myTeam: currentTeam.teamName, game: game)
                                            .listRowBackground(isWithinOneWeek ? Color("CurrentColor") : Color.white.opacity(0.75))
                                    } else {
                                        NavigationLink(destination: GameView(gameID: game.gameID, myTeam: currentTeam.teamName)){
                                            if game.result == "No Game" {
                                                NoResultView(myTeam: currentTeam.teamName, game: game)
                                            } else {
                                                HaveResultView(myTeam: currentTeam.teamName, game: game)
                                            }
                                        }
                                        .overlay(
                                            Image(systemName: "chevron.right")
                                                .font(Font.system(size: 17, weight: .semibold))
                                                .foregroundColor(Color("AccentColor"))
                                                .frame(maxWidth: .infinity, alignment: .trailing)
                                                .padding(.horizontal, -8)
                                        )
                                        .listRowBackground(isWithinOneWeek ? Color("CurrentColor") : game.result == "" ? Color.white : Color.white.opacity(0.75))
                                    }
                                }
                            }
                        }
                        .environment(\.defaultMinListRowHeight, 10)
                        .shadow(radius: 5, x: 3, y: 2)
                        .scrollContentBackground(.hidden)
                        .background(Color("LightColor"))
                        .padding(.horizontal, -8)
                        .refreshable {
                            Task {
                                var currentRound = "Round 1"
                                haveData = false
                                (fixtures, currentRound, errMsg) = await GetFixtureData(mycompID: currentTeam.compID, myTeamID: currentTeam.teamID, myTeamName: currentTeam.teamName)
                                sharedData.currentRound = currentRound
                                haveData = true
                            }
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
                        Image(systemName: "calendar.badge.clock")
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(Color.white, Color("AccentColor"))
                            .font(.title3)
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Image(currentTeam.clubName)
                        .resizable()
                        .frame(width: 45, height: 45)
                }
                
            }
            .toolbarBackground(Color("DarkColor"), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
        .onAppear {
            Task {
                var currentRound = "Round 1"
                haveData = false
                (fixtures, currentRound, errMsg) = await GetFixtureData(mycompID: currentTeam.compID, myTeamID: currentTeam.teamID, myTeamName: currentTeam.teamName)
                sharedData.currentRound = currentRound
                haveData = true
                sharedData.refreshFixture = false
            }
        }
        .accentColor(Color("AccentColor"))
    }
}

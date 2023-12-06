//
//  GameView.swift
//  Hockey Victoria
//
//  Created by Brett Moxey on 4/12/2023.
//

import SwiftUI

struct GameView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject private var sharedData: SharedData
    @State var game: Game = Game()
    @State var games = [Game]()
    @State var gameID: String
    @State var myTeam: String
    @State var homePlayers = [Player]()
    @State var awayPlayers = [Player]()
    @State var haveData = false
    @State var errMsg = ""
    var body: some View {
        let isWithinOneWeek = Date() < game.date && Calendar.current.date(byAdding: .weekOfYear, value: 1, to: Date()) ?? Date() >= game.date
        VStack {
            if !haveData {
                LoadingView()
            } else {
                if errMsg != "" {
                    ErrorMessage(errMsg: errMsg)
                } else {
                    List {
                        Section(header: FirstSection(index: 0, header: "Game Details")) {
                            HeaderRoundDate(date: game.date, roundNo: game.roundNo, isFullDate: game.opponent == "Nobody" ? false : true)
                                .listRowBackground(Color("DarkColor"))
                                .frame(height: 10)
                            if game.result == "No Game" {
                                if game.homeTeam != myTeam && game.awayTeam != myTeam {
                                    DetailNoResultRoundView(myTeam: myTeam, round: game)
                                        .listRowBackground(isWithinOneWeek ? Color("ThisWeek") : Color.white)
                                } else {
                                    NoResultView(myTeam: myTeam, game: game)
                                        .listRowBackground(isWithinOneWeek ? Color("ThisWeek") : Color.white)
                                }
                            } else {
                                HaveResultView(myTeam: myTeam, game: game)
                                    .listRowBackground(isWithinOneWeek ? Color("ThisWeek") : Color.white.opacity(0.75))
                            }
                        }
                        if game.result == "No Game" {
                            DetailGroundView(round: game, myTeam: myTeam)
                                .listRowBackground(Color.white)
                        }
                        if !homePlayers.isEmpty {
                            Section(header: CenterSection(title: "Players")) {
                                HeaderTextView(text: game.homeTeam)
                                    .listRowBackground(Color("DarkColor"))
                                    .frame(height: 10)
                                ForEach(homePlayers.sorted { $0.surname < $1.surname }) { player in
                                    DetailPlayerView(player: player)
                                        .listRowBackground(Color.white)
                                }
                            }
                        }
                        if !awayPlayers.isEmpty {
                            Section(header: CenterSection(title: "Players")) {
                                HeaderTextView(text: game.awayTeam)
                                    .listRowBackground(Color("DarkColor"))
                                    .frame(height: 10)
                                ForEach(awayPlayers.sorted { $0.surname < $1.surname }) { player in
                                    DetailPlayerView(player: player)
                                        .listRowBackground(Color.white)
                                }
                            }
                        }
                        if !games.isEmpty {
                            ForEach(games.indices, id: \.self) { index in
                                let round = games[index]
                                Section(header: FirstSection(index: index, header: "Other matches")) {
                                    HeaderRoundDate(date: round.date, roundNo: round.roundNo, isFullDate: round.opponent == "Nobody" ? false : true)
                                        .listRowBackground(Color("DarkColor"))
                                        .frame(height: 10)
                                    if round.result == "No Game" {
                                        NoResultView(myTeam: myTeam, game: round)
                                            .listRowBackground(Color.white)
                                    } else {
                                        HaveResultView(myTeam: myTeam, game: round)
                                            .listRowBackground(Color.white.opacity(0.75))
                                    }
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
                            self.haveData = false
                            (game, homePlayers, awayPlayers, games, errMsg) = await GetGameData(gameID: gameID, myTeam: myTeam)
                            self.haveData = true
                        }
                    }
                }
            }
        }
        .onAppear {
            if sharedData.activeTabIndex == 0 && sharedData.refreshFixture {
                sharedData.refreshFixture = false
                self.presentationMode.wrappedValue.dismiss()
            }
            if sharedData.activeTabIndex == 2 && sharedData.refreshRound {
                sharedData.refreshRound = false
                self.presentationMode.wrappedValue.dismiss()
            }
            Task {
                self.haveData = false
                (game, homePlayers, awayPlayers, games, errMsg) = await GetGameData(gameID: gameID, myTeam: myTeam)
                self.haveData = true
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                VStack {
                    Text(game.roundNo)
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
}

#Preview {
    GameView(gameID: "1471439", myTeam: "Hawthorn")
}

//
//  LadderItemView.swift
//  Hockey Victoria
//
//  Created by Brett Moxey on 4/12/2023.
//

import SwiftUI
import SwiftData

struct LadderItemView: View {
    @Environment(\.modelContext) var context
    @EnvironmentObject private var sharedData: SharedData
    @Environment(\.presentationMode) var presentationMode
    @Query var teams: [Teams]
    @State var ladder: [LadderItem]
    @State var pos: Int
    @State var item: LadderItem?
    @State var haveData = false
    @State var errMsg = ""
    @State var games: [Game] = [Game]()
    @State var myTeam: Teams = Teams(id: 1, compName: "", compID: "", divName: "", divID: "", divLevel: "",divType: "",  teamName: "", teamID: "", clubName: "", isCurrent: false, isUsed: false)
    var maxGames: Int { ladder.map { $0.played + $0.byes }.max() ?? 0 }
    var maxGoals: Int { ladder.map { max($0.scoreFor, $0.scoreAgainst) }.max() ?? 0 }
    var body: some View {
        VStack {
            VStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(ladder, id: \.self) { item in
                            Image(ShortClubName(fullName: item.teamName))
                                .resizable()
                                .scaledToFit()
                                .containerRelativeFrame(.horizontal, count: 1, spacing: 0)
                                .shadow(radius: 5, y: 5)
                                .scrollTransition { content, phase in
                                    content
                                        .opacity(phase.isIdentity ? 1 : 0.5)
                                        .scaleEffect(phase.isIdentity ? 1 : 0.5)
                                        .blur(radius: phase.isIdentity ? 0 : 0.5)
                                        .saturation(phase.isIdentity ? 1 : 0.5)
                                }
                                .onTapGesture {
                                    self.item = item
                                }
                        }
                    }
                    .scrollTargetLayout()
                }
                .background(Color.white)
                .safeAreaPadding(.horizontal, CGFloat(UIScreen.main.bounds.width/3))
                .scrollTargetBehavior(.viewAligned)
                .scrollClipDisabled()
                .scrollPosition(id: $item, anchor: .center)
                .onAppear {
                    DispatchQueue.main.async {
                        scrollToElement(index: pos)
                    }
                }
                HStack {
                    Spacer()
                    if item != ladder.first {
                        Button {
                            withAnimation {
                                guard let item, let index = ladder.firstIndex(of: item),
                                      index > 0 else { return }
                                self.item = ladder[index - 1]
                            }
                        } label: {
                            Image(systemName: "chevron.left")
                                .foregroundStyle(Color("AccentColor"))
                                .font(Font.system(size: 17, weight: .semibold))
                        }
                    }
                    Spacer()
                    ForEach(ladder.indices, id:\.self) {index in
                        Circle()
                            .fill(Color("DarkColor").opacity(item?.teamName == ladder[index].teamName ? 0.7 : 0.2))
                            .frame(width:10, height:10)
                            .scaleEffect(item?.teamName == ladder[index].teamName ? 1.4 : 1)
                            .animation(.spring(), value: item?.teamName == ladder[index].teamName)
                    }
                    Spacer()
                    if item != ladder.last {
                        Button {
                            withAnimation {
                                guard let item, let index = ladder.firstIndex(of: item),
                                      index < ladder.count - 1 else { return }
                                self.item = ladder[index + 1]
                            }
                        } label: {
                            Image(systemName: "chevron.right")
                                .foregroundStyle(Color("AccentColor"))
                                .font(Font.system(size: 17, weight: .semibold))
                        }
                    }
                    Spacer()
                }
                .background(Color.white)
                List {
                    if item != nil {
                        DetailLadderItemView(item: item!, maxGames: maxGames, maxGoals: maxGoals)
                        if haveData {
                            if errMsg != "" {
                                ErrorMessage(errMsg: errMsg)
                            } else {
                                ForEach(games.indices, id:\.self) {index in
                                    let game = games[index]
                                    let isWithinOneWeek = Date() < game.date && Calendar.current.date(byAdding: .weekOfYear, value: 1, to: Date()) ?? Date() >= game.date
                                    Section(header: FirstSection(index: index, header: "Fixture")) {
                                        HeaderRoundDate(date: game.date, roundNo: game.roundNo, isFullDate: true)
                                            .listRowBackground(Color("DarkColor"))
                                            .frame(height: 10)
                                        if game.result == "No Game" {
                                            if game.opponent == "Nobody" {
                                                NoGameView(myTeam: myTeam.teamName, game: game)
                                                    .listRowBackground(isWithinOneWeek ? Color("CurrentColor") : Color.white.opacity(0.75))
                                            } else {
                                                NoResultView(myTeam: myTeam.teamName, game: game)
                                                    .listRowBackground(isWithinOneWeek ? Color("CurrentColor") : Color.white.opacity(0.75))
                                            }
                                        } else {
                                            HaveResultView(myTeam: myTeam.teamName, game: game)
                                                .listRowBackground(Color.white.opacity(0.75))
                                        }
                                    }
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
            }
            .background(Color.white)
        }
        .onAppear {
            if sharedData.refreshLadder {
                self.presentationMode.wrappedValue.dismiss()
            }
        }
        .onChange(of: item, {
            haveData = false
            Task(priority: .background) {
                let teamID = item?.teamID
                if let updatedTeam = teams.first(where: { $0.teamID == teamID }) {
                    myTeam = updatedTeam
                    try await Task.sleep(nanoseconds: 500_000_000)
                    haveData = false
                    (games, _, errMsg) = await GetFixtureData(mycompID: myTeam.compID, myTeamID: myTeam.teamID, myTeamName: myTeam.teamName)
                    haveData = true
                }
            }
        })
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("\(item?.teamName ?? "No Team")")
                    .foregroundStyle(Color.white)
                    .fontWeight(.semibold)
            }
            ToolbarItem(placement: .topBarTrailing) {
                Image(ShortClubName(fullName: item?.teamName ?? "SmallLogo"))
                    .resizable()
                    .frame(width: 45, height: 45)
            }
            
        }
        .toolbarBackground(Color("DarkColor"), for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
    }
    
    func scrollToElement(index: Int) {
        guard index < ladder.count else { return }
        DispatchQueue.main.async {
            item = ladder[index]
        }
    }
}

#Preview {
    LadderItemView(ladder: [LadderItem](), pos: 1)
}

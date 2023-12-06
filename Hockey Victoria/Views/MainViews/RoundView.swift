//
//  RoundView.swift
//  Hockey Victoria
//
//  Created by Brett Moxey on 5/12/2023.
//

import SwiftUI
import SwiftData

struct RoundView: View {
    @EnvironmentObject private var sharedData: SharedData
    @State var roundNames = [RoundNum]()
    @State var haveData = false
    @State var errMsg = ""
    @State var item: RoundNum?
    @Query var teams: [Teams]
    @State var games = [Game]()
    @State var byeTeams = [String]()
    var body: some View {
        let currentTeam: Teams = teams.first(where: { $0.isCurrent }) ?? Teams(id: 1234, compName: "", compID: "", divName: "", divID: "", divLevel: "", divType: "", teamName: "", teamID: "", clubName: "SmallLogo", isCurrent: true, isUsed: false)
        NavigationStack {
            VStack {
                if !haveData {
                    LoadingView()
                } else {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(roundNames, id: \.self) { item in
                                VStack {
                                    Text(item.text)
                                        .foregroundStyle(Color.white)
                                        .multilineTextAlignment(.center)
                                    Text(item.date)
                                        .foregroundColor(Color.gray)
                                        .multilineTextAlignment(.center)
                                        .font(.footnote)
                                }
                                .frame(width: 150, height: 100)
                                .background(Color("DarkColor"))
                                .cornerRadius(15.0)
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
                    .padding(.vertical, 4)
                    .scrollPosition(id: $item, anchor: .center)
                    HStack {
                        Spacer()
                        if item != roundNames.first {
                            Button {
                                withAnimation {
                                    guard let item, let index = roundNames.firstIndex(of: item),
                                          index > 0 else { return }
                                    self.item = roundNames[index - 1]
                                }
                            } label: {
                                Image(systemName: "chevron.left")
                                    .foregroundStyle(Color("AccentColor"))
                                    .font(Font.system(size: 17, weight: .semibold))
                            }
                        }
                        Spacer()
                        ForEach(roundNames.indices, id:\.self) {index in
                            Circle()
                                .fill(Color("DarkColor").opacity(item?.text == roundNames[index].text ? 0.7 : 0.2))
                                .frame(width:8, height:8)
                                .scaleEffect(item?.text == roundNames[index].text ? 1.4 : 1)
                                .animation(.spring(), value: item?.text == roundNames[index].text)
                        }
                        Spacer()
                        if item != roundNames.last {
                            Button {
                                withAnimation {
                                    guard let item, let index = roundNames.firstIndex(of: item),
                                          index < roundNames.count - 1 else { return }
                                    self.item = roundNames[index + 1]
                                }
                            } label: {
                                Image(systemName: "chevron.right")
                                    .foregroundStyle(Color("AccentColor"))
                                    .font(Font.system(size: 17, weight: .semibold))
                            }
                        }
                        Spacer()
                    }
                    List {
                        if item != nil {
                            if errMsg != "" {
                                ErrorMessage(errMsg: errMsg)
                            } else {
                                HeaderTextView(text: "\(item?.text ?? "") - \(item?.date.replacingOccurrences(of: "\n", with: ", ") ?? "")")
                                ForEach(games.indices, id:\.self) {index in
                                    let game = games[index]
                                    let isWithinOneWeek = Date() < game.date && Calendar.current.date(byAdding: .weekOfYear, value: 1, to: Date()) ?? Date() >= game.date
//                                    Section(header: FirstSection(index: index, header: "Fixture")) {
//                                        HeaderRoundDate(date: game.date, roundNo: game.roundNo, isFullDate: true)
//                                            .listRowBackground(Color("DarkColor"))
//                                            .frame(height: 10)
                                        if game.result == "No Game" {
                                            RoundNoResultView(myTeam: currentTeam.teamName, game: game)
                                                .listRowBackground(isWithinOneWeek ? Color("CurrentColor") : Color.white.opacity(0.75))
                                                .listRowSeparatorTint(Color("DarkColor"), edges: .all)
                                                .listRowSeparator(.visible, edges: .all)
                                        } else {
                                            RoundResultView(myTeam: currentTeam.teamName, game: game)
                                                .listRowBackground(Color.white.opacity(0.75))
                                                .listRowSeparatorTint(Color("DarkColor"), edges: .all)
                                                .listRowSeparator(.visible, edges: .all)
                                        }
//                                    }
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
            }
            .background(Color.white)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(currentTeam.divName)
                        .foregroundStyle(Color.white)
                        .fontWeight(.semibold)
                }
                ToolbarItem(placement: .topBarLeading) {
                    VStack {
                        Image(systemName: "clock.badge.fill")
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
                haveData = false
                (roundNames, errMsg) = await GetRoundsData(mycomp: currentTeam)
                if let round = roundNames.first(where: { $0.text == sharedData.currentRound }) {
                    scrollToElement(index: round.num)
                }
                haveData = true
            }
        }
        .onChange(of: item, {
            Task(priority: .background) {
                let url = item?.url
                try await Task.sleep(nanoseconds: 500_000_000)
                (games, byeTeams, errMsg) = await GetRoundData(myURL: url ?? "", myTeam: currentTeam)
            }
        })
    }
    func scrollToElement(index: Int) {
        guard index < roundNames.count else { return }
        DispatchQueue.main.async {
            item = roundNames[index]
        }
    }
}

#Preview {
    RoundView()
}

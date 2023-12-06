//
//  SelectTeamView.swift
//  Hockey Victoria
//
//  Created by Brett Moxey on 2/12/2023.
//

import SwiftUI
import SwiftData

struct SelectTeamView: View {
    @Environment(\.modelContext) var context
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject private var sharedData: SharedData
    var isNavigationLink: Bool
    @State var myClub: String
    @Query var teams: [Teams]
    var myTeams: [Teams] {
        return teams.filter { team in
            return team.clubName == myClub
        }
    }
    var mySortedTeams: [Teams] {
        return myTeams.sorted { (team1, team2) in
            if team1.divLevel == team2.divLevel {
                return team1.divName < team2.divName
            } else {
                return team1.divLevel < team2.divLevel
            }
        }
    }
    var body: some View {
        NavigationView {
            List {
                ForEach(Dictionary(grouping: mySortedTeams, by: { $0.divType }).sorted(by: { $0.key < $1.key }), id: \.key) { (divType, teamsGroupedByDivType) in
                    Section(header: HeaderDivType(divType: divType)) {
                        ForEach(Dictionary(grouping: teamsGroupedByDivType, by: { $0.compName }).sorted(by: { $0.key < $1.key }), id: \.key) { (compName, teamsGroupedByCompName) in
                            HeaderTextView(text: compName)
                            ForEach(teamsGroupedByCompName, id: \.self) { team in
                                VStack {
                                    HStack {
                                        Text(team.divName)
                                            .foregroundStyle(Color("DarkColor"))
                                        Spacer()
                                            .overlay(
                                                Image(systemName: "chevron.right")
                                                    .font(Font.system(size: 17, weight: .semibold))
                                                    .foregroundColor(Color("AccentColor"))
                                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                                    .padding(.horizontal, -8)
                                            )
                                    }
                                    
                                    if team.clubName != team.teamName {
                                        HStack {
                                            Text("competing as \(team.teamName)")
                                                .foregroundStyle(Color("DarkColor"))
                                                .font(.footnote)
                                            Spacer()
                                        }
                                    }
                                }
                                .listRowSeparator(.visible, edges: .all)
                                .onTapGesture {
                                    var count = 0
                                    for index in 0 ..< teams.count {
                                        if teams[index].isCurrent == true {
                                            count = count + 1
                                            teams[index].isCurrent = false
                                        }
                                    }
                                    team.isCurrent = true
                                    team.isUsed = true
                                    if count > 0 {
                                        sharedData.refreshFixture = true
                                        sharedData.refreshLadder = true
                                        sharedData.refreshRound = true
                                        sharedData.refreshStats = true
                                        sharedData.refreshTeams = true
                                        sharedData.activeTabIndex = 0
                                    }
                                }
                            }
                            .listRowSeparator(.visible, edges: .all)
                        }
                    }
                }
                .listRowBackground(Color.white)
            }
            .scrollContentBackground(.hidden)
            .background(Color("LightColor"))
            .environment(\.defaultMinListRowHeight, 10)
        }
        .onAppear {
            if isNavigationLink {
                if sharedData.refreshTeams {
                    self.presentationMode.wrappedValue.dismiss()
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Select your team")
                    .foregroundStyle(Color.white)
                    .fontWeight(.semibold)
            }
            ToolbarItem(placement: .topBarTrailing) {
                Image(myClub)
                    .resizable()
                    .frame(width: 45, height: 45)
            }
        }
        .toolbarBackground(Color("DarkColor"), for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
    }
}
#Preview {
    SelectTeamView(isNavigationLink: false, myClub: "MHSOB")
}

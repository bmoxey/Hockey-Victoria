//
//  LadderView.swift
//  Hockey Victoria
//
//  Created by Brett Moxey on 4/12/2023.
//

import SwiftUI
import SwiftData

struct LadderView: View {
    @Environment(\.modelContext) var context
    @EnvironmentObject private var sharedData: SharedData
    @Query var teams: [Teams]
    @State var haveData = false
    @State var errMsg = ""
    @State var ladder = [LadderItem]()
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
                            Section(header: CenterSection(title: "Ladder")) {
                                DetailLadderHeaderView()
                                    .listRowBackground(Color("DarkColor"))
                                ForEach(ladder.indices, id: \.self) { index in
                                    let item = ladder[index]
                                    NavigationLink(destination: LadderItemView(ladder: ladder, pos: index)) {
                                        DetailLadderView(myTeam: currentTeam.teamName, item: item)
                                    }
                                    .overlay(
                                        Image(systemName: "chevron.right")
                                            .font(Font.system(size: 17, weight: .semibold))
                                            .foregroundColor(Color("AccentColor"))
                                            .frame(maxWidth: .infinity, alignment: .trailing)
                                            .padding(.horizontal, -8)
                                    )
                                    .listRowBackground(Color.white)
                                    .listRowSeparatorTint( item.pos == 4 ? Color("DarkColor") : Color(UIColor.separator), edges: .all)
                                    .listRowSeparator(item.pos == 4 ? .visible : .automatic, edges: .all)
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
                                haveData = false
                                (ladder, errMsg) = GetLadderData(myCompID: currentTeam.compID, myDivID: currentTeam.divID, myTeam: currentTeam.teamName)
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
                        Image(systemName: "list.number")
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
        .onAppear() {
            Task {
                haveData = false
                (ladder, errMsg) = GetLadderData(myCompID: currentTeam.compID, myDivID: currentTeam.divID, myTeam: currentTeam.teamName)
                haveData = true
                sharedData.refreshLadder = false
            }
        }
        .accentColor(Color("AccentColor"))
    }
}

#Preview {
    LadderView()
}

//
//  SearchCompsView.swift
//  Hockey Victoria
//
//  Created by Brett Moxey on 2/12/2023.
//

import SwiftUI

struct SearchCompsView: View {
    @Environment(\.modelContext) var context
    var comps: [Competitions]
    var selectedWeek: Int
    @Binding var stillLoading: Bool
    @State private var searchComp: String = ""
    @State private var searchDiv: String = ""
    @State private var divsFound: Int = 0
    @State private var totalDivs: Int = 0
    @State private var teamsFound: Int = 0
    @State private var errMsg = ""
    
    var body: some View {
        ZStack {
            Color("DarkColor").ignoresSafeArea(.all, edges: .all)
            VStack {
                Spacer()
                Image("LightLogo")
                    .resizable()
                    .frame(width: 200, height: 73)
                Spacer()
                Text("Searching...")
                    .font(.largeTitle)
                    .foregroundStyle(Color("LightColor"))
                Spacer()
                Text(searchComp)
                    .foregroundStyle(Color("LightColor"))
                Text(searchDiv)
                    .foregroundStyle(Color("LightColor"))
                Text("Divisions searched: \(divsFound)")
                    .foregroundStyle(Color("LightColor"))
                Text("Teams found: \(teamsFound)")
                    .foregroundStyle(Color("LightColor"))
                ProgressView("Searching website for teams...",value: Double(divsFound), total: Double(totalDivs))
                    .foregroundStyle(Color("LightColor"))
                    .padding()
                Spacer()
                Spacer()
            }
        }
        .onAppear() {
            Task {
                await GetTeams()
            }
        }
    }
    func GetTeams() async {
        stillLoading = true
        var lines: [String] = []
        let selectedComps = comps.filter({ $0.isSelected })
        totalDivs = selectedComps.reduce(0) { count, selectedComp in
            return count + (selectedComp.items?.count ?? 0)
        }
        for selectedComp in selectedComps {
            if let items = selectedComp.items {
                for item in items {
                    searchComp = selectedComp.name
                    searchDiv = item.name
                    (lines, errMsg) = GetUrl(url: "\(url)games/\(selectedComp.nameID)/&r=\(selectedWeek)&d=\(item.nameID)")
                    divsFound += 1
                    for i in 0 ..< lines.count {
                        if lines[i].contains("\(url)teams") {
                            teamsFound += 1
                            let teamName = ShortTeamName(fullName: lines[i+1])
                            let teamID = String(String(lines[i].split(separator: "=")[2]).trimmingCharacters(in: .punctuationCharacters))
                            let clubName = ShortClubName(fullName: teamName)
                            let divLevel = GetDivLevel(fullString: item.name)
                            let divType = GetDivType(fullName: item.name)
                            let team = Teams(id: Int(teamID) ?? 0, compName: selectedComp.name, compID: selectedComp.nameID, divName: item.name, divID: item.nameID, divLevel: divLevel, divType: divType, teamName: teamName, teamID: teamID, clubName: clubName, isCurrent: false, isUsed: false)
                            context.insert(team)
                        }
                    }
                }
            }
        }
        stillLoading = false
    }
}

//#Preview {
//    SearchCompsView(comps: .constant([]), selectedWeek: .constant(1), stillSearching: .constant(true))
//}

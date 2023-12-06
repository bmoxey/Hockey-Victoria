//
//  ContentView.swift
//  Hockey Victoria
//
//  Created by Brett Moxey on 2/12/2023.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var context
    @StateObject var networkMonitor = NetworkMonitor()
    @Query var teams: [Teams]
    @State var stillLoading: Bool = false
    var body: some View {
        let currentTeam: Teams? = teams.first(where: { $0.isCurrent }) ?? Teams(id: 1234, compName: "", compID: "", divName: "", divID: "", divLevel: "", divType: "", teamName: "", teamID: "", clubName: "SmallLogo", isCurrent: true, isUsed: false)
        VStack {
            if !networkMonitor.isConnected {
                NoNetwork()
            } else {
                if teams.isEmpty || stillLoading {
                    GetCompsView(stillLoading: $stillLoading)
                } else {
                    if currentTeam?.clubName == "SmallLogo" {
                        SelectClubView(isNavigationLink: false, isResetRefresh: false)
                    } else {
                        MainTabView()
                    }
                }
                
            }
        }
        .onAppear { networkMonitor.start() }
        .onDisappear { networkMonitor.stop() }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Teams.self, inMemory: true)
}

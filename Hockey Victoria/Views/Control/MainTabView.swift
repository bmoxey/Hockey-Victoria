//
//  MainTabView.swift
//  Hockey Victoria
//
//  Created by Brett Moxey on 2/12/2023.
//

import SwiftUI

struct MainTabView: View {
    @StateObject private var sharedData = SharedData()
    var body: some View {
        TabView(selection: $sharedData.activeTabIndex) {
             FixtureView()
                 .onAppear { sharedData.activeTabIndex = 0 }
                 .environmentObject(sharedData)
                 .tabItem {
                     Image(systemName: "calendar.badge.clock")
                         .symbolRenderingMode(.palette)
                         .foregroundStyle(sharedData.activeTabIndex == 0 ? .white : .gray , sharedData.activeTabIndex == 0 ? .orange : .gray)
                     Text("Fixture") }
                 .tag(0)
                 .toolbarBackground(Color("DarkColor"), for: .tabBar)
                 .toolbarBackground(.visible, for: .tabBar)
             LadderView()
                 .onAppear {
                     sharedData.activeTabIndex = 1
                 }
                 .environmentObject(sharedData)
                 .tabItem {
                     Image(systemName: "list.number")
                         .symbolRenderingMode(.palette)
                         .foregroundStyle(sharedData.activeTabIndex == 1 ? .white : .gray , sharedData.activeTabIndex == 1 ? .orange : .gray)
                     Text("Ladder")
                 }
                 .tag(1)
                 .toolbarBackground(Color("DarkColor"), for: .tabBar)
                 .toolbarBackground(.visible, for: .tabBar)
//            Text("Round")
             RoundView()
                 .onAppear {
                     sharedData.activeTabIndex = 2
                 }
                 .environmentObject(sharedData)
                 .tabItem {
                     Image(systemName:  "clock.badge")
                         .symbolRenderingMode(.palette)
                         .foregroundStyle(sharedData.activeTabIndex == 2 ? .white : .gray , sharedData.activeTabIndex == 2 ? .orange : .gray)
                     Text("Round")
                 }
                 .tag(2)
                 .toolbarBackground(Color("DarkColor"), for: .tabBar)
                 .toolbarBackground(.visible, for: .tabBar)
             StatisticsView()
                 .onAppear {
                     sharedData.activeTabIndex = 3
                 }
                 .environmentObject(sharedData)
                 .tabItem {
                     Image(systemName: "chart.bar.xaxis")
                         .symbolRenderingMode(.palette)
                         .foregroundStyle(sharedData.activeTabIndex == 3 ? .orange : .gray, sharedData.activeTabIndex == 3 ? .white : .gray)
                     Text("Stats")
                 }
                 .tag(3)
                 .toolbarBackground(Color("DarkColor"), for: .tabBar)
                 .toolbarBackground(.visible, for: .tabBar)
             SetTeamView()
                 .onAppear {
                     sharedData.activeTabIndex = 4
                 }
                 .environmentObject(sharedData)
                 .tabItem {
                     Image(systemName: "person.crop.circle.badge.questionmark")
                         .symbolRenderingMode(.palette)
                         .foregroundStyle(sharedData.activeTabIndex == 4 ? .white : .gray, sharedData.activeTabIndex == 4 ? .orange : .gray)
                     Text("Teams")
                 }
                 .tag(4)
                 .toolbarBackground(Color("DarkColor"), for: .tabBar)
                 .toolbarBackground(.visible, for: .tabBar)
         }
        .accentColor(Color.white)
     }
 }
#Preview {
    MainTabView()
}

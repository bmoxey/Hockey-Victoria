//
//  Classes.swift
//  Hockey Victoria
//
//  Created by Brett Moxey on 2/12/2023.
//

import Foundation

class Competitions: Identifiable, ObservableObject {
    let id = UUID()
    let name: String
    let nameID: String
    @Published var isSelected: Bool
    var items: [Competitions]?
    
    init(name: String, nameID: String, isSelected: Bool, items: [Competitions]? = nil) {
        self.name = name
        self.nameID = nameID
        self.isSelected = isSelected
        self.items = items
    }
}

class SharedData: ObservableObject {
    @Published var activeTabIndex: Int = 0
    @Published var refreshFixture: Bool = false
    @Published var refreshSchedule: Bool = false
    @Published var refreshLadder: Bool = false
    @Published var refreshRound: Bool = false
    @Published var refreshStats: Bool = false
    @Published var refreshTeams: Bool = false
    @Published var currentRound: String = "Round 1"
}

//
//  Structs.swift
//  Hockey Victoria
//
//  Created by Brett Moxey on 3/12/2023.
//

import Foundation

struct Game: Codable, Identifiable {
    var id: UUID
    var roundNo: String
    var date: Date
    var field: String
    var venue: String
    var address: String
    var opponent: String
    var homeTeam: String
    var awayTeam: String
    var homeGoals: Int
    var awayGoals: Int
    var message: String
    var result: String
    var played: String
    var gameID: String
    
    init() {
        self.id = UUID()
        self.roundNo = ""
        self.date = Date()
        self.field = ""
        self.venue = ""
        self.address = ""
        self.opponent = ""
        self.homeTeam = ""
        self.awayTeam = ""
        self.homeGoals = 0
        self.awayGoals = 0
        self.message = ""
        self.result = ""
        self.played = ""
        self.gameID = ""
    }
}

struct Player: Identifiable {
    var id = UUID()
    var name: String
    var numberGames: Int
    var goals: Int
    var greenCards: Int
    var yellowCards: Int
    var redCards: Int
    var goalie: Int
    var surname: String
    var captain: Bool
    var fillin: Bool
    var us: Bool
    var statsLink: String
}

struct RoundNum: Hashable, Equatable {
    var num: Int
    var text: String
    var date: String
    var url: String
}
//    init(num: Int, text: String, date: String, url: String) {
//        self.num = 0
//        self.text = ""
//        self.date = ""
//        self.url = ""
//    }
//}

struct LadderItem: Hashable, Equatable {
    var pos: Int
    var teamName: String
    var compID: String
    var teamID: String
    var played: Int
    var wins: Int
    var draws: Int
    var losses: Int
    var forfeits: Int
    var byes: Int
    var scoreFor: Int
    var scoreAgainst: Int
    var diff: Int
    var points: Int
    var winRatio: Int
    
    init() {
        self.pos = 0
        self.teamName = ""
        self.compID = ""
        self.teamID = ""
        self.played = 0
        self.wins = 0
        self.draws = 0
        self.losses = 0
        self.forfeits = 0
        self.byes = 0
        self.scoreFor = 0
        self.scoreAgainst = 0
        self.diff = 0
        self.points = 0
        self.winRatio = 0
    }
}

struct PlayerStat: Identifiable {
    var id = UUID()
    var roundNo: String
    var dateTime: String
    var teamID: String
    var teamName: String
    var clubName: String
    var divName: String
    var goals: Int
    var greenCards: Int
    var yellowCards: Int
    var redCards: Int
    var goalie: Int
    var fillin: Bool
}

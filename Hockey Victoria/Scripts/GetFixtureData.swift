//
//  GetFixtureData.swift
//  Hockey Victoria
//
//  Created by Brett Moxey on 3/12/2023.
//

import Foundation

func GetFixtureData(mycompID: String, myTeamID: String, myTeamName: String) async -> ([Game], String, String) {
    var myGame = Game()
    var rounds = [Game]()
    var lines: [String] = []
    var errMsg = ""
    var FL = false
    var FF = false
    var score = ""
    var currentRound = "Round 1"
    var lastDate = Date()
    (lines, errMsg) = GetUrl(url: "\(url)teams/" + mycompID + "/&t=" + myTeamID)
    for i in 0 ..< lines.count {
        if lines[i].contains("There are no draws to show") {
            errMsg = "There are no draws to show"
        }
        if lines[i].contains("col-md pb-3 pb-lg-0 text-center text-md-left") {
            myGame.roundNo = lines[i+3]
            let dateTime = lines[i+6].trimmingCharacters(in: .whitespacesAndNewlines) + " " + lines[i+8].trimmingCharacters(in: .whitespacesAndNewlines)
            (myGame.message, myGame.date) = GetStart(inputDate: dateTime)
        }
        if lines[i].contains("\(url)venues") {
            myGame.venue = lines[i+1]
            myGame.field = lines[i+5]
        }
        if lines[i].contains("have a BYE.") {
            myGame.result = "BYE"
            myGame.opponent = "Nobody"
        }
        if lines[i].contains("\(url)teams/") {
            myGame.opponent = ShortTeamName(fullName: lines[i+1])
            score = lines[i+4]
            myGame.result = lines[i+8]
            if lines[i+6] == "FF" || lines[i+6] == "FL" {
                score = lines[i+8]
                myGame.result = lines[i+12]
            }
            (myGame.homeGoals, myGame.awayGoals) = GetScores(scores: score, seperator: "-")
            if myGame.result == "/div" { myGame.result = ""}
        }
        if lines[i].contains("badge badge-danger") && lines[i+1] == "FF" {FF = true}
        if lines[i].contains("badge badge-warning") && lines[i+1] == "FL" {FL = true}
        if lines[i].contains("\(url)game/") {
            if myGame.result != "" {
                (myGame.homeTeam, myGame.awayTeam) = GetHomeTeam(result: myGame.result, homeGoals: myGame.homeGoals, awayGoals: myGame.awayGoals, myTeam: myTeamName, opponent: myGame.opponent, rounds: rounds, venue: myGame.venue)
                if FL == true && myGame.result == "Loss" { myGame.result = "-FL" }
                if FL == true && myGame.result == "Win" { myGame.result = "+FL" }
                if FF == true && myGame.result == "Loss" { myGame.result = "-FF" }
                if FF == true && myGame.result == "Win" { myGame.result = "+FF" }
                currentRound = myGame.roundNo
            }
            myGame.gameID = String(String(lines[i]).split(separator: "/")[3])
            myGame.id = UUID()
            if !rounds.isEmpty {
                let weeksBetweenDates = weekDatesBetween(lastDate: lastDate, endDate: myGame.date)
                for date in weeksBetweenDates {
                    var blankEntry = Game()
                    blankEntry.id = UUID()
                    blankEntry.date = date
                    blankEntry.homeTeam = myTeamName
                    blankEntry.result = "No Game"
                    blankEntry.roundNo = "No Game"
                    blankEntry.opponent = "Nobody"
                    rounds.append(blankEntry)
                }
            }
            lastDate = myGame.date
            if myGame.result == "" { myGame.result = "No Game"}
            rounds.append(myGame)
            myGame = Game()
            FL = false
            FF = false
        }
    }
    return (rounds, currentRound, errMsg)
}

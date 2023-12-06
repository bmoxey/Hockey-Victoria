//
//  GetRoundData.swift
//  Hockey Victoria
//
//  Created by Brett Moxey on 6/12/2023.
//

import Foundation

func GetRoundData(myURL: String, myTeam: Teams) async -> ([Game], [String], String) {
    var lines = [String]()
    var errMsg = ""
    var byeTeams = [String]()
    var byes = false
    var myGame = Game()
    var games = [Game]()
    var scores = ""
    if myURL != "" {
        (lines, errMsg) = GetUrl(url: myURL)
        for i in 0 ..< lines.count {
            if lines[i].contains("BYEs") { byes = true }
            if lines[i].contains("col-md pb-3 pb-lg-0 text-center text-md-left") {
                let dateTime = lines[i+1].trimmingCharacters(in: .whitespacesAndNewlines) + " " + lines[i+3].trimmingCharacters(in: .whitespacesAndNewlines)
                (myGame.message, myGame.date) = GetStart(inputDate: dateTime)
            }
            if lines[i].contains("https://www.hockeyvictoria.org.au/venues/") {
                myGame.venue = lines[i+1]
                myGame.field = lines[i+5]
            }
            if lines[i].contains("https://www.hockeyvictoria.org.au/teams/") {
                if byes {
                    byeTeams.append(ShortTeamName(fullName: lines[i+1]))
                } else {
                    if myGame.homeTeam == "" {
                        myGame.homeTeam = ShortTeamName(fullName: lines[i+1])
                        scores = lines[i+5]
                        if scores == "FF" || scores == "FL" {
                            if scores == "FF" { myGame.message = "Forefeit"}
                            if scores == "FL" { myGame.message = "Forced Loss"}
                            scores = lines[i+12]
                        }
                        if lines[i+13] == "FF" { myGame.message = "Forefeit"}
                        if lines[i+13] == "FL" { myGame.message = "Forced Loss"}
                    } else {
                        if myGame.awayTeam == "" {
                            myGame.awayTeam = ShortTeamName(fullName: lines[i+1])
                            (myGame.homeGoals, myGame.awayGoals) = GetScores(scores: scores, seperator: "vs")
                            if scores == "/div" {
                                if myGame.message == "" { myGame.message = "No results available." }
                                myGame.result = "No Game"
                            } else {
                                if myGame.homeGoals == myGame.awayGoals {
                                    myGame.result = "drew with"
                                } else {
                                    if myGame.homeGoals > myGame.awayGoals {
                                        myGame.result = "defeated"
                                    } else {
                                        myGame.result = "lost to"
                                    }
                                }
                            }
                        }
                    }
                }
            }
            if lines[i].contains("https://www.hockeyvictoria.org.au/game/") {
                myGame.gameID = String(lines[i].split(separator: "/")[3])
                myGame.id = UUID()
                games.append(myGame)
                myGame = Game()
            }
        }
    }
    return (games, byeTeams, errMsg)
}

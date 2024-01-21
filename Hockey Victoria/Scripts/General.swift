//
//  General.swift
//  Hockey Victoria
//
//  Created by Brett Moxey on 2/12/2023.
//

import Foundation
import SwiftUI

func BarBackground(result: String) -> Color {
    switch result {
    case "Win":
        return Color.green
    case "+FF":
        return Color.mint
    case "+FL":
        return Color.mint
    case "Loss":
        return Color.red
    case "-FF":
        return Color.pink
    case "-FL":
        return Color.pink
    case "Draw":
        return Color.orange
    case "BYE":
        return Color.blue
    case "No Data":
        return Color.purple
    case "No Game":
        return Color.blue
    default:
        return Color.cyan
    }
}

func GetStart(inputDate: String?) -> (String, Date) {
    var message: String = ""
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "E dd MMM yyyy HH:mm"
    
    guard let inputDate = inputDate,
          let startDate = dateFormatter.date(from: inputDate) else {
        message = "Invalid date"
        return (message, Date())
    }
    return (message, startDate)
}

func GetScores(scores: String, seperator: String) -> (Int, Int) {
    var homeScore = 0
    var awayScore = 0
    if scores.contains(seperator) {
        let myScores = scores.components(separatedBy: seperator)
        homeScore = Int(myScores[0].trimmingCharacters(in: .whitespaces)) ?? 0
        awayScore = Int(myScores[1].trimmingCharacters(in: .whitespaces)) ?? 0
    }
    return (homeScore, awayScore)
}

func GetHomeTeam(result: String, homeGoals: Int, awayGoals: Int, myTeam: String, opponent: String, rounds: [Game], venue: String) -> (String, String) {
    var homeTeam = myTeam
    var awayTeam = ""
    if result == "Win" {
        if homeGoals > awayGoals {
            homeTeam = myTeam
            awayTeam = opponent
        } else {
            homeTeam = opponent
            awayTeam = myTeam
        }
    }
    if result == "Loss" {
        if homeGoals > awayGoals {
            homeTeam = opponent
            awayTeam = myTeam
        } else {
            homeTeam = myTeam
            awayTeam = opponent
        }
    }
    if result == "Draw" {
        let venueFrequency = rounds.reduce(into: [:]) { counts, round in
            counts[round.venue, default: 0] += 1
        }
        if let mostCommonVenue = venueFrequency.max(by: { $0.value < $1.value })?.key {
            if venue == mostCommonVenue {
                homeTeam = myTeam
                awayTeam = opponent
            } else {
                homeTeam = opponent
                awayTeam = myTeam
            }
        } else {
            homeTeam = opponent
            awayTeam = myTeam
        }
    }
    return (homeTeam, awayTeam)
}

func GetResult(myTeam: String, homeTeam: String, awayTeam: String, homeGoals: Int, awayGoals: Int) -> String {
    var result = ""
    if homeGoals == awayGoals { result = "Draw" }
    if homeTeam == myTeam && homeGoals > awayGoals {  result = "Win"}
    if homeTeam == myTeam && homeGoals < awayGoals {  result = "Loss"}
    if awayTeam == myTeam && homeGoals > awayGoals {  result = "Loss"}
    if awayTeam == myTeam && homeGoals < awayGoals {  result = "Win"}
    return result
}

func FixName(fullname: String) -> (String, String, Bool) {
    var myCap = false
    var myName = fullname
    if myName.contains(" (Captain)") {
        myCap = true
        myName = myName.replacingOccurrences(of: " (Captain)", with: "")
    }
    let mybits = myName.split(separator: ",")
    var surname = ""
    if mybits.count > 0 {
        surname = mybits[0].trimmingCharacters(in: .whitespaces).capitalized
        if surname.contains("'") {
            let mybits1 = surname.split(separator: "'")
            surname = mybits1[0].capitalized + "'" + mybits1[1].capitalized
        }
        let name = surname
        let surname = name.count >= 3 && name.lowercased().hasPrefix("mc") ? String(name.prefix(2)) + name[name.index(name.startIndex, offsetBy: 2)].uppercased() + String(name.suffix(from: name.index(after: name.index(name.startIndex, offsetBy: 2)))) : name
        if mybits.count > 1 {
            myName = mybits[1].trimmingCharacters(in: .whitespaces).capitalized + " " + surname
        }
    }
    return(myName, surname, myCap)
}

func GetRound(fullString: String) -> String {
    let newString = fullString.replacingOccurrences(of: "Round ", with: "R")
        .replacingOccurrences(of: "Finals", with: "F")
        .replacingOccurrences(of: "Semi ", with: "S")
        .replacingOccurrences(of: "Preliminary ", with: "P")
        .replacingOccurrences(of: "Grand ", with: "G")
    return newString
}

func weekDatesBetween(lastDate: Date, endDate: Date) -> [Date] {
    var dates: [Date] = []
    var currentDate = Calendar.current.date(byAdding: .day, value: 10, to: lastDate)!
    while currentDate <= endDate {
        dates.append(Calendar.current.date(byAdding: .day, value: -3, to: currentDate)!)
        currentDate = Calendar.current.date(byAdding: .weekOfYear, value: 1, to: currentDate)!
    }

    return dates
}

func ordinalSuffix(_ number: Int) -> String {
    switch number {
    case 11...13:
        return "th"
    default:
        switch number % 10 {
        case 1:
            return "st"
        case 2:
            return "nd"
        case 3:
            return "rd"
        default:
            return "th"
        }
    }
}

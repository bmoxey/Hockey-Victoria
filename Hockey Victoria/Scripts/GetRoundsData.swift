//
//  GetRoundsData.swift
//  Hockey Victoria
//
//  Created by Brett Moxey on 5/12/2023.
//

import Foundation

func GetRoundsData(mycomp: Teams) async -> ([RoundNum], String) {
    var errMsg = ""
    var lines: [String] = []
    var started: Bool = false
    var roundNames: [RoundNum] = []
    var count = 0
    (lines, errMsg) = GetUrl(url: "https://www.hockeyvictoria.org.au/games/" + mycomp.compID + "/&d=" + mycomp.divID)
    for i in 0 ..< lines.count {
        if lines[i].contains("https://www.hockeyvictoria.org.au/pointscores/") { started = true }
        if lines[i].contains("https://www.hockeyvictoria.org.au/games/") {
            if started {
                let mybit = String(lines[i]).split(separator: "\"")
                let myURL = String(mybit[1]).replacingOccurrences(of: "&amp;", with: "&")
                let roundName = lines[i+2]
                let date = lines[i+11].replacingOccurrences(of: ", ", with: "\n")
                if roundName != "/a" {
                    roundNames.append(RoundNum(num: count, text: roundName, date: date, url: myURL))
                }
                count += 1
            }
        }
    }
    return (roundNames, errMsg)
}

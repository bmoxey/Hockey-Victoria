//
//  Shorten.swift
//  Hockey Victoria
//
//  Created by Brett Moxey on 2/12/2023.
//

import Foundation

func ShortTeamName(fullName: String) -> String {
    let newString = fullName.replacingOccurrences(of: " Hockey", with: "")
        .replacingOccurrences(of: " Club", with: "")
        .replacingOccurrences(of: " Association", with: "")
        .replacingOccurrences(of: " Sports INC", with: "")
        .replacingOccurrences(of: " Section", with: "")
        .replacingOccurrences(of: " United", with: " Utd")
        .replacingOccurrences(of: "Hockey ", with: "")
        .replacingOccurrences(of: " University", with: " Uni")
        .replacingOccurrences(of: "Eastern Christian Organisation (ECHO)", with: "ECHO")
        .replacingOccurrences(of: "Melbourne High School Old Boys", with: "MHSOB")
        .replacingOccurrences(of: "Greater ", with: "")
        .replacingOccurrences(of: "St Bede's", with: "St. Bede's")
        .replacingOccurrences(of: "Khalsas", with: "Khalsa")
        .replacingOccurrences(of: " MM1", with: "")
        .replacingOccurrences(of: " MM2", with: "")
        .replacingOccurrences(of: " MW1", with: "")
        .replacingOccurrences(of: " MW2", with: "")
        .replacingOccurrences(of: " MW3", with: "")
        .replacingOccurrences(of: " GH", with: "")
    return newString
}

func ShortClubName(fullName: String) -> String {
    let newString = fullName.replacingOccurrences(of: " 1", with: "")
        .replacingOccurrences(of: " 2", with: "")
        .replacingOccurrences(of: " 3", with: "")
        .replacingOccurrences(of: " 4", with: "")
        .replacingOccurrences(of: " 60 A", with: "")
        .replacingOccurrences(of: " 60 B", with: "")
        .replacingOccurrences(of: " 60 C", with: "")
        .replacingOccurrences(of: "Southern A", with: "Southern Utd")
        .replacingOccurrences(of: "Southern B", with: "Southern Utd")
        .replacingOccurrences(of: "Southern C", with: "Southern Utd")
        .replacingOccurrences(of: " Black", with: "")
        .replacingOccurrences(of: " BLACK", with: "")
        .replacingOccurrences(of: " Blues", with: "")
        .replacingOccurrences(of: " Blue", with: "")
        .replacingOccurrences(of: " Navy", with: "")
        .replacingOccurrences(of: " Gold", with: "")
        .replacingOccurrences(of: " Yellow", with: "")
        .replacingOccurrences(of: " Red", with: "")
        .replacingOccurrences(of: " RED", with: "")
        .replacingOccurrences(of: " Silver", with: "")
        .replacingOccurrences(of: " Green", with: "")
        .replacingOccurrences(of: " Grey", with: "")
        .replacingOccurrences(of: " Jade", with: "")
        .replacingOccurrences(of: " Maroon", with: "")
        .replacingOccurrences(of: " Tangerine", with: "")
        .replacingOccurrences(of: " Lions", with: "")
        .replacingOccurrences(of: " Panthers", with: "")
        .replacingOccurrences(of: " Pumas", with: "")
        .replacingOccurrences(of: " Tigers", with: "")
        .replacingOccurrences(of: " White", with: "")
        .replacingOccurrences(of: " Cougars", with: "")
        .replacingOccurrences(of: " Cheetahs", with: "")
        .replacingOccurrences(of: " Leopards", with: "")
        .replacingOccurrences(of: " Sharks", with: "")
        .replacingOccurrences(of: " Knights", with: "")
        .replacingOccurrences(of: " Saffrons", with: "")
        .replacingOccurrences(of: " Cannons", with: "")
        .replacingOccurrences(of: " Ospreys", with: "")
        .replacingOccurrences(of: " Falcons", with: "")
        .replacingOccurrences(of: " Kestrels", with: "")
        .replacingOccurrences(of: " Modules", with: " Uni")
        .replacingOccurrences(of: " Monarchs", with: " Uni")
        .replacingOccurrences(of: " Vultures", with: "")
        .replacingOccurrences(of: " Unicorns", with: "")
        .replacingOccurrences(of: " Eagles", with: "")
        .replacingOccurrences(of: " LIGHTNING", with: "")
        .replacingOccurrences(of: " THUNDER", with: "")
        .replacingOccurrences(of: " U8", with: "")
        .replacingOccurrences(of: " U10", with: "")
        .replacingOccurrences(of: " U12", with: "")
        .replacingOccurrences(of: " U14", with: "")
        .replacingOccurrences(of: " U16", with: "")
        .replacingOccurrences(of: " - ", with: "")
        .replacingOccurrences(of: " -", with: "")
        .replacingOccurrences(of: "  HC", with: "")
        .replacingOccurrences(of: " HC", with: "")
        .replacingOccurrences(of: "Boxmakers", with: "Monash Uni")
        .replacingOccurrences(of: "Chumps", with: "KBH Brumbies")
        .replacingOccurrences(of: "Collions-X", with: "Collegians-X")
        .replacingOccurrences(of: "ECC", with: "Dandenong Warriors")
        .replacingOccurrences(of: "GDWHC", with: "Dandenong Warriors")
        .replacingOccurrences(of: "HHC", with: "Hawthorn")
        .replacingOccurrences(of: "OEMHC", with: "Old East Malvern")
        .replacingOccurrences(of: "OTGHC", with: "Old Trinity Grammarians'")
        .replacingOccurrences(of: "Old Xav's", with: "Old Xaverians")
        .replacingOccurrences(of: "Old Xavs", with: "Old Xaverians")
        .replacingOccurrences(of: "PHStK", with: "Powerhouse & St Kilda")
        .replacingOccurrences(of: "The Third Team", with: "Toorak East Malvern")
        .replacingOccurrences(of: "SUHC Social", with: "Southern Utd")
        .replacingOccurrences(of: "Sharks", with: "Cardinia Storm")
        .replacingOccurrences(of: "TEM", with: "Toorak East Malvern")
        .replacingOccurrences(of: "Toorak East MalvernHC", with: "Toorak East Malvern")
        .replacingOccurrences(of: "Southern", with: "Southern Utd")
        .replacingOccurrences(of: "Southern Utd Utd", with: "Southern Utd")
        .replacingOccurrences(of: "/", with: "-")
    return newString
}

func GetDivType(fullName: String) -> String {
    var newString = "Other 👽"
    if fullName.contains("Under") {newString = "mixed 👦🏻👧🏻" }
    if fullName.contains("U8") { newString = "mixed 👦🏻👧🏻"}
    if fullName.contains("U10") { newString = "mixed 👦🏻👧🏻"}
    if fullName.contains("U12") { newString = "mixed 👦🏻👧🏻"}
    if fullName.contains("U14") { newString = "mixed 👦🏻👧🏻"}
    if fullName.contains("U16") { newString = "mixed 👦🏻👧🏻"}
    if fullName.contains("U18") { newString = "mixed 👦🏻👧🏻"}
    if fullName.contains("Mixed") { newString = "mixed 👦🏻👧🏻" }
    if fullName.contains("Men") { newString = "Mens 👨🏻" }
    if fullName.contains("Women") { newString = "Womens 👩🏻" }
    if fullName.contains("Boy") { newString = "boys 👦🏻" }
    if fullName.contains("Girl") { newString = "girls 👧🏻" }
    if fullName.contains("+") && fullName.contains("Men") { newString = "vets Mens 👴🏻" }
    if fullName.contains("+") && fullName.contains("Women") { newString = "vets Womens 👵🏻" }
    return newString
}


func GetDivLevel(fullString: String) -> String {
    var newString: String = "Z"
    if fullString.contains("Premier League") {newString = "A"}
    if fullString.contains("Shield") {newString = "B"}
    if fullString.contains("Vic League") {newString = "C"}
    if fullString.contains("Pennant") {newString = "D"}
    if fullString.contains("Metro") {newString = "E"}
    if fullString.contains("District") {newString = "F"}
    if fullString.contains("U8") {newString = "A\(newString)"}
    if fullString.contains("U10") {newString = "B\(newString)"}
    if fullString.contains("U12") {newString = "C\(newString)"}
    if fullString.contains("U14") {newString = "D\(newString)"}
    if fullString.contains("U16") {newString = "E\(newString)"}
    if fullString.contains("U18") {newString = "F\(newString)"}
    return newString
}

func ShortDivName(fullName: String) -> String {
    var newString = fullName.replacingOccurrences(of: "GAME Clothing ", with: "")
    if let firstFourDigits = Int(newString.prefix(4)), firstFourDigits > 1000 { newString.removeFirst(4) }
    if let lastFourDigits = Int(newString.suffix(4)), lastFourDigits > 1000 { newString.removeLast(4) }
    newString = newString.trimmingCharacters(in: .whitespaces)
        .trimmingCharacters(in: .punctuationCharacters)
        .trimmingCharacters(in: .whitespaces)
    return newString
}

//
//  Teams.swift
//  Hockey Victoria
//
//  Created by Brett Moxey on 2/12/2023.
//

import Foundation
import SwiftData

@Model
class Teams: Identifiable, ObservableObject {
    var id: Int
    var compName: String
    var compID: String
    var divName: String
    var divID: String
    var divLevel: String
    var divType: String
    var teamName: String
    var teamID: String
    var clubName: String
    var isCurrent: Bool
    var isUsed: Bool
    
    init(id: Int, compName: String, compID: String, divName: String, divID: String, divLevel: String, divType: String, teamName: String, teamID: String, clubName: String, isCurrent: Bool, isUsed: Bool) {
        self.id = id
        self.compName = compName
        self.compID = compID
        self.divName = divName
        self.divID = divID
        self.divLevel = divLevel
        self.divType = divType
        self.teamName = teamName
        self.teamID = teamID
        self.clubName = clubName
        self.isCurrent = isCurrent
        self.isUsed = isUsed
    }
}

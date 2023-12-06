//
//  NoGameView.swift
//  Hockey Victoria
//
//  Created by Brett Moxey on 3/12/2023.
//

import SwiftUI

struct NoGameView: View {
    let myTeam: String
    let game: Game
    var body: some View {
        
        VStack {
            HStack {
                Text(game.result == "No Game" ? "No game this week" : "Bye this week")
                    .foregroundStyle(Color("DarkColor"))
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .lineLimit(nil)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                Spacer()
                DayBox(date: game.date)
                Text("")
                    .frame(width: 12)
            }
        }
        
    }
}

#Preview {
    NoGameView(myTeam: "MHSOB", game: Game())
}

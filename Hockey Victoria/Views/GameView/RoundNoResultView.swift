//
//  RoundNoResultView.swift
//  Hockey Victoria
//
//  Created by Brett Moxey on 6/12/2023.
//

import SwiftUI

struct RoundNoResultView: View {
    let myTeam: String
    let game: Game

    var body: some View {
        VStack {
            if game.message != "" {
                HStack {
                    Spacer()
                    Text("\(game.message)")
                        .foregroundStyle(Color(.purple))
                    Spacer()
                }
            }
            HStack {
                HStack {
                    Text("\(game.homeTeam)")
                        .foregroundStyle(Color("DarkColor"))
                        .fontWeight(game.homeTeam == myTeam ? .bold : .regular)
                        .multilineTextAlignment(.center)
                        .lineLimit(nil)
                    Spacer()
                }
                Text("vs")
                    .foregroundStyle(Color("DarkColor"))
                HStack {
                    Spacer()
                    Text("\(game.awayTeam)")
                        .foregroundStyle(Color("DarkColor"))
                        .fontWeight(game.awayTeam == myTeam ? .bold : .regular)
                        .multilineTextAlignment(.center)
                        .lineLimit(nil)
                }
            }
            HStack {
                Image(ShortClubName(fullName: game.homeTeam))
                    .resizable()
                    .frame(width: 75, height: 75)
                Spacer()
                DateBox(date: game.date)
                Spacer()
                Image(ShortClubName(fullName: game.awayTeam))
                    .resizable()
                    .frame(width: 75, height: 75)
            }
        }
    }
}
//
//#Preview {
//    RoundNoResultView(myTeam: "MHSOB", game: Game())
//}

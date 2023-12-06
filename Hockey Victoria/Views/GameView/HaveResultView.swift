//
//  HaveResultView.swift
//  Hockey Victoria
//
//  Created by Brett Moxey on 3/12/2023.
//

import SwiftUI

struct HaveResultView: View {
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
                VStack {
                    HStack {
                        Text("\(game.homeGoals)")
                            .foregroundStyle(Color("DarkColor"))
                            .fontWeight(game.homeTeam == myTeam ? .bold : .regular)
                            .font(.largeTitle)
                        Spacer()
                        Text(" \(game.result) ")
                            .foregroundStyle(Color(Color.black))
                            .fontWeight(.bold)
                            .font(.title3)
                            .background(BarBackground(result: game.result))
                        Spacer()
                        Text("\(game.awayGoals)")
                            .font(.largeTitle)
                            .fontWeight(game.awayTeam == myTeam ? .bold : .regular)
                            .foregroundStyle(Color("DarkColor"))
                    }
                }
                Image(ShortClubName(fullName: game.awayTeam))
                    .resizable()
                    .frame(width: 75, height: 75)
            }
            HStack {
                HStack {
                    if game.homeGoals > 0 {
                        Text(String(repeating: "●", count: game.homeGoals))
                            .foregroundStyle(game.homeTeam == myTeam ? Color.green : Color.red)
                            .font(.system(size:20))
                            .padding(.horizontal, 0)
                            .multilineTextAlignment(.leading)
                            .lineLimit(nil)
                    }
                    Spacer()
                }
                .frame(width: 100)
                Spacer()
                Text("@ \(game.field)")
                    .foregroundStyle(Color("DarkColor"))
                Spacer()
                HStack {
                    Spacer()
                    if game.awayGoals > 0 {
                        Text(String(repeating: "●", count: game.awayGoals))
                            .foregroundStyle(game.awayTeam == myTeam ? Color.green : Color.red)
                            .font(.system(size:20))
                            .padding(.horizontal, 0)
                            .multilineTextAlignment(.trailing)
                            .lineLimit(nil)
                            
                    }
                }
                .frame(width: 100)
            }
            
        }
        
        
    }
}

#Preview {
    HaveResultView(myTeam: "MHSOB", game: Game())
}

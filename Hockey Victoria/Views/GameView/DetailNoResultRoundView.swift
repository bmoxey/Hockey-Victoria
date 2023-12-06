//
//  DetailNoResultRoundView.swift
//  Hockey Victoria
//
//  Created by Brett Moxey on 4/12/2023.
//

import SwiftUI

struct DetailNoResultRoundView: View {
    var myTeam: String
    var round: Game
    var body: some View {
        let diff = Calendar.current.dateComponents([.day, .hour, .minute], from: Date.now, to: round.date)
        VStack {
            if round.message != "" {
                HStack {
                    Spacer()
                    Text("\(round.message)")
                        .foregroundStyle(Color(.purple))
                    Spacer()
                }
            }
            HStack {
                HStack {
                    Text("\(round.homeTeam)")
                        .foregroundStyle(Color("DarkColor"))
                        .fontWeight(round.homeTeam == myTeam ? .bold : .regular)
                        .multilineTextAlignment(.center)
                        .lineLimit(nil)
                    Spacer()
                }
                Text("vs")
                    .foregroundStyle(Color("DarkColor"))
                HStack {
                    Spacer()
                    Text("\(round.awayTeam)")
                        .foregroundStyle(Color("DarkColor"))
                        .fontWeight(round.awayTeam == myTeam ? .bold : .regular)
                        .multilineTextAlignment(.center)
                        .lineLimit(nil)
                }
            }
            HStack {
                Image(ShortClubName(fullName: round.homeTeam))
                    .resizable()
                    .frame(width: 75, height: 75)
                Spacer()
                DateBox(date: round.date)
                Spacer()
                Image(ShortClubName(fullName: round.awayTeam))
                    .resizable()
                    .frame(width: 75, height: 75)
            }
            if diff.day! >= 0 && diff.hour! >= 0 && diff.minute! >= 0 {
                HStack {
                    Spacer()
                    if diff.day! == 0 {
                        Text("Starts in \(diff.hour!) hours and \(diff.minute!) minutes")
                            .foregroundStyle(Color(.pink))
                    } else {
                        Text("Starts in \(diff.day!) days and \(diff.hour!) hours")
                            .foregroundStyle(Color(.pink))
                    }
                    Spacer()
                }
            } else {
                Text(" No result available. ")
                    .foregroundStyle(Color(.white))
                    .background(Color(.blue))
            }
        }
    }
}

#Preview {
    DetailNoResultRoundView(myTeam: "MHSOB", round: Game())
}

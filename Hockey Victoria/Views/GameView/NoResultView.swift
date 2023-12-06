//
//  NoResultView.swift
//  Hockey Victoria
//
//  Created by Brett Moxey on 3/12/2023.
//

import SwiftUI

struct NoResultView: View {
    let myTeam: String
    let game: Game
    var body: some View {
        
        let diff = Calendar.current.dateComponents([.day, .hour, .minute], from: Date.now, to: game.date)
        VStack {
            HStack {
                Image(ShortClubName(fullName: game.opponent))
                    .resizable()
                    .frame(width: 75, height: 75)
                VStack {
                    Text("vs")
                        .foregroundStyle(Color("DarkColor"))
                    Text("\(game.opponent)")
                        .foregroundStyle(Color("DarkColor"))
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .lineLimit(nil)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    Text("@ \(game.field)")
                        .foregroundStyle(Color("DarkColor"))
                }
                Spacer()
                DateBox(date: game.date)
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
    NoResultView(myTeam: "MHSOB", game: Game())
}

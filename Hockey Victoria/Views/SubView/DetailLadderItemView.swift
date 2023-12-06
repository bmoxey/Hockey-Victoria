//
//  DetailLadderItemView.swift
//  Hockey Victoria
//
//  Created by Brett Moxey on 4/12/2023.
//

import SwiftUI

struct DetailLadderItemView: View {
    let item: LadderItem
    let maxGames: Int
    let maxGoals: Int
    var body: some View {
        Section(header: CenterSection(title: "Ladder Position: \(item.pos)\(ordinalSuffix(item.pos))")) {
            HeaderTextView(text: "Results")
            HStack {
                Text("Win")
                    .foregroundStyle(Color("DarkColor"))
                    .frame(width: 50)
                ForEach(0 ..< item.wins, id: \.self) { _ in
                    Image(systemName: "checkmark.square.fill")
                        .foregroundColor(.green)
                        .frame(width: 10, height: 10)
                }
                Spacer()
                Text("\(item.wins)")
                    .foregroundStyle(Color("DarkColor"))
                    .frame(width: 40)
            }
            .listRowBackground(Color.white)
            .padding(.horizontal, -8)
            HStack {
                Text("Draw")
                    .foregroundStyle(Color("DarkColor"))
                    .frame(width: 50)
                ForEach(0 ..< item.draws, id: \.self) { _ in
                    Image(systemName: "minus.square.fill")
                        .foregroundColor(.orange)
                        .frame(width: 10, height: 10)
                }
                Spacer()
                Text("\(item.draws)")
                    .foregroundStyle(Color("DarkColor"))
                    .frame(width: 40)
            }
            .listRowBackground(Color.white)
            .padding(.horizontal, -8)
            HStack {
                Text("Loss")
                    .foregroundStyle(Color("DarkColor"))
                    .frame(width: 50)
                ForEach(0 ..< item.losses, id: \.self) { _ in
                    Image(systemName: "xmark.square.fill")
                        .foregroundColor(.red)
                        .frame(width: 10, height: 10)
                }
                Spacer()
                Text("\(item.losses)")
                    .foregroundStyle(Color("DarkColor"))
                    .frame(width: 40)
            }
            .listRowBackground(Color.white)
            .padding(.horizontal, -8)
            if item.byes > 0 {
                HStack {
                    Text("Bye")
                        .foregroundStyle(Color("DarkColor"))
                        .frame(width: 50)
                    ForEach(0 ..< item.byes, id: \.self) { _ in
                        Image(systemName: "hand.raised.square.fill")
                            .foregroundColor(.cyan)
                            .frame(width: 10, height: 10)
                    }
                    Spacer()
                    Text("\(item.byes)")
                        .foregroundStyle(Color("DarkColor"))
                        .frame(width: 40)
                }
                .listRowBackground(Color.white)
                .padding(.horizontal, -8)
                
            }
            if item.forfeits > 0 {
                HStack {
                    Text("Forfeit")
                        .foregroundStyle(Color("DarkColor"))
                        .frame(width: 60, alignment: .leading)
                    ForEach(0 ..< item.forfeits, id: \.self) { _ in
                        Image(systemName: "exclamationmark.square.fill")
                            .foregroundColor(.pink)
                            .frame(width: 10, height: 10)
                    }
                    Spacer()
                    Text("\(item.forfeits)")
                        .foregroundStyle(Color("DarkColor"))
                        .frame(width: 40)
                }
                .listRowBackground(Color.white)
                .padding(.horizontal, -8)
                
            }
            HeaderTextView(text: "Goals")
            HStack {
                Text("For")
                    .foregroundStyle(Color("DarkColor"))
                    .frame(width: 50, alignment: .leading)
                Text(String(repeating: "●", count: item.scoreFor))
                    .font(.system(size: 15))
                    .foregroundStyle(Color.green)
                    .padding(.vertical, 0)
                    .padding(.horizontal, -8)
                Spacer()
                Text("\(item.scoreFor)")
                    .foregroundStyle(Color("DarkColor"))
                    .frame(width: 40)
            }
            .listRowBackground(Color.white)
            .padding(.horizontal, -8)
            HStack {
                Text("Agst")
                    .foregroundStyle(Color("DarkColor"))
                    .frame(width: 50, alignment: .leading)
                Text(String(repeating: "●", count: item.scoreAgainst))
                    .font(.system(size: 15))
                    .foregroundStyle(Color.red)
                    .padding(.vertical, 0)
                    .padding(.horizontal, -8)
                Spacer()
                Text("\(item.scoreAgainst)")
                    .foregroundStyle(Color("DarkColor"))
                    .frame(width: 40)
            }
            .listRowBackground(Color.white)
            .padding(.horizontal, -8)
        }
    }
}

#Preview {
    DetailLadderItemView(item: LadderItem(), maxGames: 18, maxGoals: 100)
}

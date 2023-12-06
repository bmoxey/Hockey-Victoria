//
//  DetailLadderView.swift
//  Hockey Victoria
//
//  Created by Brett Moxey on 4/12/2023.
//

import SwiftUI

struct DetailLadderView: View {
    let myTeam: String
    let item: LadderItem
    var body: some View {
        HStack {
            Text("\(item.pos)")
                .frame(width: 20, alignment: .leading)
                .font(.footnote)
                .fontWeight(item.teamName == myTeam ? .bold : .regular)
                .foregroundStyle(Color("DarkColor"))
            Image(ShortClubName(fullName: item.teamName))
                .resizable()
                .frame(width: 45, height: 45)
                .padding(.vertical, -4)
            Text(item.teamName)
                .multilineTextAlignment(.leading)
                .lineLimit(nil)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                .fontWeight(item.teamName == myTeam ? .bold : .regular)
                .foregroundStyle(Color("DarkColor"))
            Text("\(item.diff)")
                .frame(width: 40, alignment: .trailing)
                .fontWeight(item.teamName == myTeam ? .bold : .regular)
                .foregroundStyle(Color("DarkColor"))
            Text("\(item.points)")
                .frame(width: 40, alignment: .trailing)
                .fontWeight(item.teamName == myTeam ? .bold : .regular)
                .foregroundStyle(Color("DarkColor"))
        }
    }
}

#Preview {
    DetailLadderView(myTeam: "MHSOB", item: LadderItem())
}

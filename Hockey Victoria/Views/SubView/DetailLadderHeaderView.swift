//
//  DetailLadderHeaderView.swift
//  Hockey Victoria
//
//  Created by Brett Moxey on 4/12/2023.
//

import SwiftUI

struct DetailLadderHeaderView: View {
    var body: some View {
        HStack {
            Text("Pos")
                .font(.footnote)
                .foregroundStyle(Color("LightColor"))
                .frame(width: 35, alignment: .leading)
            Text("Team")
                .font(.footnote)
                .foregroundStyle(Color("LightColor"))
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
            Text("GD")
                .font(.footnote)
                .foregroundStyle(Color("LightColor"))
                .frame(width: 40, alignment: .trailing)
            Text("Pts")
                .font(.footnote)
                .foregroundStyle(Color("LightColor"))
                .frame(width: 40, alignment: .trailing)
            Text("")
                .font(.footnote)
                .frame(width: 6)
        }
        .frame(height: 10)
    }
}

#Preview {
    DetailLadderHeaderView()
}

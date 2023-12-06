//
//  HeaderDivType.swift
//  Hockey Victoria
//
//  Created by Brett Moxey on 2/12/2023.
//

import SwiftUI

struct HeaderDivType: View {
    var divType: String
    var body: some View {
        HStack {
            Spacer()
            Text(divType).font(.largeTitle)
                .foregroundStyle(Color("DarkColor"))
            Spacer()
        }
    }
}

#Preview {
    HeaderDivType(divType: "Men's 👨🏻")
}

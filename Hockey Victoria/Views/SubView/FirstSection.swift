//
//  FirstSection.swift
//  Hockey Victoria
//
//  Created by Brett Moxey on 4/12/2023.
//

import SwiftUI

struct FirstSection: View {
    var index: Int
    var header: String
    var body: some View {
        if index == 0 {
            HStack {
                 Spacer()
                 Text(header)
                     .foregroundStyle(Color("DarkColor"))
                     .font(.subheadline)
                 Spacer()
             }
        }
    }
}

#Preview {
    FirstSection(index: 1, header: "Ladder")
}

//
//  CenterSection.swift
//  Hockey Victoria
//
//  Created by Brett Moxey on 4/12/2023.
//

import SwiftUI

struct CenterSection: View {
    var title: String
    var body: some View {
        HStack {
            Spacer()
            Text(title)
                .foregroundStyle(Color("DarkColor"))
                .font(.subheadline)
            Spacer()
        }
    }
}

#Preview {
    CenterSection(title: "Schedule")
}

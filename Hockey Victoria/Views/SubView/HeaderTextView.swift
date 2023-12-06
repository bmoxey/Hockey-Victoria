//
//  HeaderTextView.swift
//  Hockey Victoria
//
//  Created by Brett Moxey on 2/12/2023.
//

import SwiftUI

struct HeaderTextView: View {
    var text: String
    var body: some View {
        HStack {
            Spacer()
            Text(text)
                .foregroundStyle(Color("LightColor"))
                .font(.footnote)
            Spacer()
        }
        .frame(height: 10)
        .listRowBackground(Color("DarkColor"))
    }
}

#Preview {
    HeaderTextView(text: "This is the heading")
}

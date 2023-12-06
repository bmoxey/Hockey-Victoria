//
//  ErrorMessage.swift
//  Hockey Victoria
//
//  Created by Brett Moxey on 2/12/2023.
//

import SwiftUI

struct ErrorMessage: View {
    var errMsg: String
    var body: some View {
        ZStack {
            Color("LightColor").ignoresSafeArea(.all, edges: .all)
            VStack {
                Spacer()
                Image("DarkLogo")
                    .resizable()
                    .frame(width: 200, height: 73)
                Spacer()
                Text("Warning:")
                    .font(.largeTitle)
                    .foregroundStyle(Color("DarkColor"))
                Spacer()
                Text(errMsg)
                    .font(.title)
                    .foregroundStyle(Color("DarkColor"))
                Spacer()
                Spacer()
            }
        }
    }
}

#Preview {
    ErrorMessage(errMsg: "No data to display.")
}

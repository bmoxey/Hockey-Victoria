//
//  NoNetwork.swift
//  Hockey Victoria
//
//  Created by Brett Moxey on 2/12/2023.
//

import SwiftUI

struct NoNetwork: View {
    var body: some View {
        ZStack {
            Color("DarkColor").ignoresSafeArea(.all, edges: .all)
            VStack {
                Spacer()
                Image("LightLogo")
                    .resizable()
                    .frame(width: 200, height: 73)
                Spacer()
                Text("No Network Detected")
                    .font(.largeTitle)
                    .foregroundStyle(Color("LightColor"))
                Spacer()
                Image(systemName: "wifi.slash")
                    .foregroundStyle(Color.red)
                    .font(.system(size: 128))
                    .symbolEffect(.pulse, isActive: true)
                Spacer()
                Spacer()
            }
        }
    }
}

#Preview {
    NoNetwork()
}

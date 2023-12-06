//
//  LoadingView.swift
//  Hockey Victoria
//
//  Created by Brett Moxey on 2/12/2023.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {
            Color("LightColor").ignoresSafeArea(.all, edges: .all)
            VStack {
                Spacer()
                Image("DarkLogo")
                    .resizable()
                    .frame(width: 200, height: 73)
                Spacer()
                Text("Loading...")
                    .font(.largeTitle)
                    .foregroundStyle(Color("DarkColor"))
                Spacer()
                Spacer()
            }
        }
    }
}

#Preview {
    LoadingView()
}

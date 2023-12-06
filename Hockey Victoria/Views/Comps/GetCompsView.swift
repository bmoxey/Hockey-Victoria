//
//  GetCompsView.swift
//  Hockey Victoria
//
//  Created by Brett Moxey on 2/12/2023.
//

import SwiftUI

struct GetCompsView: View {
    @Binding var stillLoading: Bool
    @State private var comps: [Competitions] = []
    @State private var errMsg = ""
    @State private var selectedWeek = 1
    @State private var searching = false
    var body: some View {
        if comps.isEmpty {
            LoadingView()
                .task { (comps, errMsg) = await getComps() }
        } else {
            if errMsg != "" {
                ErrorMessage(errMsg: errMsg)
            } else {
                if !searching {
                    DetailSelectCompsView(searching: $searching, comps: $comps, selectedWeek: $selectedWeek)
                } else {
                    SearchCompsView(comps: comps, selectedWeek: selectedWeek, stillLoading: $stillLoading)
                }
            }
        }
    }
}

#Preview {
    GetCompsView(stillLoading: Binding.constant(true))
}

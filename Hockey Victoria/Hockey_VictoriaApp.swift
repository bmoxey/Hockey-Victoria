//
//  Hockey_VictoriaApp.swift
//  Hockey Victoria
//
//  Created by Brett Moxey on 2/12/2023.
//

import SwiftUI
import SwiftData

@main
struct Hockey_VictoriaApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(.dark)
        }
        .modelContainer(for: [Teams.self])
    }
}

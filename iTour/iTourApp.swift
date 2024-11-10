//
//  iTourApp.swift
//  iTour
//
//  Created by amin nazemzadeh on 11/5/24.
//

import SwiftData
import SwiftUI

@main
struct iTourApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                Tab("Destinations", systemImage: "map") {
                    ContentView()
                }

                Tab("Sights", systemImage: "mappin.and.ellipse") {
                    SightsView()
                }
            }
        }
        .modelContainer(for: Destination.self)
    }
}

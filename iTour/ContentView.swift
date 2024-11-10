//
//  ContentView.swift
//  iTour
//
//  Created by amin nazemzadeh on 11/5/24.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @State private var path = [Destination]()
    @State private var sortOrder = [
        SortDescriptor(\Destination.name),
        SortDescriptor(\Destination.date)
    ]
    @State private var searchText = ""
    @State private var date = Date.distantPast

    let now = Date.now

    var body: some View {
        NavigationStack(path: $path) {
            DestinationListingView(sort: sortOrder, searchText: searchText, minimumDate: date)
                .navigationDestination(for: Destination.self, destination: EditDestinationView.init)
                .navigationTitle("iTour")
                .searchable(text: $searchText)
                .toolbar {
                    Button("Add Destination", systemImage: "plus", action: addDestination)
                    Menu("Sort", systemImage: "arrow.up.arrow.down") {
                        Picker("Sort", selection: $sortOrder) {
                            Text("Name")
                                .tag([
                                    SortDescriptor(\Destination.name),
                                    SortDescriptor(\Destination.date)
                                ])
                            Text("Priority")
                                .tag([
                                    SortDescriptor(\Destination.priority, order: .reverse),
                                    SortDescriptor(\Destination.name)
                                ])
                            Text("Date")
                                .tag([
                                    SortDescriptor(\Destination.date),
                                    SortDescriptor(\Destination.name)
                                ])
                        }
                        .pickerStyle(.inline)

                        Picker("Date", selection: $date) {
                            Text("Show all destinations")
                                .tag(Date.distantPast)

                            Text("Show upcoming destinations")
                                .tag(now)
                        }
                    }
                }
        }
    }

    func addDestination() {
        let destination = Destination()
        modelContext.insert(destination)
        path = [destination]
    }
}

#Preview {
    ContentView()
}

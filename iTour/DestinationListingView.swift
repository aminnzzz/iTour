//
//  DestinationListingView.swift
//  iTour
//
//  Created by amin nazemzadeh on 11/5/24.
//

import SwiftData
import SwiftUI

struct DestinationListingView: View {
    @Environment(\.modelContext) var modelContext
    @Query var destinations: [Destination]

    var body: some View {
        List {
            ForEach(destinations) { destination in
                NavigationLink(value: destination) {
                    VStack(alignment: .leading) {
                        Text(destination.name)
                            .font(.headline)

                        Text(destination.date.formatted(date: .long, time: .shortened))
                    }
                }
            }
            .onDelete(perform: deleteDestinations)
        }
    }

    init(sort: [SortDescriptor<Destination>], searchText: String, minimumDate: Date) {
        _destinations = Query(
            filter: #Predicate {
                if searchText.isEmpty {
                    return $0.date > minimumDate
                } else {
                    return (
                        $0.name.localizedStandardContains(searchText) ||
                        $0.sights.contains { $0.name.localizedStandardContains(searchText) }
                    ) &&
                    $0.date > minimumDate
                }
            },
            sort: sort
        )
    }

    func deleteDestinations(_ indexSet: IndexSet) {
        for index in indexSet {
            let destination = destinations[index]
            modelContext.delete(destination)
        }
    }
}

#Preview {
    DestinationListingView(sort: [SortDescriptor(\Destination.name)], searchText: "", minimumDate: .distantPast)
}

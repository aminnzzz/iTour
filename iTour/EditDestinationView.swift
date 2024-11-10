//
//  EditDestinationView.swift
//  iTour
//
//  Created by amin nazemzadeh on 11/5/24.
//

import PhotosUI
import SwiftData
import SwiftUI

struct EditDestinationView: View {
    @Environment(\.modelContext) private var modelContext
    @Bindable var destination: Destination
    @State private var newSightName = ""

    @State private var photosItem: PhotosPickerItem?

    var sortedSights: [Sight] {
        destination.sights.sorted {
            $0.name < $1.name
        }
    }

    var body: some View {
        Form {
            Section {
                if let imageData = destination.image {
                    if let image = UIImage(data: imageData) {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                    }
                }

                PhotosPicker("Attach a photo", selection: $photosItem, matching: .images)
            }
            TextField("Name", text: $destination.name)
            TextField("Details", text: $destination.details, axis: .vertical)
            DatePicker("Date", selection: $destination.date)

            Section("Priority") {
                Picker("Priority", selection: $destination.priority) {
                    Text("Meh").tag(1)
                    Text("Maybe").tag(2)
                    Text("Must").tag(3)
                }
                .pickerStyle(.segmented)
            }

            Section("Sight") {
                ForEach(sortedSights) { sight in
                    Text(sight.name)
                }
                .onDelete(perform: deleteSight)

                HStack {
                    TextField("Add a new sight for \(destination.name)", text: $newSightName)

                    Button("Add", action: addNewSight)
                }
            }
        }
        .navigationTitle("Edit Destination")
        .navigationBarTitleDisplayMode(.inline)
        .onChange(of: photosItem) {
            Task {
                destination.image = try? await photosItem?.loadTransferable(type: Data.self)
            }
        }
    }

    func addNewSight() {
        guard !newSightName.isEmpty else { return }

        withAnimation {
            let newSight = Sight(name: newSightName)
            destination.sights.append(newSight)
            newSightName = String()
        }
    }

    func deleteSight(_ indexSet: IndexSet) {
        for index in indexSet {
            let sight = sortedSights[index]
            modelContext.delete(sight)
        }
    }
}

#Preview {
    EditDestinationView(
        destination: Destination(
            name: "Example Destination",
            details: "Example details go here and will automatically expand vertically as details are added"
        )
    )
    .modelContainer(
        try! ModelContainer(
            for: Destination.self,
            configurations: ModelConfiguration(
                isStoredInMemoryOnly: true
            )
        )
    )
}

//
//  Destination.swift
//  iTour
//
//  Created by amin nazemzadeh on 11/5/24.
//

import Foundation
import SwiftData

@Model
class Destination {
    var name: String
    var details: String
    var date: Date
    var priority: Int
    @Relationship(deleteRule: .cascade, inverse: \Sight.destination) var sights = [Sight]()
    @Attribute(.externalStorage) var image: Data?

    init(name: String = "", details: String = "", date: Date = .now, priority: Int = 2) {
        self.name = name
        self.details = details
        self.date = date
        self.priority = priority
    }
}

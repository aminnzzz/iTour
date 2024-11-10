//
//  Sight.swift
//  iTour
//
//  Created by amin nazemzadeh on 11/7/24.
//

import SwiftData
import SwiftUI

@Model
class Sight {
    var name: String
    var destination: Destination?

    init(name: String) {
        self.name = name
    }
}

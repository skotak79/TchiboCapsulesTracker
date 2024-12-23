//
//  Row.swift
//  CapsuleTracker
//

import Foundation

struct ContainerSection: Identifiable, Equatable {
    let name: String
    let items: [CapsuleContainer]
    var id: String { name }

    var isEmpty: Bool {
        items.isEmpty
    }
}

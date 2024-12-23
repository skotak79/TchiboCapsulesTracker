//
//  CoffeePreparation.swift
//  CapsuleTracker
//

enum CapsulePreparation: String, CaseIterable, Identifiable {
    case espresso, crema, regular
    var name: String {
        switch self {
        case .espresso:
            "Espresso"
        case .crema:
            "Caffè Crema"
        case .regular:
            "Coffee"
        }
    }

    var id: String { name }
}

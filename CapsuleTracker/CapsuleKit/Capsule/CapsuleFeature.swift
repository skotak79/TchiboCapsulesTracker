//
//  Feature.swift
//  CapsuleTracker
//

struct CapsuleFeature: Identifiable, Equatable, Hashable {
    var rating: FeatureRating
    var type: CapsuleFeatureType
    var name: String {
        type.name
    }

    var id: String {
        name
    }

    init?(type: CapsuleFeatureType, value: Int) {
        guard let rating = FeatureRating(rawValue: value) else { return nil }
        self.rating = rating
        self.type = type
    }
}

enum CapsuleFeatureType: String {
    case intensity, roasting, acidity, body
    var name: String { rawValue.capitalized }
}

enum FeatureRating: Int, Comparable, Hashable {
    case one = 1, two, three, four, five, six

    static func < (lhs: Self, rhs: Self) -> Bool {
        lhs.rawValue < rhs.rawValue
    }

    static var maxValue: Int {
        self.six.rawValue
    }
}

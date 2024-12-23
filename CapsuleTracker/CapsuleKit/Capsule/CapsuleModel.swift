struct CapsuleModel: Identifiable, Hashable, Sendable {
    var id: String { name }
    let name: String
    let shortDesc: String
    let isDecaff: Bool
    let features: [CapsuleFeature]
    let preparation: CapsulePreparation
    let isLimitedEdition: Bool
    let capsuleImageName: String
    var capsuleThumbnailImageName: String {
        capsuleImageName + "Thumbnail"
    }

    private init(
        name: String,
        shortDesc: String,
        isDecaff: Bool,
        features: [CapsuleFeature],
        preparation: CapsulePreparation,
        isLimitedEdition: Bool,
        capsuleImageName: String) {
            self.name = name
            self.shortDesc = shortDesc
            self.isDecaff = isDecaff
            self.features = features
            self.preparation = preparation
            self.capsuleImageName = capsuleImageName
            self.isLimitedEdition = isLimitedEdition
        }

    static func make(name: String,
                     shortDesc: String,
                     isDecaff: Bool = false,
                     features: [CapsuleFeature?],
                     preparation: CapsulePreparation = .espresso,
                     isLimitedEdition: Bool = false,
                     capsuleImageName: String) -> Self {
        let featuresUnwrapped = features.compactMap { $0 }
        return Self(
            name: name,
            shortDesc: shortDesc,
            isDecaff: isDecaff,
            features: featuresUnwrapped,
            preparation: preparation,
            isLimitedEdition: isLimitedEdition,
            capsuleImageName: capsuleImageName
        )
    }

}

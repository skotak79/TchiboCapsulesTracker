import SwiftUI

enum CoffeePreparation: String, CaseIterable, Identifiable {
    case expresso, crema, regular

    var id: String {
        rawValue
    }

    var description: String {
        switch self {
        case .crema:
            return "Caffè Crema"
        case .expresso:
            return "Espresso"
        case .regular:
            return "Cafe"
        }
    }
}

struct CapsuleModel: Identifiable, Equatable, Hashable {

    var id: String {
        name
    }
    let name: String
    let shortDesc: String

    let preparation: CoffeePreparation
    let recommendedPreparations: [CoffeePreparation]

    let edition: Edition?

    let isDecaff: Bool

    enum FeatureType: String, Hashable {
        case intensity, acidity, body, roasting
        var description: String {
            rawValue.capitalized
        }
    }
    
    let features: [Feature]
    let capsuleImageName: String
    var capsuleThumbnailImageName: String {
        capsuleImageName + "Thumbnail"
    }

    struct Feature: Identifiable, Hashable {
        let type: FeatureType
        var value: UInt8
        var name: String {
            type.description
        }
        var id: String {
            name
        }

        var featureValue: FeatureRating {
            let int = Int(value)
            return FeatureRating(rawValue: int)!
        }
        init(type: FeatureType, value: UInt8) {
            self.type = type
            self.value = value
        }
        init?(type: FeatureType, value: UInt8?) {
            guard let value else { return nil }
            self.init(type: type, value: value)
        }
    }

    enum FeatureRating: Int, Comparable {
        case one = 1
        case two = 2
        case three = 3
        case four = 4
        case five = 5
        case six = 6

        public static func < (lhs: Self, rhs: Self) -> Bool {
            lhs.rawValue < rhs.rawValue
        }
    }

// updated: FlavouredEdition, BaristaEdition

    enum Edition: String, Hashable, CaseIterable {
        case flavored
        case barista

        var description: String {
            switch self {
            case .flavored:
                return "Flavored Edition"
            case .barista:
                return "Barista Edition"
            }
        }
    }

    private init(name: String,
                 shortDesc: String,
                 preparation: CoffeePreparation,
                 recommendedPreparations: [CoffeePreparation],
                 edition: Edition?,
                 isDecaff: Bool,
                 features: [Feature],
                 capsuleImageName: String
    ) {
        self.name = name
        self.shortDesc = shortDesc
        self.preparation = preparation
        self.recommendedPreparations = recommendedPreparations
        self.edition = edition
        self.isDecaff = isDecaff
        self.features = features
        self.capsuleImageName = capsuleImageName
    }

    static func make(name: String,
                     shortDesc: String,
                     preparation: CoffeePreparation,
                     recommendedPreparations: [CoffeePreparation] = [],
                     edition: Edition? = nil,
                     isDecaff: Bool = false,
                     intensity: UInt8? = nil,
                     acidity: UInt8? = nil,
                     body: UInt8? = nil,
                     roasting: UInt8? = nil,
                     capsuleImage: String
    ) -> Self {
        let features_: [Feature] = [
            Feature(type: .intensity, value: intensity),
            Feature(type: .acidity, value: acidity),
            Feature(type: .body, value: body),
            Feature(type: .roasting, value: roasting)].compactMap { $0 }
        let recommendedPreparationTypes = recommendedPreparations.isEmpty ? [preparation] : recommendedPreparations
        return CapsuleModel(name: name,
                            shortDesc: shortDesc,
                            preparation: preparation,
                            recommendedPreparations: recommendedPreparationTypes,
                            edition: edition,
                            isDecaff: isDecaff,
                            features: features_,
                            capsuleImageName: capsuleImage
        )
    }
}
extension CapsuleModel {
    static let all: [CapsuleModel] = [
        .doubleChoc,
        .brasil,
        .intenseEspresso,
        .elegantEspresso,
        .caramel,
        .baristaCrema,
        .baristaEspresso,
        .colombia,
        .richAromaCrema,
        .decaff,
        .mildCrema,
        .wakeUpXXL,
        .mildCoffee,
        .coffeeIntense
        //   .toastedNut,
        //   .almondCookie,
        //       .whiteChoc,
        //       .tiramisu,
        //       .amarettini,
        //       .salvador,
        //       .vanilla,
        //        .india,
        //        .sunriseXL,
        //        .blackAndWhite,
    ]

//    static let toastedNut = Self.make(name: "Toasted Nut",
//                                      shortDesc: "Prażone orzechy laskowe i ciasteczka",
//                                      types: [.expresso],
//                                      edition: .flavored,
//                                      intensity: 5,
//                                      boxColorDescription: "orange", 
//                                      secondaryColorDescription: "yellow"
//    )

//    static let almondCookie = Self.make(name: "Almond Cookie",
//                                        shortDesc: "Chrupiące ciasteczko migdałowe z delikatną nutą wanilii",
//                                        types: [.expresso],
//                                        edition: .flavored,
//                                        intensity: 5,
//                                        boxColorDescription: "teal",
//                                        secondaryColorDescription: "orange")

    // Caffee Crema: 6, Espresso: 9, coffee: 2 , suma 17
    
    // Seria Cafissimo Flavoured Summer

    static let doubleChoc = Self.make(name: "Flavoured Edition Espresso Double Choc", 
                                      shortDesc: "Chocolate",
                                      preparation: .expresso,
                                      recommendedPreparations: [.expresso],
                                      edition: .flavored,
                                      intensity: 5,

                                      capsuleImage: "flavoured-espresso-double-choc"
                            )
    //
//    static let whiteChoc = Self(name: "Flavoured Edition Espresso Raspberry White Choc", shortDesc: "Biała czekolada i malina", types: [.expresso], edition: .CaffissimoFlavouredSummer, intensity: 5, boxColorDescription: "pink")
//
//    // Seria Cafissimo Flavoured Spring Edition
//
//    static let tiramisu = Self(name: "Flavoured Edition Espresso Tiramisu", shortDesc: "Gorzka czekolada", types: [.expresso], edition: .CaffissimoFlavouredSpring, intensity: 5, boxColorDescription: "brown")
//
//    static let amarettini = Self(name: "Flavoured Edition Espresso Amarettini", shortDesc: "Aromat ciasteczka migdałowego", types: [.expresso], edition: .CaffissimoFlavouredSpring, intensity: 5, boxColorDescription: "yellow")
//
//    // Seria Caffissimo Espresso
//

    static let brasil = Self.make(name: "Espresso Brasil",
                                  shortDesc: "Nutty notes",
                                  preparation: .expresso,
                                  recommendedPreparations: [.expresso],
                                  intensity: 6,
                                  acidity: 1,
                                  body: 6,
                                  roasting: 6,

                                  capsuleImage: "espresso-brasil"
    )

//    static let salvador = Self(name: "Espresso El Salvador", shortDesc: "Karmel", types: [.expresso], edition: .CafissimoEspresso, intensity: 4, acidity: 3, body: 4, roasting: 4, boxColorDescription: "orange")
//




    // color burgund
    static let intenseEspresso = Self.make(name: "Espresso Intense",
                                   shortDesc: "Intense aroma",
                                           preparation: .expresso,
                                   recommendedPreparations: [.expresso],
                                   intensity: 5, 
                                   roasting: 5,

                                           capsuleImage: "espresso-intense")

    static let elegantEspresso = Self.make(name: "Espresso elegant",
                                   shortDesc: "The fullness of aroma",
                                           preparation: .expresso,
                                   recommendedPreparations: [.expresso],
                                   intensity: 4, 
                                   roasting: 4,

                                           capsuleImage: "espresso-elegant"
    )

//
//    // Seria specjalność Cafissimo
//
//    static let vanilla = Self(name: "Espresso Vanilla", shortDesc: "Wanilia", types: [.expresso], edition: .Caffissimo, intensity: 4, boxColorDescription: "yellow")
//

    static let caramel = Self.make(name: "Espresso Caramel", 
                                   shortDesc: "Caramel with cream",
                                   preparation: .expresso,
                                   recommendedPreparations: [.expresso],
                                   intensity: 5,

                                   capsuleImage: "espresso-caramel")


//    // Seria Barista
//
    static let baristaCrema = Self.make(name: "Barista Edition Caffè Crema",
                                        shortDesc: "Blueberry notes",
                                        preparation: .crema,
                                        recommendedPreparations: [.crema],
                                        edition: .barista,
                                        intensity: 3, 
                                        roasting: 4,

                                        capsuleImage: "barista-edition-caffe-crema")

    // color burgund
    static let baristaEspresso = Self.make(name: "Barista Edition Espresso",
                                           shortDesc: "Delicate nutty notes",
                                           preparation: .expresso,
                                           recommendedPreparations: [.expresso],
                                           edition: .barista,
                                           intensity: 6,
                                           roasting: 6,

                                           capsuleImage: "barista-edition-espresso")


//
//    // Seria Cafissimo Caffè Crema
//

    static let colombia = Self.make(name: "Caffè Crema Colombia",
                                    shortDesc: "Lime",
                                    preparation: .crema,
                                    recommendedPreparations: [.crema],
                                    intensity: 4, 
                                    acidity: 5,
                                    body: 4,
                                    roasting: 3,

                                    capsuleImage: "caffe-crema-colombia")

//
//    static let india = Self(name: "Caffè Crema India", shortDesc: "Miód, słód", types: [.crema], edition: .CafissimoCaffèCrema, intensity: 5, acidity: 2, body: 5, roasting: 5, boxColorDescription: "blue")
//

    // ciemno pomaranczowy
    static let richAromaCrema = Self.make(name: "Caffè Crema Rich Aroma",
                                     shortDesc: "Intense flavor",
                                    preparation: .crema,
                                     recommendedPreparations: [.crema],
                                     intensity: 4,
                                     roasting: 4,

                                          capsuleImage: "caffe-crema-rich-aroma")

//
//    static let sunriseXL = Self(name: "Sunrise Coffee XL Caffe Crema", shortDesc: "Delikatny aromat palonej kawy", types: [.crema], edition: .CafissimoCaffèCrema, intensity: 2, roasting: 3, boxColorDescription: "yellow")
//

    // kolor ludzkiego ciala
    static let decaff = Self.make(
        name: "Caffè Crema Decaffeinated",
        shortDesc: "Delicate, aromatic",
        preparation: .crema,
        recommendedPreparations: [.crema, .expresso],
        isDecaff: true,
        intensity: 3,
        roasting: 3,

        capsuleImage: "caffe-crema-decaffeinated")
//
    static let mildCrema = Self.make(
        name: "Caffè Crema mild",
        shortDesc: "Mild aroma",
        preparation: .crema,
        recommendedPreparations: [.crema],
        intensity: 3,
        roasting: 3,

        capsuleImage: "caffe-crema-mild")
//
    static let wakeUpXXL = Self.make(
        name: "Caffè Crema Wake Up XL",
        shortDesc: "Intense aroma",
        preparation: .crema,
        recommendedPreparations: [.crema],
        intensity: 4,

        capsuleImage: "caffe-crema-wake-up-xl")
//
//
//    // Seria Arabika tchibo caffisimo caffee
//
//    static let blackAndWhite = Self(name: "FOR BLACK 'N WHITE", shortDesc: "Intensywny smak", types: [.regular], edition: .CafissimoCoffee, intensity: 5, roasting: 6, boxColorDescription: "gray")
//
    static let mildCoffee = Self.make(
        name: "Coffee mild",
        shortDesc: "Mild aroma",
        preparation: .regular,
        recommendedPreparations: [.regular],
        intensity: 3,
        roasting: 3,

        capsuleImage: "coffee-mild")
//
    static let coffeeIntense = Self.make(
        name: "Coffee Intense",
        shortDesc: "Delicately spicy flavor",
        preparation: .regular,
        recommendedPreparations: [.regular],
        intensity: 4,
        roasting: 4,
        
        capsuleImage: "coffee-intense-aroma")
}

// let redColor = UIColor().named("red")
#warning("remove color extension!")
extension UIColor {
    public func named(_ name: String) -> UIColor? {
        let allColors: [String: UIColor] = [
            "black": .black,
            "teal": .systemTeal,
            "white": .white,
            "red": .red,
            "brown": .brown,
            "yellow": .yellow,
            "green": .green,
            "orange": .orange,
            "blue": .blue,
            "pink": .systemPink,
            "gray": .gray,
            "purple": .purple,

            // purple - blueish
            "indigo": .systemIndigo
        ]
        let cleanedName = name.replacingOccurrences(of: " ", with: "").lowercased()
        return allColors[cleanedName]
    }
}

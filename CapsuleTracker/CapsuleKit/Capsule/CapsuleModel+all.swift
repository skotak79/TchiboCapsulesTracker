extension CapsuleModel {
    static let all: [Self] = [

        // Coffee

        .coffeeIntense,
        .coffeeMild,

        // Cafe Crema

        .baristaCrema,
        .decaff,
        .cremaColombia,
        .cremaRichAroma,
        .cremaWakeUpXL,
        .cremaMild,
        .cremaBrasil,

        // Espresso x12

        .espressoBrasil,
        .espressoCaramel,
        .espressoCremeBrulee,
        .espressoElegant,
        .espressoDoubleChoc,
        .espressoTiramisu,
        .espressoIntense,
        .espressoBarista,
        .coconutEspresso,
        .buttertoffeeEspresso,
        .toastedNutEspresso,
        .whiteChocAndRasberryEspresso
    ]

    // ------ caffe crema

    static let cremaBrasil = make(
        name: "Cafissimo Caffe Crema Limited Edition Brasil",
        shortDesc: "Nutty and chocolate notes",
        features: [
            CapsuleFeature(type: .intensity, value: 5),
            CapsuleFeature(type: .roasting, value: 5)
        ],
        preparation: .crema,
        isLimitedEdition: true,
        capsuleImageName: "crema-Brasil")

    static let baristaCrema = make(
        name: "Barista Crema",
        shortDesc: "Nutty Notes",
        features: [
            CapsuleFeature(type: .intensity, value: 4),
            CapsuleFeature(type: .roasting, value: 4)
        ],
        preparation: .crema,
        capsuleImageName: "barista-edition-caffe-crema")

    static let decaff = make(
        name: "Caffee Cream Decaffeinated",
        shortDesc: "Delicate, aromatic",
        isDecaff: true,
        features: [
            CapsuleFeature(type: .intensity, value: 3),
            CapsuleFeature(type: .roasting, value: 3)
        ],
        preparation: .crema,
        capsuleImageName: "caffe-crema-decaffeinated")

    static let cremaColombia = make(
        name: "Crema Colombia",
        shortDesc: "Lime",
        features: [
            CapsuleFeature(type: .intensity, value: 4),
            CapsuleFeature(type: .acidity, value: 5),
            CapsuleFeature(type: .body, value: 4),
            CapsuleFeature(type: .roasting, value: 3)
        ],
        preparation: .crema,
        capsuleImageName: "caffe-crema-colombia")

    static let cremaMild = make(
        name: "Crema Mild",
        shortDesc: "Mild aroma",
        features: [
            CapsuleFeature(type: .intensity, value: 3),
            CapsuleFeature(type: .roasting, value: 3)
        ],
        preparation: .crema,
        capsuleImageName: "caffe-crema-mild")

    static let cremaRichAroma = make(
        name: "Crema Rich Aroma",
        shortDesc: "Intensive taste",
        features: [
            CapsuleFeature(type: .intensity, value: 4),
            CapsuleFeature(type: .roasting, value: 4)
        ],
        preparation: .crema,
        capsuleImageName: "caffe-crema-rich-aroma")

    static let cremaWakeUpXL = make(
        name: "Sunrise Coffee XL Caffe Crema",
        shortDesc: "Delicate aroma of roasted caffee",
        features: [
            CapsuleFeature(type: .intensity, value: 2),
            CapsuleFeature(type: .roasting, value: 3)
        ],
        preparation: .crema,
        capsuleImageName: "caffe-crema-wake-up-xl")

    // ------ espresso

    static let espressoBarista = make(
        name: "Barista Edition Espresso",
        shortDesc: "Delicate Nutty Notes",
        features: [
            CapsuleFeature(type: .intensity, value: 6),
            CapsuleFeature(type: .roasting, value: 6)
        ],
        capsuleImageName: "barista-edition-espresso")

    static let espressoBrasil = make(
        name: "Espresso Brasil",
        shortDesc: "Nutty notes",
        features: [
            CapsuleFeature(type: .intensity, value: 6),
            CapsuleFeature(type: .acidity, value: 1),
            CapsuleFeature(type: .body, value: 6),
            CapsuleFeature(type: .roasting, value: 6)
        ],
        capsuleImageName: "espresso-brasil")

    static let espressoCaramel = make(
        name: "Espresso Caramel",
        shortDesc: "Carmel with Cream",
        features: [
            CapsuleFeature(type: .intensity, value: 5),
            CapsuleFeature(type: .roasting, value: 0)
        ],
        isLimitedEdition: true,
        capsuleImageName: "espresso-caramel")

    static let espressoElegant = make(
        name: "Espresso Elegant",
        shortDesc: "Fullness of aroma",
        features: [
            CapsuleFeature(type: .intensity, value: 4),
            CapsuleFeature(type: .roasting, value: 4)
        ],
        capsuleImageName: "espresso-elegant")

    static let espressoIntense = make(
        name: "Espresso Intense",
        shortDesc: "Intensive aroma",
        features: [
            CapsuleFeature(type: .intensity, value: 5),
            CapsuleFeature(type: .roasting, value: 5)
        ],
        capsuleImageName: "espresso-intense")

    static let espressoCremeBrulee = make(
        name: "Espresso Creme Brulle",
        shortDesc: "Typical note of Creme Brulee",
        features: [
            CapsuleFeature(type: .intensity, value: 4)
        ],
        capsuleImageName: "flavoured-creme-brulle")

    static let espressoDoubleChoc = make(
        name: "Flavored Edition Espresso Double Choc",
        shortDesc: "Chocolate",
        features: [
            CapsuleFeature(type: .intensity, value: 5)
        ],
        isLimitedEdition: true,
        capsuleImageName: "flavoured-espresso-double-choc")

    static let espressoTiramisu = make(
        name: "Espresso Tiramisu",
        shortDesc: "Bitter chocolate",
        features: [
            CapsuleFeature(type: .intensity, value: 5)
        ],
        isLimitedEdition: true,
        capsuleImageName: "flavoured-espresso-tiramisu")

    static let coconutEspresso = make(
        name: "Flavoured Edition Espresso White Choc & Coconut",
        shortDesc: "White chocolate and coconut",
        features: [
            CapsuleFeature(type: .intensity, value: 6)],
        isLimitedEdition: true,
        capsuleImageName: "espresso-white-choc-coconut")

    static let buttertoffeeEspresso = make(
        name: "Flavoured Edition Espresso Buttertoffee",
        shortDesc: "Butter Toffee",
        features: [
            CapsuleFeature(type: .intensity, value: 4)
        ],
        isLimitedEdition: true,
        capsuleImageName: "espresso-buttertoffee")

    static let toastedNutEspresso = make(
        name: "Flavoured Edition Espresso Toasted Nut",
        shortDesc: "Roasted hazelnuts and cookies",
        features: [
            CapsuleFeature(type: .intensity, value: 5)
        ],
        isLimitedEdition: true,
        capsuleImageName: "espresso-toasted-nut")

    static let whiteChocAndRasberryEspresso = make(
        name: "Flavoured Edition Espresso White Choc & Rasberry",
        shortDesc: "White chocolate and raspberries",
        features: [
            CapsuleFeature(type: .intensity, value: 5)
        ],
        isLimitedEdition: true,
        capsuleImageName: "espresso-raspberry-white-choc")

    // Caffee

    static let coffeeMild = make(
        name: "Coffee mild",
        shortDesc: "Mild aroma",
        features: [
            CapsuleFeature(type: .intensity, value: 3),
            CapsuleFeature(type: .roasting, value: 3)
        ],
        preparation: .regular,
        capsuleImageName: "coffee-mild")

    static let coffeeIntense = make(
        name: "Coffee Intense",
        shortDesc: "Delicately spicy flavor",
        features: [
            CapsuleFeature(type: .intensity, value: 4),
            CapsuleFeature(type: .roasting, value: 4)
        ],
        preparation: .regular,
        capsuleImageName: "coffee-intense-aroma")
}

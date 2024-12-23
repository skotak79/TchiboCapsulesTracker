//
//  CapsuleContainer.swift
//  CapsuleTracker
//

struct CapsuleContainer: Identifiable, Equatable, Hashable, Sendable {
    var id: CapsuleModel.ID { capsule.id }
    let capsule: CapsuleModel
    let quantity: UInt

    func decreaseQuantityByOneIfPossible() -> Self? {
        guard quantity > 0 else { return nil }
        return Self(capsule: capsule, quantity: quantity - 1)
    }

    func increaseQuantityByOne() -> Self {
        Self(capsule: capsule, quantity: quantity + 1)
    }

    var owned: Bool {
        quantity > 0
    }

    func matches(searchText: String) -> Bool {
        if searchText.isEmpty {
            return true
        }
        if capsule.name.localizedCaseInsensitiveContains(searchText) {
            return true
        }
        return capsule.shortDesc.localizedCaseInsensitiveContains(searchText)
    }

    static let example: Self = Self(capsule: .baristaCrema, quantity: 0)
}

// MARK: CapsuleContainerArray+extension

extension [CapsuleContainer] {
    func filteredBy(preparation: CapsulePreparation) -> Self {
        self.filter { $0.capsule.preparation == preparation }
    }

    func regularExpresso() -> Self {
        self.filter { $0.capsule.preparation == .espresso && !$0.capsule.isLimitedEdition}
    }

    func flavoredEditions() -> Self {
        self.filter { $0.capsule.preparation == .espresso && $0.capsule.isLimitedEdition }
    }
}

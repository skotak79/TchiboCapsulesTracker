//
//  CapsuleGrouping.swift
//  CapsuleTracker
//

class CapsuleGrouping {

    func group(_ containers: [CapsuleContainer]) -> [ContainersList.ListSection: [CapsuleContainer]] {
        var result: [ContainersList.ListSection: [CapsuleContainer]] = [:]
        for section in ContainersList.ListSection.allCases {
            let items = makeSection(containers, for: section).items
            if !items.isEmpty {
                result[section] = items
            }
        }
        return result
    }

    private func makeSection(
        _ containers: [CapsuleContainer],
        for section: ContainersList.ListSection) -> ContainerSection {

        switch section {
        case .crema:
            return ContainerSection(name: section.name, items:
                                        containers.filteredBy(preparation: .crema))
        case .coffee:
            return ContainerSection(name: section.name, items: containers.filteredBy(preparation: .regular))
        case .espresso:
            return ContainerSection(name: section.name, items: containers.regularExpresso())
        case .flavored:
            return ContainerSection(name: section.name, items: containers.flavoredEditions())
        }
    }
}

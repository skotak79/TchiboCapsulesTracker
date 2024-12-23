//
//  FilteredContainersTests.swift
//  CapsuleTracker
//

import Testing
@testable import CapsuleTracker

struct FilteredContainersTests {

    @Test func filteredContainersReturnsEmpty() {
        let containers: [CapsuleContainer] = []

        let filtered = containers.filteredContainers()

        #expect(filtered.isEmpty)
    }

    @Test func filteredContainersReturnsContainerWithSearchText() {
        var containers: [CapsuleContainer] = []

        containers.append(CapsuleContainer(capsule: .baristaCrema, quantity: 1))
        containers.append(CapsuleContainer(capsule: .buttertoffeeEspresso, quantity: 1))

        let filtered = containers.filteredContainers(searchText: "bar")
        #expect(filtered.count == 1)
    }

    @Test func filteredContainersReturnsOwnedContainer() {
        var containers: [CapsuleContainer] = []

        containers.append(CapsuleContainer(capsule: .baristaCrema, quantity: 1))
        containers.append(CapsuleContainer(capsule: .buttertoffeeEspresso, quantity: 0))
        let filtered = containers.filteredContainers(showOwned: true)
        #expect(filtered.count == 1)
    }

}

//
//  ContainersProvider.swift
//

import Testing
@testable import CapsuleTracker

private actor QuantityStoreFake: QuantityStoreProtocol {
    var quantities: [CapsuleQuantityPersisted] = []

    init(quantities: [CapsuleQuantityPersisted] = []) {
        self.quantities = quantities
    }

    func loadAll() async -> [CapsuleQuantityPersisted] {
        quantities
    }

    func saveAll(_ quantities: [CapsuleQuantityPersisted]) async {
        self.quantities = quantities
    }
}

private extension ContainersProviderProtocol {

    var ownedCapsuleModels: [CapsuleModel] {
        containers.filter(\.self.owned).map(\.self.capsule)
    }
    var ownedCapsuleModelsIsEmpty: Bool {
        ownedCapsuleModels.isEmpty
    }
}

struct MainModelTests {

    @MainActor
    @Test func whenInitializedWithEmptyQuantityStore_OwnedCapsulesIsEmpty() async throws {
        let quantityStoreStub = QuantityStoreFake()
        let sut = ContainersProvider(quantityStore: quantityStoreStub)
        try await sut.loadContainers()
        #expect(!sut.containers.isEmpty)
        #expect(sut.ownedCapsuleModelsIsEmpty)
    }

    @MainActor
    @Test func whenInitializedWithNonEmptyQuantitiesStore_OwnedCapsulesIsNotEmpty() async throws {
        let memoryStoreStub = QuantityStoreFake(
            quantities: [
                CapsuleQuantityPersisted(
                    capsuleID: CapsuleModel.coconutEspresso.id,
                    value: 2
                )
            ]
        )
        let sut = ContainersProvider(quantityStore: memoryStoreStub)
        try await sut.loadContainers()
        #expect(!sut.containers.isEmpty)
        #expect(!sut.ownedCapsuleModelsIsEmpty)
        #expect(sut.ownedCapsuleModels.count == 1)
        #expect(sut.ownedCapsuleModels.first!.id == CapsuleModel.coconutEspresso.id)
    }

    @MainActor
    @Test func modelSavesQuantityCorrectly() async throws {
        let quantityStoreMock = QuantityStoreFake()
        let sut = ContainersProvider(quantityStore: quantityStoreMock)
        try await sut.loadContainers()
        let container = sut.containers.first!
        let bindined = sut.getBindingOfContainer(container.id)

        #expect(bindined != nil)

        let updated = bindined!.wrappedValue.increaseQuantityByOne()
        bindined!.wrappedValue = updated
        await sut.saveAll()

        await #expect(quantityStoreMock.quantities.count == 1)
    }

    @MainActor
    @Test
    func getBindingOfContainerReturnsNil_IfContainerIsNotPresentInProvider() async throws {
        let sut = ContainersProvider()
        let containerToFind = CapsuleContainer(
            capsule: CapsuleModel.make(
                name: "",
                shortDesc: "",
                features: [],
                preparation: .crema,
                capsuleImageName: ""),
            quantity: 0)

        #expect(sut.getBindingOfContainer(containerToFind.id) == nil)
    }
}

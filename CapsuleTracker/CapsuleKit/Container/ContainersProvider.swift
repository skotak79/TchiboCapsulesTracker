import SwiftUI
import Observation

@Observable
class ContainersProvider {

    init(quantityStore: QuantityStoreProtocol = QuantityPersistentStore()) {
        self.quantityStore = quantityStore
    }

    private let quantityStore: QuantityStoreProtocol
    private var capsules: [CapsuleModel] = CapsuleModel.all

    var containers: [CapsuleContainer] = []

    @MainActor
    func loadContainers() async throws {
        let quantities = await quantityStore.loadAll()
        var containers = [CapsuleContainer]()

        containers = capsules.map { capsule in
            let index = quantities.firstIndex(where: { $0.capsuleID == capsule.id })
            let quantity = index != nil ? quantities[index!].value : 0
            return CapsuleContainer(capsule: capsule, quantity: quantity)
        }
        self.containers = containers
    }

    @MainActor
    func saveAll() async {
        let quantities = containers
            .filter { $0.owned }
            .map { CapsuleQuantityPersisted(
                capsuleID: $0.id,
                value: $0.quantity)
            }
        await quantityStore.saveAll(quantities)
    }

    // MARK: Container Binding

    @MainActor
    func getBindingOfContainer(_ containerID: CapsuleContainer.ID) -> Binding<CapsuleContainer>? {
        guard let container = self.getContainer(id: containerID) else { return nil }
        return Binding<CapsuleContainer>(
            get: {
                return container
            },
            set: { container  in
                self.updateContainer(container: container)
            }
        )
    }

    // MARK: - Private functions

    private func getContainer(id: CapsuleModel.ID) -> CapsuleContainer? {
        if let index = firstIndex(id: id) {
            return containers[index]
        }
        return nil
    }

    @MainActor
    private func updateContainer(container: CapsuleContainer) {
        if let index = firstIndex(id: container.id) {
            containers[index] = container
        }
    }

    private func firstIndex(id: String) -> Int? {
        return containers.firstIndex(where: {$0.id == id})
    }
}

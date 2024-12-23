protocol QuantityStoreProtocol: Sendable {
    func loadAll() async -> [CapsuleQuantityPersisted]
    func saveAll(_ quantities: [CapsuleQuantityPersisted]) async
}

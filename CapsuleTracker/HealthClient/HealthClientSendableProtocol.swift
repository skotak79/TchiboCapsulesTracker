//
//  HealthClientSendableProtocol.swift
//  CapsuleTracker
//

protocol HealthClientSendableProtocol: Sendable {
    nonisolated
    func healthAccessAuthorized() -> Bool
    func requestPermisson() async -> Bool
    func addCoffeine(amountInMiligrams: Double) async throws
}

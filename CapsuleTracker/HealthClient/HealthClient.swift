//
//  HealthClientActor.swift
//  CapsuleTracker

import HealthKit

actor HealthClientActor: HealthClientSendableProtocol {

    nonisolated
    func healthAccessAuthorized() -> Bool {
        return store.authorizationStatus(for: caffeineSamplesType) == .sharingAuthorized
    }

    private let store = HKHealthStore()
    private let caffeineSamplesType = HKQuantityType(.dietaryCaffeine)

    func requestPermisson() async -> Bool {
        do {
            try await store.requestAuthorization(
                toShare: [caffeineSamplesType],
                read: []
            )
            return true
        } catch {
            print(error.localizedDescription)
            return false
        }
    }

    func addCoffeine(amountInMiligrams: Double) async throws {
        let miligrams = HKUnit.gramUnit(with: .milli)
        let mgCaffeineQuantity = HKQuantity(unit: miligrams, doubleValue: amountInMiligrams)
        let caffeineSample = HKQuantitySample(
            type: caffeineSamplesType,
            quantity: mgCaffeineQuantity,
            start: Date(),
            end: Date())
        try await store.save(caffeineSample)
    }
}

extension HKUnit: @unchecked Sendable {}
extension HKQuantitySample: @unchecked @retroactive Sendable {}

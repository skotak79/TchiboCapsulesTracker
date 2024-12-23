//
//  LogCapsuleServiceProtocol.swift
//  CapsuleTracker
//

import Observation

protocol LogCapsuleServiceProtocol: Observable {
    var isHealthAccessAuthorized: Bool { get }
    @MainActor func askIfHealthAuthorized()
    @MainActor func requestPermission() async
    @MainActor func logCapsule(id: CapsuleModel.ID, amountInMiligrams: Double) async
}

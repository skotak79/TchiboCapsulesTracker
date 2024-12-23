//
//  HealthControllerPreview.swift
//  CapsuleTracker
//

import Observation

@Observable
final class LogCapsuleServicePreview: LogCapsuleServiceProtocol {

    var isHealthAccessAuthorized: Bool

    init(isHealthAccessAuthorized: Bool = true) {
        self.isHealthAccessAuthorized = isHealthAccessAuthorized
    }

    func askIfHealthAuthorized() {}
    @MainActor func requestPermission() async {}
    @MainActor func logCapsule(id: CapsuleModel.ID, amountInMiligrams: Double) async {}

    @MainActor
    static let authorized = LogCapsuleServicePreview()

    @MainActor
    static let denied = LogCapsuleServicePreview(isHealthAccessAuthorized: false)
}
